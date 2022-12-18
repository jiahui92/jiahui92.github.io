---
title: draft
toc: true
hidden: true
date: 2020-04-07 00:00:02
tags:
---

再加一些恰好的例子

# 一些设计模式/好维护的代码
## proxy的数据交互
* abcde互相影响的交互，最好放在一个函数里计算（偏向于函数式？），否则proxy.setter太乱了

## 组件数据隔离
* 要突出父子组件需要交互的数据

## 组件设计的考量
简单组件
* api简单易用

复杂组件
* 文档
* 可维护性
  * 可拓展性（尽量考虑全面业务场景，但要避免过度设计）
  * 单元测试
* 公共和业务可调试性（划分bug责任的界限，没有这个界限就只能让业务去调公共代码，或者公共帮业务调代码）

# rush
* common/config
  * .npmrc
  * command-line.json rush自定义命令
  * shrinkwrap.json
* common/temp/node_modules
* package/* & link/node_modules & webpack
* link/node_moduels
* common/rush.json & package/*

* 目录结构
  * 主目录
  * webpack \ node_moduels
* 核心文件
* 常用命令
  * npm i
  * rush update
  * 自定义
* 同类竞品
  * 微前端
