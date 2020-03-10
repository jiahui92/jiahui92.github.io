---
title: 插件
toc: true
date: 2020-03-07 00:00:00
---

插件系统的好坏对应着拓展性，其次也要优雅易用
* 往小了看就像是 函数封装得好不好（传options对象还是多个参数）
* 往大了看就是 给某个框架做拓展？vue-cli的webpack chain？


目前看到的方法
* 暴露构造函数或实例
* 提供钩子函数


## Vue
给plugin暴露Vue的`globalAPI`或`prototype`来追加属性
```js
MyPlugin.install = function (Vue, options) {
  // 1. 添加全局方法或属性
  Vue.myGlobalMethod = function () {
    // 逻辑...
  }

  // 2. 添加全局资源
  Vue.directive('my-directive', {
    bind (el, binding, vnode, oldVnode) {
      // 逻辑...
    }
    ...
  })

  // 3. 注入组件选项
  Vue.mixin({
    created: function () {
      // 逻辑...
    }
    ...
  })

  // 4. 添加实例方法
  Vue.prototype.$myMethod = function (methodOptions) {
    // 逻辑...
  }
}
```


## Koa
在插件回调函数里暴露实例`ctx`和`next`，构成洋葱模型
```js
module.exports = function logFn (options) {
  return function (ctx, next) {
    // 如果是插件只执行一次，如果是中间件则不用这一行
    if (ctx.logFn) return next();
    // 往实例里写入插件方法
    ctx.logFn = xxx
  }
}
```



## Webpack
比较复杂，基于Tapable，暴露实例以及钩子函数（几乎可以介入任何生命周期，反正不够就继续加钩子，然后插入到核心代码任意一行中。。。）【[参考资料](https://blog.csdn.net/qdmoment/article/details/102818283)】
* webpack会提前注册好很多像`Complier`的钩子类，并定义好每一种钩子的执行逻辑，比如Async或者Sync
* 然后在webpack核心代码里面去插入钩子的执行函数，比如`complier.hooks.run.call(compilation)`
* 这样外部就可以通过插件的形式注册适当的钩子回调函数来介入到webpack的处理逻辑
* 其实插件也可以自己定义hooks，然后供其他插件来介入该插件的逻辑 `myPlogin.hooks.xxxfn.call()`
```js
class Compiler extends Tapable {
  constructor(context) {
    super();
    this.hooks = {
      /** @type {SyncBailHook<Compilation>} */
      shouldEmit: new SyncBailHook(["compilation"]),
      /** @type {AsyncSeriesHook<Stats>} */
      done: new AsyncSeriesHook(["stats"]),
      /** @type {AsyncSeriesHook<>} */
      additionalPass: new AsyncSeriesHook([]),
      /** @type {AsyncSeriesHook<Compiler>} */
      beforeRun: new AsyncSeriesHook(["compiler"]),
      /** @type {AsyncSeriesHook<Compiler>} */
      run: new AsyncSeriesHook(["compiler"]),
      /** @type {AsyncSeriesHook<Compilation>} */
      emit: new AsyncSeriesHook(["compilation"]),
      /** @type {AsyncSeriesHook<string, Buffer>} */
      assetEmitted: new AsyncSeriesHook(["file", "content"]),
      /** @type {AsyncSeriesHook<Compilation>} */
      afterEmit: new AsyncSeriesHook(["compilation"]),
 
      /** @type {SyncHook<Compilation, CompilationParams>} */
      thisCompilation: new SyncHook(["compilation", "params"]),
      /** @type {SyncHook<Compilation, CompilationParams>} */
      compilation: new SyncHook(["compilation", "params"]),
      /** @type {SyncHook<NormalModuleFactory>} */
      normalModuleFactory: new SyncHook(["normalModuleFactory"]),
      /** @type {SyncHook<ContextModuleFactory>}  */
      contextModuleFactory: new SyncHook(["contextModulefactory"]),
 
      /** @type {AsyncSeriesHook<CompilationParams>} */
      beforeCompile: new AsyncSeriesHook(["params"]),
      /** @type {SyncHook<CompilationParams>} */
      compile: new SyncHook(["params"]),
      /** @type {AsyncParallelHook<Compilation>} */
      make: new AsyncParallelHook(["compilation"]),
      /** @type {AsyncSeriesHook<Compilation>} */
      afterCompile: new AsyncSeriesHook(["compilation"]),
 
      /** @type {AsyncSeriesHook<Compiler>} */
      watchRun: new AsyncSeriesHook(["compiler"]),
      /** @type {SyncHook<Error>} */
      failed: new SyncHook(["error"]),
      /** @type {SyncHook<string, string>} */
      invalid: new SyncHook(["filename", "changeTime"]),
      /** @type {SyncHook} */
      watchClose: new SyncHook([]),
 
      /** @type {SyncBailHook<string, string, any[]>} */
      infrastructureLog: new SyncBailHook(["origin", "type", "args"]),
 
      // TODO the following hooks are weirdly located here
      // TODO move them for webpack 5
      /** @type {SyncHook} */
      environment: new SyncHook([]),
      /** @type {SyncHook} */
      afterEnvironment: new SyncHook([]),
      /** @type {SyncHook<Compiler>} */
      afterPlugins: new SyncHook(["compiler"]),
      /** @type {SyncHook<Compiler>} */
      afterResolvers: new SyncHook(["compiler"]),
      /** @type {SyncBailHook<string, Entry>} */
      entryOption: new SyncBailHook(["context", "entry"])
    };
    }
}
```