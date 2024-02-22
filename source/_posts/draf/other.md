---
title: other
toc: true
hidden: true
date: 2020-04-27 00:00:10
tags:
---


# seo
* 百度、谷歌 SEO工具
* http://mtool.chinaz.com/



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


# mac app is damaged xxx
* 方法一
  * sudo spctl --master-disable
* 方法二
  * 打开终端，在终端中粘贴下面命令：“sudo xattr -r -d com.apple.quarantine” ,然后输入个空格，再将应用程序目录中的软件拖拽到命令后面，按回车后输入密码执行。比如： sudo xattr -r -d com.apple.quarantine /Applications/*.app


# 微前端
* 相比微应用的特点是 框架无关，页面渲染可以混用React、Vue等框架，甚至是同框架不同版本；[micro-app](https://micro-zoe.github.io/micro-app/docs.html#/)
* [参考资料](https://juejin.im/post/6844904182814605325)
* 对比看`多应用+npm` --> `rush巨型应用(mono repo)` 的项目模式

```md
多个项目需要同步修改webpack之类的配置文件
* 抽npm包不太行，还是需要同步修改版本号
  * 微前端可能是个解决方案
    * 怎么结合docker.volumn来只打包必要的打包呢？
      * 同时还要支持多个类型：pc, h5, taro
```

## 微应用
* 将巨型项目拆成多个应用（或者将多个小应用集成一个微应用，相当于折中优化？），借助webpack module dederation分开打包，并且每个应用可以对外暴露逻辑+依赖共享(需通过await import使用)；
* 编译优化
  * 如果用remote包则比二次缓存的方案更快
* 工程优化
  * 各应用可以很轻松使用不同版本的React
  * 理论上各应用可以单独打包、发布（其余使用remote包）

参考资料
* [Module Federation 2](https://mp.weixin.qq.com/s/sdIVsfmRlhDtT6DF2dmsJQ)
* [Module Federation](https://juejin.im/post/6844904169405415432)
