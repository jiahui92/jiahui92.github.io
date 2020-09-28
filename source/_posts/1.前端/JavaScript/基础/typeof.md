---
title: 类型判断
toc: true
date: 2020-09-13 00:00:02
tags:
---

[参考资料](https://sq.163yun.com/blog/article/173159613566214144)

# typeof
* 可以识别null以外的基本类型（可以结合上一节的基本类型来看）, object, function
```js
typeof "jerry"; // "string"
typeof 12;  // "number"
typeof true;    // "boolean"
typeof undefined;   // "undefined"
typeof null;    // "object"
typeof {name: "jerry"}; // "object"
typeof function(){};    // "function"

// 所有的引用类型都被归类为object类型
typeof [];          // "object"
typeof new Date;    // "object"
typeof /\d/;        // "object"
function Person(){};
typeof new Person;  // "object"
```


# Object.prototype.toString
* 相比typeof，能够判断出null类型
* 但也不能判断具体的object类型
```js
var toString = Object.prototype.toString;

toString.call([]);           // "[object Array]"
toString.call(new Date);     // "[object Date]"
toString.call(/\d/);         // "[object RegExp]"
```

```js
function type(obj){
	return Object.prototype.toString.call(obj).slice(8, -1).toLowerCase();
}

type("jerry");      // "string"
type(1);            // "number"
type(true);         // "boolean"
type(undefined);    // "undefined"
type(null);         // "null"
```

## 不能判断自定义类型
```js
function Person(name){
	this.name = name;
}
type(new Person("jerry"));  // "object"
```

# instanceof
* 可以识别出构造函数`xx.prototype.constructor`类型，且能识别父子类型
* 不能用来识别基础类型
* 有跨window的问题，因为最终判断的constructor也是一个函数，跨window的话构造函数的引用地址不一样
```js
// 判断内置对象类型
[].constructor === Array;   // true

function Person(name){
	this.name = name;
}
// 判断自定义对象
new Person("jerry").constructor === Person; // true
// 判断原始类型
"jerry".constructor === String;     // true
(1).constructor === Number;         // true
true.constructor === Boolean;       // true

var jerry = new Student("jerry", 3);
jerry instanceof Student; // true
jerry instanceof Person; // true
```

# constructor
识别跨window的类型
```JS
function getClassName(obj){
	return obj?.constructor?.toString?()?.match(/function\s*([^(]*)/)[1];
}

getClassName(arr) === "Array"; // true
```
