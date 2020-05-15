---
title: 原型链和继承
toc: true
date: 2020-03-12 00:00:07
tags:
---



# 原型链
[参考资料](https://zhuanlan.zhihu.com/p/85949648)
![](/img/Snip20200515_1.png)
实例的`__proto__`指向`constructor.prototype`： `foo`是由`Foo`创建的，所以`foo.__proto__`指向`Foo.prototype`；然后`Foo.prototype`是由`Object`创建的，所以指向`Object.prototype`
* Foo = new Function();
  * Foo.prototype = new Object();
  * Foo.prototype.constructor = Foo;


```js
Object.prototype.a = function(){};  
Function.prototype.b = function(){};
const F = function(){};
const f = new F();

f.a();
f.b();
F.b();

console.log(f.__proto__ === F.prototype);
console.log(f.__proto__.__proto__ === Object.prototype);
console.log(f.__proto__.__proto__ === F.prototype.__proto__);
```



# 继承
[TODO]

## 一、原型链
```js
function Animal(type = '', name = '') {
  this.name = name;
  this.type = type;
  this.children = ["c1", "c2"];
}

Animal.prototype.say = function () {
  console.log(this.type, this.name, ', my children:', this.children);
}

function Person(name) {
  this.name = name;
}

// 使用原型继承
Person.prototype = new Animal('Person');

const p1 = new Person('Tom');
const p2 = new Person('Jerry');
p1.say();
p2.say();
p2.children.push('c3'); // 这里有问题：同时也修改了p1的children
p2.say();
p1.say();
```

* 利用 `Person.prototype = new Animal("Human")` 实现继承；
* static式继承、能继承Animal.prototype、不可多重继承；


## 二、借用构造函数
![](http://images0.cnblogs.com/blog2015/743264/201508/112319472398016.png)<br>

* 对象冒充、apply、call三个方法的原理都是使用Person的this调用Animal；
* property式继承、不能继承Animal.prototype、可多重继承；


## 三、组合
![](http://images0.cnblogs.com/blog2015/743264/201508/112319591602208.png)<br>

* 使用static式（原型链的方法）继承Animal（Animal的属性和原型）；
* 使用property式（借用构造函数的方法）继承Animal.property；


## 四、总结

  .  | 继承方式 | 继承Animal.protptype | 多重继承
---------|----------|---------|---------
 原型链      | static | Y | N
 借用构造函数 | property | N | Y
 组合        | static,property | Y | 

### 组合继承的不足
空间上的冗余：在使用原型链的方法继承父类的原型属性（Animal.prototype）的同时，也在子类的原型（Person.prototype）中继承多了一份父类属性（Animal.property）；具体来说：p与p.prototype中都保存了type,children，而p.prototype这一份是冗余的；


# 五、寄生式组合继承
为了解决上面的问题，所以需要在混合继承的基础上进行改造。那么如何避免冗余呢？

* 避免使用 `Person.prototype = new Animal()` 来继承整个Animal实例；
* 这样将代码改写为 `Person.prototype = Animal.prototype`；
* 那么又会引入一个问题，Person.prototype与Animal.prototype共用一个空间（在正常继承中，Person.prototype应该有自己独立的空间），也就是说一旦我们修改了Person.prototype，同时也修改了Animal.prototype；
* 所以继续修改代码为 `Person.prototype=Object.create(Animal.prototype)` <br>下图为Object.create的实现（在支持ES5的浏览器中可以直接使用）；<br>![](http://images0.cnblogs.com/blog2015/743264/201508/121204024738283.png)<br>函数中返回的F即为Person.prototype的独立空间
* 完美主义者，constructor的指向问题（改不改都不影响）：原来返回的F.constructor指向Animal，要修改为指向Person；

![](http://images0.cnblogs.com/blog2015/743264/201508/121206110676131.png)
