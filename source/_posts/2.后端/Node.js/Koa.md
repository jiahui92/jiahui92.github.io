---
title: Koa
toc: true
date: 2020-03-02 00:00:01
tags:
---

## 常用库
* koa-router
* koa-static
* koa-body
* koa-session
* koa-cors
* koa-logger
* koa-compress: 开启gzip
* [koa-jwt](https://juejin.im/post/5c009f02f265da616301c978): jsonWebToken
* [koa-helmet](https://cnodejs.org/topic/5a502debafa0a121784a89c3): httpHeader安全相关（最好做在nginx层）
* koa-convert: 将koa1和koa2插件互转
* eggjs：基于koa，但是内置了很多适用于企业建站的插件；比如log和jwt



## 中间件&插件
```js
app.use(logFn())

module.exports = function logFn (options) {
  return function (ctx, next) {
    // 如果是插件只执行一次
    if (ctx.logFn) return next();
    ctx.logFn = xxx
  }
}
```

### 洋葱模型
![](/img/Snip20200302_1.png)

```js
function someMiddleware(ctx, next) {
  // before code: 比如到达接口之前提前序列化一下ctx.body
  next(); // 先去执行下一个中间件
  // after code: 比如给response的值处理一下
}
```

### 原理
【[参考资料](https://juejin.im/post/5bab0c415188255c8473b123)】

```js
let app = {
  middlewares:[];//缓存队列
  use(fn){//注册中间件
    this.middlewares.push(fn);
  }
} 
app.use(koaStatic())
app.use(koaRouter())

// next就是middlewares里面的一个middlewareFn，这样子配合起来就可以构成洋葱模型

// 合并成一个连续执行函数
function compose (ms) {
  return ms.reduce((a,b)=>{
    return (arg)=>{
      a(()=>{b(arg)}) 
    }
  });
}

compose(app.middlewares)()
```



## 其他
* pm2部署代码
* 错误监听：app.on('error', (err, ctx) => {})
* 最外层中间件处理所有中间件错误（洋葱模型最佳运用？）

```js
const handler = async (ctx, next) => {
  try {
    await next();
  } catch (err) {
    ctx.response.status = err.statusCode;
    ctx.response.body = {
      message: err.message
    }
  }
}

const main = ctx => {
  ctx.throw(500)
}

app.use(handler)
app.use(main)
```
