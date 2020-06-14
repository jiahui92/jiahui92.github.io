---
title: other
toc: true
hidden: true
date: 2020-04-27 00:00:10
tags:
---

# img跨域打点
[参考资料](https://blog.csdn.net/FuDesign2008/article/details/6772108)
```js
// 打点
export default function log(_event = '', data = {}) {
  const obj = {
    _event,
    _userId,
    _appName,
    ...data,
  };

  const arr = [];

  for (const k in obj) {
    let v = obj[k];
    if (typeof v === 'undefined') v = '';
    if (typeof v === 'object') v = JSON.stringify(v);
    v = encodeURIComponent(v);
    arr.push(k + '=' + v);
  }

  const url = 'https://api.guangjun.club/logger/log?' + arr.join('&');
  imgLog(url);
}


let i = 0;
const time = `${(new Date()).getTime()}-`;

function imgLog(url) {
  // 全局变量防止Image被回收导致请求失败
  const data = window.imgLogData || (window.imgLogData = {}); 
  let img = new Image();
  const uid = time + i++; // 生成唯一id用于阻止缓存请求
  img.onload = img.onerror = () => {
    img.onload = img.onerror = null;
    img = null;
    delete data[uid];
  };
  img.src = url + '&_nocache=' + uid; // 及时存在临时变量，某些浏览器也会立即回收
}

```

## beacon
[参考资料](https://www.barretlee.com/blog/2016/02/20/navigator-beacon-api/)
* 未来可以切换到[beacon](https://zhuanlan.zhihu.com/p/41759633)，但网上说有bug；
* 相比img打点，beacon可以在后台进程里打点，意味着切换页面不会丢失打点请求；


# seo
* 百度、谷歌 SEO工具
* http://mtool.chinaz.com/



# serverless

[serverless](https://github.com/serverless/components/blob/master/README.cn.md)与docker相似，只不过针对特定的模版隐藏了特定的部署逻辑（Jenkinksfile,Dockerfile），这就意味着不需要自己去维护一台服务器，并安装jenkins和docker（不需要运维）；FaaS是一种极致理想的应用情况；
* template.yml配置环境
  * runtime[nodejs/python]、框架[express/koa/eggjs]
  * 网关配置：域名等（替代nginx）
* 直接使用云服务函数：数据库、对象存储、AI
* 监控
* 费用低：相比dokcer能做到按需使用、自动扩容（k8s也能做到）


## 劣势
* 不能登录主机操作
* 假如使用了云函数，各厂商API不相同，应用迁移成本大


## 应用
* BFF
* 轻量级API
* 日志收集
* [SSR](https://github.com/ykfe/egg-react-ssr)

## 插件开发
[TODO] 原理



# 中台
【[参考资料](https://www.zhihu.com/question/57717433)】
* 一般指业务中台；当公司出现多种类似业务时（比如淘宝、咸鱼都是电商应用，商品详情页、下单、购物车这些逻辑几乎都是一样的，没必要写多套后端逻辑），为了尽可能复用，抽出中台这一概念，一个中台服务多个业务；但是对于不同业务，偶尔需要做一些不同的处理或配置，此时可能需要搭建后台来完成值、流程配置等； 
* 对于前端来说，感觉和原来的公共组件其实差不多；只不过也是要尽可能兼容多个业务，对于不同业务的特殊逻辑可能也是要通过配置来处理；还有一点比较特殊的是前端的UI往往不可复用/复用成本比较大；
* 劣势
  * 特殊逻辑一般需要给中台提需求，一个项目会有更多的人参与进来；同时一个中台部门需要同时支持多个业务部门；
  * 历史遗留问题，架构调整，需要将原来多个类似后端业务合并为一个；
  * API要设计得很好，保持拓展性以兼容未来的业务，否则可能会越来越难用；

* 技术中台
* 数据中台


# 前端的一些方向
大公司偏向于分工，通常会走大前端/跨端的方向；而小公司通常偏向与全栈/干；
* 基建
  * 规范
  * 脚手架
    * webpack n
    * 微前端
  * 运维
    * docker
    * serverless
* 跨端
  * web、小程序
  * android/ios
  * electron
  * IoT、VR
* 业务
  * 懂一点 设计、产品、运营、管理
  * 关注新工具并了解优缺点
* 其它
  * 数据可视化
  * 动画
  * 搭建
  * 智能化


# 前端基建的发展
* 只有一个项目 + webpack
* 零散几个项目 + SPA脚手架 + webpack
* 多个项目    + 微前端? + webpack-cli
