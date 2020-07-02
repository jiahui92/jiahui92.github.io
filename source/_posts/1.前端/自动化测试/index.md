---
title: index
toc: true
date: 2020-03-11 00:00:00
tags:
---



# 权衡
【[参考资料](https://zh-hans.reactjs.org/docs/testing.html)】
* 迭代速度与覆盖的真实环境
* 覆盖的范围，具体到按钮或文案
* 重构对测试代码的影响：skuSDK单元测试的反思
  * 注意要考虑测试代码的可维护性，可以只比较部分的对象值；假如一整个对象都得一模一样，一旦改变了返回值，测试代码都得一起改，这个成本不一定愿意承担；所以一种平衡的办法是只测试里面重要的值，对于组件测试来说就是只测试里面重要的属性/UI；甚至将拼接的文案拆开返回，只测试其中重要的值，比如`价格：¥19.1`，只测试`19.1`；
  * 相比直接测API的返回值，也可以考虑测得更细一点，比如某个function；这样报错时容易定位错误，但测试用例可能会变得有点业务无关。



# 工具
* 单元测试: jest, mocha
	* 代码覆盖率 istanbul
* E2E: nightwatch, [cypress](https://github.com/cypress-io/cypress)
  * 快照/html对比
* [vue-component](https://cn.vuejs.org/v2/cookbook/unit-testing-vue-components.html)

```js
// vue组件测试
import { shallowMount } from '@vue/test-utils'
import Foo from './Foo.vue'

// 描述块
describe('Foo', () => {
  // 一个测试用例
  it('renders a message and responds correctly to user input', () => {
    const wrapper = shallowMount(Foo, {
      data() {
        return {
          message: 'Hello World',
          username: ''
        }
      }
    })

    // 确认是否渲染了 `message`
    expect(wrapper.find('.message').text()).toEqual('Hello World')

    // 更新 `username` 并断言错误信息不再被渲染
    wrapper.setData({ username: 'Lachlan' })
    expect(wrapper.find('.error').exists()).toBeFalsy()
  })
})
```

## 自动化测试
考虑在本地或CI过程中执行`npm run test` + watch




# jest API
## 异步
```js
it('test async', (done) => {
  ajax(() => {
    done();
  })
})

it('test async', async() => {
  await ajax();
})
```

## 洋葱
global.beforeAll -> describe.beforeAll --> global.afterAll
```js
beforeAll(() => {})
afterAll(() => {})

describe('test', () => {
  let store = {};

  beforeAll(() => {
    store.a = 1;
  })

  beforeEach(() => {
    store.b = 1;
  })

  it('t1', () => {
    store.a++; // 1
    store.b; // 1
  })

  it('t2', () => {
    store.a; // 2
    store.b; // 1
  })
})
```

## 代理
* spyOn: 代理函数，可以测试函数被调用次数、返回值等
  * jest.fn
* mock: 模块

```js
import moduleName, {foo} from '../moduleName';

jest.mock('../moduleName', () => {
  return {
    __esModule: true,
    default: jest.fn(() => 42),
    foo: jest.fn(() => 43),
  };
});

moduleName(); // Will return 42
foo(); // Will return 43
```
