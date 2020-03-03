---
title: index
toc: true
date: 2020-03-02 00:00:00
tags:
---

* [IT工具/系统评价排行](https://founderkit.com/)
* [山月行blog](https://shanyue.tech/op)



## devops部署的演化
如果是纯前端文件的话，其实没有太大问题；打包之后直接推到cdn 【[参考资料](https://shanyue.tech/op/deploy-fe.html)】
* 阶段一
  * 跳板机+部署脚本
  	- 环境不统一的问题，比如node版本
* 阶段二
  * docker
  	- 代替部署脚本
  * CI/CD自动化集成
  	- 代替跳板机
  * k8s分布式部署
* 阶段三
  * 前端统一部署平台
  	* k8s部署配置
  	* nginx相关配置
  	* http header

