---
title: 面向对象的设计模式
date: {{ date }}
---

# SOLID - OO中比较重要的设计基础原则
后续具体的设计模式基本都会遵循SOLID
* S: Single Responsiblity / 单一职责
* O: Open-Closed / 开放封闭 （面向拓展是开发的/可拓展性，面向修改是封闭的/可维护性，尽量不要修改已有代码，而是通过拓展来完成迭代）
* L: 里氏替换原则/继承
* D: Dependency Inversion 依赖倒置/面向接口 （细节应该依赖于抽象 - 代码实现应该依赖于接口）
  * I: Interface Segregation 接口单一职责 (接口单一职责，否则用户会依赖于他们用不上的接口)


# 策略
Duck.fly抽成一个FlyBehavior
使用多个
FlyBehavior是指多种类：不会飞，飞得快，飞得慢的类
推导过程：
  * 基类会让所有继承类都拥有fly
  * 接口则会让所有类都必须实现fly
  * 标准的调用、高度自定义实现
特定
  * 内部固定调用方式
  * 外部通过setXxx传入调用的实例或函数
设计重点
  * 功能拆分

# 中介者
x

# 观察者
订阅发布

# 责任链
x

# 装饰器
对标继承的模式（静态），装饰器可以动态给类添加功能；避免了一个实例继承了所有功能（臃肿）；

## 例子
```java
class Shape {
  draw() {
    console.log('shape');
  }
}

// 迭代：增加了一个红框
```

1. xxx
```java
class Shape {
  draw() {
    console.log('shape');
    console.log('red border');
  }
}

// 问题：这部分是公共代码，会影响别的业务
```

2. extend
```java
class RedBorderShape extends Shape {
  draw() {
    super.draw();
    console.log('red border');
  }

  otherExtendApi();
}

const shape = new RedBorderShape();
shape.draw();

// 问题：以后还可能增加别的样式需求，并且每个业务所需有重合也有不同的地方
// A,B,C
// 继承组合会有很多类： AC, BC, ACBC
// 装饰器随便组：A(B(C))
```

3. 装饰器
```java
class RedBorderDecorate {
  constrouct(Shape shape) {
    this.shape = shape;
  }

  draw() {
    this.shape.draw();
    console.log('red border');
  }
}

const shape = new RedBorderDecorate(new Shape());
shape.draw();

// 问题：有多个装饰器，并且都是增强同一个功能时，可能因为会嵌套比较深，导致调试困难
```

## 场景
* `@contextProvider(TabApiConsumer, 'tabApi')`
* `@autobind`
* `@observer`
<!-- * ts? -->

## 原理
[参考](https://blog.csdn.net/youlinhuanyan/article/details/108295701)
* 编译插件
  * class
  * class属性
* 装饰器实现
```js
// 编译前
@autobind
class A {}

// 编译后
A = autobind(A);
```

```js
functions autobind(target) {
  // 遍历target的属性
  if (isFunction(target[key])) {
    target[key] = target[key].bind(target.property)
  }
}
```




<!-- # 其它
* [单例](https://www.jianshu.com/p/f2cc8d2cccba) -->
