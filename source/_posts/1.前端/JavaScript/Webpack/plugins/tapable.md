---
title: tapable
toc: true
date: 2020-03-20 00:00:01
tags:
---

【[参考资料](https://www.my-fe.pub/post/tapable-note.html#tapasync)】
【[官网文档](https://github.com/webpack/tapable)】

## hookType
* Sync
	* Bail 其中一个不返回null就停止后续执行
	* Waterfall 一个一个执行，类似Promise
	* Loop 一直执行到`return true`
* ASync 都会有callback参数
	* Series* 串行
	* Parallel* 并行


## 注册回调
Sync的hook仅支持使用tap来注册事件，而Async的支持tap, tapAsync, tapPromise
```js
let { AsyncParallelHook } = require('tapable');
let queue = new AsyncParallelHook(['name']);
console.time('cost');
queue.tapAsync('1', (name, callback) => {
  setTimeout(() => {
    console.log(1);
    callback();
  }, 1000)
});
```

* hooks.xxx.intercept 拦截
* context: hooks方法间数据共享


## webpack与Tapable的关系
* webpack会提前注册好很多像下面代码的`Complier`钩子类并定义好每一种钩子的执行逻辑，比如Async或者Sync；而这些`Complier`都是基于`Tapable`
* 然后在webpack核心代码里面去插入钩子的执行函数，比如`complier.hooks.run.call(compilation)`
* 这样外部就可以通过插件的形式注册适当的钩子回调函数来介入到webpack的处理逻辑
* 其实插件也可以自己定义hooks，然后供其他插件来介入该插件的逻辑 `myPlogin.hooks.xxxfn.call()`

```js
// SyncBailHook(["xxx"])  xxx是约定好回调函数里会带上的参数
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
