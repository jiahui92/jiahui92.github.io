---
title: 变量提升
toc: true
date: 2020-03-12 00:00:05
tags:
---

js在运行时会先扫描一遍代码，将`var`和`function`的`声明`提升到顶部，但不会提升`var`的`赋值`；【[参考资料](https://www.runoob.com/js/js-hoisting.html)】

```js
// y未声明的情况下直接使用会报错

var x = 'Hello';
x += y; // y is not defined
```

```js
// y的声明会被提升，但是赋值不会被提升

var x = 'Hello';
x += y; // Helloundefined
var y = 'Bob';
```

```js
var a = 1;

(function () {
 console.log(a); // undefined
 var a = 2;
 console.log(a);
})();
```


虽然可以使用`let`来避免变量提升，但是经过babel编译后，`let`最终也会变成`var`；
```js
// 无编译
let x = 'Hello';
x += y; // y is not defined
let y = 'Bob';

// 编译后
"use strict";
var x = 'Hello';
x += y; // Helloundefined
var y = 'Bob';
```


