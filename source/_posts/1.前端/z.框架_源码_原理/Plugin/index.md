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


# Function.options
```js
// 通过对象的形式拓展参数
function someAjax1 (options) {
  options = {
    someData: [1,2,3],
    success () {}
    ...(options || {})
  }
  ...
}

// 通过fn来修改options
function someAjax2 (fn = () => {}) {
  options = {
    someData: [1,2,3],
    success () {}
  }

  fn(options)
  ...
}

someAjax2((options) => {
  // 可以操作数组，而第一种只能整个覆盖
  options.someData[0] = 3;
})
```


# Vue
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


# Koa
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



# Webpack
比较复杂，基于Tapable，暴露实例以及钩子函数（几乎可以介入任何生命周期，反正不够就继续加钩子，然后插入到核心代码任意一行中。。。）【[参考资料:webpack插件开发](/wiki/1.前端/JavaScript/Webpack/plugins/index)】【[参考资料:Tapable](/wiki/1.前端/JavaScript/Webpack/plugins/tapable)】
