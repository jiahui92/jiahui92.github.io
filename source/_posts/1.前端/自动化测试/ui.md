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
* testcafe会在已打包好的代码基础之上再编译一次，所以后续可能会出现“线上环境正常，而自动化测试环境中报错”的情况；此时就需要在本地启动自动化测试环境去排查问题；
* 安装testcafe： `npm i -g testcafe`
```js
// 创建 myTest.js
fixture `Getting Started`
  // 这里改成要测试的url
  .page `http://baidu.com"`
test('My first test', async t => {
  // 在测试代码中加入debug将页面停止
  await t.debug()
});
```
* 命令行运行 `testcafe remote myTest.js`，打开输出的链接
* 在浏览器中点击底部工具栏的"unLock Page"解锁页面，然后手动执行后续的报错操作，并在chrome devtools中调试排查问题
