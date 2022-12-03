---
title: mobx
toc: true
date: 2020-03-07 00:00:00
---

# 原理
`reaction(expression, effect)`
## expression
`reaction.expression`函数主要做两件事情
* 收集需要监听的变量
* 对return结果进行`===`判断是否需要执行effect
```js
// 假设items是个深度监听的变量
const items = observer.deep([{a:1, b:2}]);

// 例子1：
reaction(() => {
  return items.slice();
}, () => {})

// 例子2：当items.a发生变化时，会触发effect
reaction(() => {
  const arr = items.map(t => t.a);
  return arr;
}, () => {})

// 例子3：当items.a发生变化，并且值发生变化时，才会触发effect
reaction(() => {
  const arr = items.map(t => t.a);
  return arr.join(',');
}, () => {})

// 触发effect：例子1
items[0].b = 1;
// 触发effect：例子1,2
items[0].a = 1;
// 触发effect：例子1,2,3
items[0].a = 2;
```


# 调试
## spy
项目复杂后，值可能会被别的地方修改，但是又找不到时
* 非observer的值（正常的值）可以尝试使用Proxy
* observer的值可以使用spy

```js
import { spy } from 'mobx';

spy((event) => {
  // spy能值被修改后监听到，从而知道myProps在哪里被修改了
  if ((event.key || '').includes("myProp")) {
    debugger;
  }
})

const obj = observe({ myProp: 1 });
obj.myProps = 2;
setTimeout(() => {
  obj.myProps = 3;
}, 3000)
```

## trace
输出所有observer值改变的调用栈
```js
autorun('loggerzz', r => {
  r.trace()
  console.log(assetAddCategory.value)
})
```

# 优化
mobx监听到值变更后，会调用React的`this.forceUpdate()`，所以在同时发生多个变更时，使用`runInAction`来减少更新次数
```js
runInAction(() => {
  this.myProp1 = 1;
  this.myProp2 = 2;
  this.myProp3 = 3;
})
```
