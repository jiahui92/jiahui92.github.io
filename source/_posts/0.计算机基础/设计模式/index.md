---
title: index
date: {{ date }}
---

不同语言特性有不同的设计模式，比如
* 面向对象的设计模式
* 函数式编程

设计基础原则SOLID --> 设计模式 --> 设计模式的实现
* 拓展性
  * 某些API支持自定义实现
    * extend.protected
    * 策略模式
  * 追加API
  * API内部自定义实现
    * 观察者模式
      * 订阅发布
        * webpack插件的勾子系统
        * vscode插件系统


# 函数式编程
无状态、不用赋值、使用函数组合来编程【[参考资料](https://www.zhihu.com/question/28292740)】
```
h(g(f(x))) = (h*(g*f))(x) = ((h*g)*f)(x)
```

```js
// 翻转二叉树

// 命令式编程：关心解决问题的步骤
function invert (node) {
  if (!node) return null;
  [node.left, node.right] = [invert(node.right), invert(node.left)];
  return node;
}

// 函数式编程：关心数据的映射，必须设计好各函数与函数返回值之间的关系
function invert (node) {
  if (!node) return null;
  return new Tree(node.value, invert(node.right), invert(node.left));
}
```

## 特性
* 高阶函数: 接受参数为函数的函数，比如`arr.map(item => item + 1)`
* 函数柯里化
* 闭包

