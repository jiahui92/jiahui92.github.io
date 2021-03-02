---
title: index
toc: true
date: 2020-03-11 00:00:01
tags:
---

* E2E: nightwatch, [cypress](https://github.com/cypress-io/cypress)
  * 快照/html对比
* [vue-component](https://cn.vuejs.org/v2/cookbook/unit-testing-vue-components.html)


# testcafe
## debug
testcafe会在已打包好的代码基础之上再编译一次，所以后续可能会出现“正常环境不报错，而测试环境中报错”的情况；此时就需要在测试环境中去排查问题；
```js
// 在测试代码中加入debug将页面停止，然后点击页面工具栏的"unLock Page"，手动执行后续的报错操作，并在chrome devtools中调试排查问题
test('submitStatus', async t => {
  await t
      .debug()
})
```
```sh
## 正常情况下，可以用以下方式打开chrome进行测试
testcafe chrome myTest.js
## 在WSL2可通过remote启动服务，并手动打开测试页面
testcafe remote myTest.js
```
