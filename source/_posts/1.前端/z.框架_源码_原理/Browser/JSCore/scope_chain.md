---
title: 作用域链
toc: true
date: 2020-03-12 00:00:02
tags:
---

【[参考资料](https://juejin.im/post/5c08ef8ef265da616301dd01)】

```js
// 定义一个全局的变量
var a = 'global var';

function foo () {
  console.log(a);
}

foo(); // 输出a
```
`foo.prototype.[[Scopes]]`数组里会保存上级的作用域，这里保存了`window`的引用；当该变量在foo的栈中找不到时，会尝试在`[[Scopes]][0]`里寻找；如果上一级找不到，那么会继续尝试在上上级的`[Scopes]][1]`里寻找，一直到顶级作用域`window`，然后报错；这种链路称为`作用域链`；

![](/img/Snip20200312_8.png)


```js
function outer () {
  var a = 1;

  function inner () {
    var b = 2;
    return () => {
      console.log(a, b);
    }
  }

  return inner();
}

outer()();
```
![](/img/Snip20200312_9.png)


## 拓展: EC, VO
上面的`[[Scopes]]`保存了上级作用域的信息，而当前作用域的信息则保存在EC中【[参考资料](https://segmentfault.com/a/1190000009041008)】
* 执行上下文(EC)
* VO: 变量对象

```js
function foo(i){
  var a = 'hello'
  var b = function(){}
  function c(){}
}
foo(22)


// EC对象，保存当前栈执行的上下文信息
ECObj = {
  scopChain： {...},
  variableObject: {  // VO，保存当前栈里的变量信息
    arguments: {
      0: 22,
      length: 1
    },
    i: 22,
    c: pointer to function c()
    a: undefined,
    b: undefined
  },
  this: { ... }
}
```
