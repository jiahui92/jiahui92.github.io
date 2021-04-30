---
title: mobx
toc: true
date: 2020-03-07 00:00:00
---

# 调试
## spy
项目复杂后，值可能会被别的地方修改，但是又找不到时
* 非observer的值（正常的值）可以尝试使用Proxy
* observer的值可以使用spy

```js
import { spy } from 'mobx';

spy((event) => {
  // spy能值被修改后监听到，从而知道myProps在哪里被修改了
  if ((event.key || '').includes(/myProp/i)) {
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
mobx监听到值变更后，会调用React的`this.forceUpdate()，所以在同时发生多个变更时，使用runInAction来减少更新次数
```js
runInAction(() => {
  this.myProp1 = 1;
  this.myProp2 = 2;
  this.myProp3 = 3;
})
```
