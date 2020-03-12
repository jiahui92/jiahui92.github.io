---
title: Webkit/Chromium/V8
toc: true
date: 2020-03-12 00:00:03
tags:
---

https://juejin.im/post/5c0492a36fb9a049e82b435a

## WebKit
WebKit由渲染引擎“WebCore”和JS解释引擎“JSCore”组成。

## Chromium
基于Webkit但可读性更高，多进程框架。将WebCore代替为Blink渲染引擎，JSCore代替为V8。

## V8.JIT即时编译
【[参考资料](https://juejin.im/post/5a582b13f265da3e355aff46)】
* JIT: 解释 + 编译 = 即时编译
* 相比JSCore，V8放弃了在字节码阶段可以进行的一些性能优化（移除空格，不会被执行的死码和冗余代码等），但保证了执行速度
* 其它V8详细内容可以看[AST --> V8](/wiki/1.前端/z.框架_源码_原理/AST/V8/index)
