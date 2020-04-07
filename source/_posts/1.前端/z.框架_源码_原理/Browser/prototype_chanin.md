---
title: 原型链
toc: true
date: 2020-03-12 00:00:07
tags:
---

[TODO]

```
var F = function(){};  
Object.prototype.a = function(){};  
Function.prototype.b = function(){};  
var f = new F();

f.a();
f.b();
```
