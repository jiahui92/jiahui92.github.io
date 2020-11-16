---
title: Promise
toc: true
date: 2020-08-16 00:00:01
---

Promise的出现是为了解决回调地狱的问题，但出现await后，大部分场景都用不上了。await不能替代promise的场景
* Promise.all
* Promise.race


Promise的三个状态
* pending
* fulfilled
* rejected



* then注册函数里的异步执行函数用的是[immediate](https://juejin.im/post/5a30193051882503dc53af3c)库（microtask兼容库）
* 自己实现的精简版，但不符合A+规范
https://github.com/jiahui92/playground/blob/master/promise/promise.js


## 链式调用为什么要返回新的promise
* 这样每一层都方便管理自己的rejectArr
```js
const p = new Promise(() => {});
p.then(() => {}).then(() => {});
// 后续还可以继续往p后追加then
p.then(()=> {});
```

## Promise.js源码的意义
### async与await相对于Promise
```js
async function fn1() {
  return 1;
}

async function fn2() {
  return await 1;
}

fn1(); // Promise
await fn1(); // 1
fn2(); // Promise
await fn2(); // 1
```

### Promise和proxy触发的then
```js
```

### Promise的thenable测试以及串联执行
```js
Promise.resolve(1).then(res => {
  alert(res); // 1
  return Promise.resolve(2);
}).then(res => {
  alert(res); // 2
  return res;
})
```


## Promise.all vs for-await-of
* for循环执行promise的坑
* https://stackoverflow.com/questions/59694309/for-await-of-vs-promise-all

