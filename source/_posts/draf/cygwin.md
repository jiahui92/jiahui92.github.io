---
title: Cygwin
toc: true
hidden: true
date: 2022-05-10 00:00:00
tags:
---

# 安装
给window的cmd扩展linux命令
* [cygwin介绍](https://zhuanlan.zhihu.com/p/56692626)
* [cygwin安装](https://www.cnblogs.com/feipeng8848/p/8555648.html)
  * 安装cygwin
    * 安装wget依赖包
  * 安装apt-cyg工具

## zsh, oh-my-zsh
* 安装zsh, oh-my-zsh

# 原理
* cygwin原理
  * 支持绝大部分Linux程序/命令（Linux-like程序 --> UNIX模拟层/cygwin.dll --> win32 api）
    * 不完全支持Linux所有程序
    * 允许速度慢
  * linux&win编译
  * WSL、WebAssembly、nodejs.lib

# 概念
* 终端: 只负责接收用户输入，然后传给shell执行，再把shell执行结果输出；以及界面美化；比如Windows Ternimal, ConEmu/Cmder, Mintty
* shell: 负责运行命令，不同的shell支持不同的命令，比如bash, zsh, powershell , cygwin

## 目录
xxx



