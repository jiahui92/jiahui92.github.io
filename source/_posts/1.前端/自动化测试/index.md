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

# 测试用例的评估
## 排列组合
可以对传进来的参数使用排列组合的来将所有可测用例枚举出来，最后再结合业务排除掉不可能的
```js
// a,b,c都只可能为无值或者有值这两种情况，那么排列组合的情况是2*2*2=6
function (a, b, c) {}
```

## 分支语句
每一个分支一个用例，最后再结合所有分支测一下
```js
// 用例分别为 a分支 、 b分支 、 a+b
function xxx () {
  if (a) {
    xxx;
  }

  if (b) {
    xxx
  }

  return xxx;
}
```


# 工具
* 单元测试: jest, mocha
	* 代码覆盖率 istanbul

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

  // it语句是可以并行跑的
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

## expect API
```js
describe('test', () => {
  // 全部相等
  expect({a: 1, b: 1}).toEqual({a: 1, b: 1});

  // 部分相等即可
  expect({
    key: 'key1',
    value: 'value1',
    children: [{
      key: 'childrenKey1',
      title: 'xxx',
    }]
  }).toEqual(expect.objectContaining({
    key: 'key1',
    children: [
      expect.objectContaining({
        key: 'childrenKey1',
      })
    ]
  }));
})

// 数组包含某个对象
const users = [{id: 1, name: 'Hugo'}, {id: 2, name: 'Francesco'}];
test('we should have ids 1 and 2', () => {
  expect(users).toEqual(
    expect.arrayContaining([
      expect.objectContaining({id: 1}),
      expect.objectContaining({id: 2})
    ])
  );
});
```

## 代理
* spyOn: 代理函数，可以测试函数被调用次数、返回值等
  * jest.fn
* mock: 模块

```js
// https://stackoverflow.com/questions/29719631/how-do-i-set-a-mock-date-in-jest
Date.now = jest.fn(() => 1487076708000);


// mock es6 module function
import * as utils from './utils';
utils.someFn = jest.fn(() => 1);
```

```js
// mock接口返回值
const { data } = await axios.get(url);

// 以下是测试代码
import axios from 'axios';
jest.mock('axios')
axios.get.mockReturnValue(Promise.resolve({
  data: 'mock data'
});
```
### 当mock的函数与测试函数在同一模块时
* 第一种办法是拆开为两个模块
* 第二种是巧妙使用requireActual（当被测函数与需要mock的函数为一个模块时，这种办法好像不行）【[参考资料](https://spectrum.chat/testingjavascript/help/mocking-implementation-from-the-same-module-thats-being-tested~e8103950-e198-423d-a9ad-5b308853b2ac)】
```js
import { foo } from '../moduleName';

// 直接使用mock会导致module的所有函数都会被mock
jest.mock('../moduleName', () => {
  return {
    // 注意这里!!!!
    ...requireActual('../moduleName'),
    foo: jest.fn(() => 43),
  };
});

foo(); // Will return 43
```


## jest.config.js
[文档](https://jestjs.io/docs/en/configuration)
```js
module.exports = {
  // 寻找入口文件
  roots: ['/src', /*'<rootDir>/src'*/],
  testRegex: '(/__tests__/.*|(\\.|/)(test|spec))\\.[jt]sx?$', // 文件路径匹配（默认值）
  moduleFileExtensions: ['ts', 'tsx', 'js', 'jsx'] // 后缀自动补全

  // 依赖处理
  moduleNameMapper: {
    '\\.(jpg|jpeg)$': '/jest/mock/imageStub.js',
    '@axios': ['./src/axios'], // 别名路径
  }

  // 编译
  transform: {
    '\\.tsx?$': '/node_modules/ts-jest',
    // 自定义编译
    '\\.jsx?$': '/jest/transform/myJsxTransform.js',
  }

  globals: {
    '__DEV__': true,
    'ts-jest': {
      // 提供给ts-jest的编译配置
      tsConfig: '/jest/tsconfig.test.json',
    }
  }


  // 覆盖率相关
  collectCoverage: true,
  collectCoverageFrom: [
    "**/*.{js,jsx}"
  ],
  coverageDirectory: '/jest/coverage',
  coverageThreshold: {}, // 覆盖率阀值，低于时警告


  // 快照
  // snapshot


  // jest 缓存
  cacheDirectory: '/jest/tmp/cache',

  // watch
  watchPlugins: ['path/to/yourWatchPlugin'],
  watchPathIgnorePatterns,

}
```

## CLI
```sh
jest my.test.js
jest --watch my.test.js

# run git uncommitted file
jest -o
jest --watch # default with -o

jest --collect-coverage
```


