---
title: index
toc: true
date: 2020-03-20 00:00:01
tags:
---

## 常用插件
* html-webpack-plugin
* clean-webpack-plugin
* progress-bar-webpack-plugin: 打包进度条
* webpack-manifest-plugin: 生成manifest.json

### webpack4自带插件
* MiniCssExtractPlugin 抽离css
* UglifyJsPlugin 压缩代码
* ParallelUglifyPlugin 并行压缩代码
* HotModuleReplacementPlugin


## 开发插件前的准备
使用`hook`来开发插件，让开发者几乎可以介入到任意的webpack`构建流程`中。【[参考资料](https://juejin.im/post/5bdc1c1651882516f5784c34)】


主要构建流程 | hook |
---------|----------|
 Compilation | run,compile,compilation,make,emit,done
 Compiler | buildModule,normalModuleLoader,succeedModule,finishModule,seal,optimize,after-seal
 Module Factory | beforeResolver,afterResolver,module,parser
 Parser | program,statement,call,expression
 Template Factory | hash,bootstrap,localVars,render


上表是主要用到的钩子；要学会使用钩子，首先要了解三件事情
* webpack打包的主要流程
* 哪些流程触发哪些钩子
* 钩子是怎么被触发的

其次
* 主要有哪些钩子
* 这些钩子都返回什么参数
* Tapable



### webpack打包的主要流程
【[参考资料](https://github.com/wzx365/min-webpack)】
* `Complier`: 可以简单的理解为全局唯一的 Webpack 实例，它包含了当前webpack.cofig.js的配置信息；
* `Compliation`: 包含编译的一整个过程，可获取到`Module Factory`；当监听到文件发生改变时，Webpack 会创建一个新的 Compilation 对象，开始一次新的编译；
  * `Module Factory`: `resolve`递归找到每一个模块，同时可获取到`Parse`；
    * `Parse`: 调用loader开始处理，然后生成ast
* `Template Factory`: 生成文件，处理output配置（路径、文件名等）、external等

![](/img/Snip20200321_1.png)


### 哪些流程触发哪些钩子
【[参考资料](https://juejin.im/post/5badd0c5e51d450e4437f07a)】
![](/img/Snip20200321_2.png)


### 钩子是怎么被触发的
下图触发了两个钩子`Complier.entryOption`和`Complier.afterPlugins`，以及在中途开始注册webpack.config中的plugins
```js
#! /usr/bin/env node    
const path = require('path');
const Compiler = require('../lib/Compiler');
let options = require(path.resolve('webpack.config.js'));

let compiler = new Compiler(options); 
let {plugins} = options; //获取webpack.config.js中的plugns进行注册


/*************************/
compiler.hooks.entryOption.call(); //触发entryOptions hook

plugins.forEach(plugin => { // 注册plugins
    plugin.apply(compiler)
});

compiler.hooks.afterPlugins.call(), //触发afterPlugins hook
/*************************/

compiler.run();
```




## 插件开发
```js
class xxxxPlugin{
  //new xxxxPlugin(options)
  constructor(options) {
    this.options=options;
  }
  apply(compiler) {
    //往钩子上注册回调
    compiler.hooks.xxxx.tap('xxxxPlugin', ()=> {
      //TODO执行的逻辑
    });
  }
}
module.exports=xxxxPlugin;


// 基本使用
complier.hooks.someHook.tap // 注册 
complier.hooks.someHook.call // 调用 
```

webpack钩子注册事件是用的Tapable库，支持多种方法注册【[参考资料](/wiki/1.前端/JavaScript/Webpack/plugins/tapable)】
* tap
* tapAsync
* tapPromise


### AutoExternalPlugin源码
每个都可以定义自己的钩子，方便其他插件介入该插件的流程，比如该插件使用了html-webpack-plugin的hook【[参考资料](https://juejin.im/post/5bdc1c1651882516f5784c34)】
```js
// webpack.config.js
{
  plugins: [
    new HtmlWebpackPlugin({
      template: "./src/index.html",
      filename: "index.html"
    }),
    new AutoExternalPlugin({
      jquery: {
        varName: "jQuery",
        url: "https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.js"
      }
    })
  ],
}
```

```js
const ExternalModule = require("webpack/lib/ExternalModule");
class AutoExternalPlugin {
  constructor(options) {
    this.options = options;
    //记录外部模块
    this.externalModules = {};
  }

  apply(compiler) {

    compiler.hooks.normalModuleFactory.tap("AutoExternalPlugin", normalModuleFactory => {

        normalModuleFactory.hooks.parser
          .for("javascript/auto")
          .tap("AutoExternalPlugin", parser => {
            // statement = "import $ from 'jquery'"
            // source = "jquery";
            parser.hooks.import.tap("AutoExternalPlugin", (statement, source) => {
                if (this.options[source]) {
                  // 记录哪些地方用了外部模块
                  this.externalModules[source] = true;
                }
              }
            );
          });
        
        normalModuleFactory.hooks.factory.tap("AutoExternalPlugin", factory => (data, callback) => {
            const dependency = data.dependencies[0];
            let value = dependency.request; // jquery
            if (this.externalModules[value]) {
              // 将webpack_require改成window引入
              // let $ = window.jQuery;
              callback(null, new ExternalModule(this.options[value].varName, "window"));
            } else {
              factory(data, callback);
            }
          }
        );


      }
    );

    compiler.hooks.compilation.tap("InlinePlugin", compilation => {
      // 这里使用了html-webpack-plugin的hook
      compilation.hooks.htmlWebpackPluginAlterAssetTags.tapAsync(
        "InlinePlugin",
        (htmlData, callback) => {
          Object.keys(this.externalModules).forEach(key => {
            // 插入到html中
            htmlData.body.unshift({
              tagName: "script",
              closeTag: true,
              attributes: {
                type: "text/javascript",
                src: this.options[key].url
              }
            });
          });
          callback(null, htmlData);
        }
      );
    });
  }
}
module.exports = AutoExternalPlugin;
```
