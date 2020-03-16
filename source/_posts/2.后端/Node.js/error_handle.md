---
title: 错误处理
toc: true
date: 2020-03-02 00:00:04
tags:
---

[TODO]

```js
process.on('uncaughtException', (err, origin) => {
  console.error(err);
  // 可以上报错误

  // 可以自行决定是否退出  
  process.exit(1);
});

setTimeout(() => {
  throw Error('some error');
})
```
