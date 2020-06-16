---
title: Serverless
toc: true
date: 2020-03-02 00:00:08
tags:
---


# serverless
感觉[serverless](https://github.com/serverless/components/blob/master/README.cn.md)与Netlify相似，是`docker + k8s + nginx + cli + Jenkins + 监控`的集大成者，针对特定的模版隐藏了特定的部署逻辑（Jenkinksfile,Dockerfile），这就意味着不需要自己去维护一台服务器（不需要运维），并安装jenkins和docker等一堆环境；FaaS是一种极致理想的应用情况；
* template.yml配置环境
  * runtime[nodejs/python]、框架[express/koa/eggjs]
  * 网关配置：域名等（替代nginx）、机房
* 直接使用云服务函数：数据库、对象存储、AI
* 监控
* 费用低：相比dokcer能做到按需使用、自动扩容（但k8s也能做到）


## 劣势
* 不能登录主机操作/没有主机的自由
* 在厂商间迁移应用成本大
  * 各厂商提供的BaaS API不一致
  * 封装好的Component其实也是基于各厂商的serverless-framework的


### 实际使用问题
* 环境虽然可以通过`environment:test`隔离，但是外网也能访问吧？
* 部署得上传一整个`node_modules`
* [本地调试需要借助serverless-offline](https://www.phodal.com/blog/serverless-architecture-development-serverless-offline-localhost-debug-test/)：对于简单的express应用，可以用`node sls.js`启动



## 应用
* BFF
* 轻量级API
* 日志收集
* [SSR](https://github.com/ykfe/egg-react-ssr)


## 插件开发
所有的插件都只是为了返回一套serverless `config配置`；下面这个是tencent-express的插件依赖树
* [serverless-components/tencent-express](https://github.com/serverless-components/tencent-express/blob/master/src/index.js): 返回node&express相关配置
  * [@serverless/tencent-framework](https://github.com/serverless-components/tencent-framework/blob/master/src/index.js)
    * @serverless/tencent-scf-multi-region: 返回部署机房配置
      * function
      * apigateway
    * @serverless/tencent-cns: 返回DNS相关配置
```js
// serverless-components/tencent-express

const { Component } = require('@serverless/core')

const DEFAULTS = {
  runtime: 'Nodejs8.9',
  framework: 'express'
}

class TencentComponent extends Component {

  async default(inputs = {}) {
    // 校验 serverless.yml 的 inputs 配置项
    // inputs.include = ...
    // inputs.runtime = ...

    const Framework = await this.load('@serverless/tencent-framework')

    const framworkOutpus = await Framework({
      ...inputs,
      framework: DEFAULTS.framework
    })

    this.state = framworkOutpus
    await this.save()
    return framworkOutpus
  }

  // 对应 sls remove 命令
  async remove(inputs = {}) {
    const Framework = await this.load('@serverless/tencent-framework')
    await Framework.remove(inputs)
    this.state = {}
    await this.save()
    return {}
  }

  module.exports = TencentComponent
}
```


### 为什么要把插件设计成Component
* 所有的插件都会`extend`[@serverless/core](https://github.com/serverless/core/blob/master/src/Component.js)的`class Component`，从而获取`this.load`方法，并通过该方法加载`childComponent`；
* 无论是`Component`还是`childComponent`都通过`this.state`来获取和设置`config配置`；



### 一个项目部署多个Component服务
一个项目中理论上是可以存在多个serverless component的，只要区分`code src`就好，也就是说前后端项目都可以放在一个项目里；[参考资料](https://www.npmjs.com/package/@serverless/core)
```yml
name: my-serverless-website
 
website: # An instance of a component is declared here.
  component: '@serverless/website@2.0.5' # This is the component you want to create an instance of.
  inputs: # These are inputs to pass into the component's "default()" function
    code:
      src: ./src/frontend

backend:
  component: '@serverless/backend@1.0.2'
  code:
    src: ./src/backend
  env:
    dbName: ${database.name}
    dbRegion: ${database.region}

database:
  component: '@serverless/aws-dynamodb@4.3.1'
  inputs:
    name: users-database
```

```js
const { Component } = require('@serverless/core')
 
class MyBlog extends Component {
  async default(inputs) {
    this.context.status('Deploying a serverless blog')
    const website = await this.load('@serverless/website') // Load a component
    const outputs = await website({ code: { src: './blog-code' } }) // Deploy it
    this.state.url = outputs.url
    await this.save()
    return outputs
  }
}
 
module.exports = MyBlog
```

