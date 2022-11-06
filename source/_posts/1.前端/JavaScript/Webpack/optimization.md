---
title: 优化
toc: true
date: 2020-03-20 00:00:05
tags:
---


首先使用工具检查哪一部分需要优化【[参考资料](https://mp.weixin.qq.com/s/mo8V3p-ex3mNdScBqJk5gQ)】



## 大小优化
[webpack-bundle-analyzer](https://github.com/webpack-contrib/webpack-bundle-analyzer): 查看打包后各模块体积大小

### tree-shaking
```sh
# 这两种模式都会开启tree-shaking
webpack --mode production
webpack --optimize--minimize
```

* tree-shaking必须要使用import来按需引用，`require`不支持；比如关闭babel的modules编译模式，防止import被编译成require导致webpack的tree-shaking失效
```js
// .babelrc
{
  "presets": [
    "env", { "modules": false }
  ]
}
```

* 减少使用IIFE/立即函数调用
* 适时设置packsge.json`sideEffects:false`，删掉无影响的副作用代码；"没有副作用"这个短语可以被解释为"不与顶层模块以外的东西进行交互"（比如没有设置window变量）；在b模块中虽然有一些副作用的代码(IIFE和更改全局变量/属性的操作)，但是我们不认为删除它是有风险的，比如console.log；【[参考资料](https://juejin.im/post/5bb8ef58f265da0a972e3434#heading-15)】


### code splitting
* entry vendor: 指定包名称来拆分公共代码 【[参考资料](/wiki/1.前端/JavaScript/Webpack/config/entry_output)】
* split chunk: 更细粒度地拆分公共代码，比如按使用次数【[参考资料](/wiki/1.前端/JavaScript/Webpack/config/optimization_chunks)】
* [css-extract](https://webpack.js.org/plugins/mini-css-extract-plugin/#install)
* 对于react-router这类SPA项目来说，可以结合`import()`来做代码拆分并动态加载；


### CDN
[参考资料](/wiki/1.前端/z.框架_源码_原理/Plugin/head#html-webpack-plugin)
```js
{
  externals: {
    jquery: 'jQuery',
  },
  plugins: [
    new HtmlWebpackPlugin({({
      title: 'Custom template',
      template: 'index.html',
      files: {
        js: [
          'https://ajax.googleapis.com/ajax/libs/jquery/2.2.2/jquery.min.js',
        ],
      }
    })
  ]
}
```

### 其它
* 按需引入
* 压缩


## 时间优化

### 调试
* [webpack4 ProfilingPlugin](https://webpack.js.org/plugins/profiling-plugin/)
* [cpuprofile-webpack-plugin](https://github.com/jantimon/cpuprofile-webpack-plugin)
  * [实例：基于nodejs的"node --prof"日志以及服务器cpu-profile采集](http://www.codebaoku.com/it-js/it-js-266100.html)
* [speed-measure-webpack-plugin](https://github.com/stephencookdev/speed-measure-webpack-plugin)



### 获取和解析依赖的时间
```js
{
  noParse: /jquery/, // 不处理jquery，也可以将其抽到cdn

  resolve: {
    modules: [ // 指定require查找路径
      path.resolve('src'),
      path.resolve('node_modules'),
    ],

    // 不带后缀的引用仅尝试以下值
    extension: ['.js']
  },

  alias: {
    utils: path.resolve('src/utils'),
  }，

  ... {
    // loader优化
    rules: {
      ...,
      exclude: /node_modules/,
    }
  }
  
}
```


### 打包时间
[happypack](https://github.com/amireh/happypack): 并行打包loader；
```js
plugins = [
  new HappyPack({
    // 需要并行执行的loader
    loaders: [ 'babel-loader?presets[]=es2015' ]
  })
];
```
webpack4中使用[thread-loader](https://github.com/webpack-contrib/thread-loader)
```js
module.exports = {
  module: {
    rules: [
      {
        test: /\.js$/,
        include: path.resolve("src"),
        use: [
          "thread-loader",
          // your expensive loader (e.g babel-loader)
        ]
      }
    ]
  }
}
```



### 压缩时间
* webpack3中
  * UglifyJsPlugin单线程压缩
  * ParallelUglifyPlugin多线程压缩
* webpack4中默认使用`terser-webpack-plugin`
```js
module.exports = {
  optimization: {
    minimizer: [
      new TerserPlugin({
        parallel: true,
      }),
    ],
  },
};
```

### 二次打包的时间
[cache-loader](https://github.com/webpack-contrib/cache-loader)
```js
module.exports = {
  module: {
    rules: [
      {
        test: /\.js$/,
        use: ['cache-loader', 'babel-loader'],
        include: path.resolve('src'),
      },
    ],
  },
};
```

[HardSourceWebpackPlugin](https://github.com/mzgoddard/hard-source-webpack-plugin)，可以代替cache-loader
```js
{
  plugins: [
    new HardSourceWebpackPlugin({
      // Either a string of object hash function given a webpack config.
      configHash: function(webpackConfig) {
        // node-object-hash on npm can be used to build this.
        return require('node-object-hash')({sort: false}).hash(webpackConfig);
      },
      // lockfile发生变化会重新打包, Either false, a string, an object, or a project hashing function. 
      environmentHash: {
        root: process.cwd(),
        directories: [],
        files: ['package-lock.json', 'yarn.lock'],
      },
      // An object.
      info: {
        // 'none' or 'test'.
        mode: 'none',
        // 'debug', 'log', 'info', 'warn', or 'error'.
        level: 'debug',
      },
      // Clean up large, old caches automatically.
      cachePrune: {
        // Caches younger than `maxAge` are not considered for deletion. They must
        // be at least this (default: 2 days) old in milliseconds.
        maxAge: 2 * 24 * 60 * 60 * 1000,
        // All caches together must be larger than `sizeThreshold` before any
        // caches will be deleted. Together they must be at least this
        // (default: 50 MB) big in bytes.
        sizeThreshold: 50 * 1024 * 1024
      },
    }),
  ]
}
```
