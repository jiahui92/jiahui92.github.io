---
title: Ant Design
toc: true
date: 2020-03-11 00:00:01
tags:
---

或者读读rc-component的组件封装代码

https://github.com/ant-design/ant-design/blob/master/components/notification/index.tsx

## 目录结构
* notification
  * \_\_tests\_\_
    * snapshot
      * demo.test.js.snap
    * index.test.js
    * demo.test.js
    * hooks.test.js
    * placement.test.js
  * demo
    * basic.md
    * custom-icon.md
    * ...
  * style
  * index.tsx
  * ...
* other-component

### 组件测试
```js
for (let i = 0; i < 5; i += 1) {
  notification.open({
    message: 'Notification Title',
    duration: 0,
    prefixCls: 'additional-holder',
  });
}

const count = document.querySelectorAll('.additional-holder').length;
expect(count).toEqual(1);
```

### demo的snapshot测试
所有的demo测试逻辑都放在`~/tests/shared/demoTest.js`中，其会生成一个snapshot，然后于`demo.test.js.snap`进行对比
```js
testMethod(`renders ${file} correctly`, () => {
  MockDate.set(moment('2016-11-22'));
  const demo = require(`../.${file}`).default; // eslint-disable-line global-require, import/no-dynamic-require
  const wrapper = render(demo);

  // Convert aria related content
  // 删除所有随机id"f7fa7a3c-a675-47bc-912e"
  ariaConvert(wrapper);

  expect(wrapper).toMatchSnapshot();
  MockDate.reset();
});
```
