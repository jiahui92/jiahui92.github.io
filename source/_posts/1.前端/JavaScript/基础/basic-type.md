---
title: 基础类型
toc: true
date: 2020-09-13 00:00:01
tags:
---

[参考资料](https://segmentfault.com/a/1190000006752076)

# 基本类型
String、Number、Boolean、Undefined、Null、Symbol、BigInt
* 基本数据类型的比较是值的比较
* 基础类型是保存在栈内存里面的

# 引用类型
Object、Function、Date、RegExp、Math、Set、Map等
* 除基本类型外的都是引用类型
* 引用类型的比较是引用地址的比较
* 引用对象的实际值是存在堆内存中的，在栈内存中只保存其引用地址

![](/img/Snip20200928_01.png)


# BigInt
[参考资料](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/BigInt)
* 支持*/+-%
* number是64bit（包括小数，整数最大为(2**53)-1），bigNum可以超过number的整数限制

```js
const bn1 = 9007199254740991n;
const bn2 = new BigNum('9007199254740991');

const bn3 = bn1 * 2n; // bn1乘以2

42 == 42n // true

typeof 1n // bigint，要是使用兼容库则会被识别为object，可以用instanceof判断
```

### babel插件
目前可以通过@babel/plugin-syntas-bigint来支持语法，但不保证浏览器兼容性，兼容性需要依赖stage插件


# Symbol
ES5 的对象属性名都是字符串，这容易造成属性名的冲突。比如，你使用了一个他人提供的对象，但又想为这个对象添加新的方法（mixin 模式），新方法的名字就有可能与现有方法产生冲突。如果有一种机制，保证每个属性的名字都是独一无二的就好了，这样就从根本上防止属性名的冲突。这就是 ES6 引入Symbol的原因。（其实自己搞一个随机数字符串作key也是可以的）
* Symbol里的参数只是一种变量描述，便于console查看，不传也可以
* 每个创建的Symbol都是不相等的，所以不会有命名冲突的风险

```js
let s1 = Symbol('foo');
let s2 = Symbol('bar');
// s1不等于s2

const a = {
	[s1]: 1,
	[s2]: 1,
}

a[s1] = 2
```

# Map
JavaScript 的对象（Object），本质上是键值对的集合（Hash 结构），但是传统上只能用字符串当作键。这给它的使用带来了很大的限制。
```js
const m = new Map();
const k1 = {h:1}
m.set(k1, 'haha')
m.get(k1)

m.has(k1)
m.delete(k1)
m.clear()
m.size
```


## 遍历
forEach, keys, values, entries

## WeakMap
```js
// 必须手动删除引用
arr [0] = null;
```
WeakMap 就是为了解决这个问题而诞生的，它的键名所引用的对象都是弱引用，即垃圾回收机制不将该引用考虑在内。因此，只要所引用的对象的其他引用都被清除，垃圾回收机制就会释放该对象所占用的内存。也就是说，一旦不再需要，WeakMap 里面的键名对象和所对应的键值对会自动消失，不用手动删除引用。

基本上，如果你要往对象上添加数据，又不想干扰垃圾回收机制，就可以使用 WeakMap。一个典型应用场景是，在网页的 DOM 元素上添加数据，就可以使用WeakMap结构。当该 DOM 元素被清除，其所对应的WeakMap记录就会自动被移除。

### 只接受对象作为键名
```js
m.set(element, 'some information')
// 不需要手动m.delete，当element被删除了，就自动回收了
```

### WeakMap pollyfill
[参考资料](http://webreflection.blogspot.com/2015/04/a-weakmap-polyfill-in-20-lines-of-code.html)
```js
// 实际上WeakMap没有引用任何东西，只保存一个WeakMap.id=Symbol('WeakMap')，对应的value是设置在keyObj身上的

WeakMap.prototype.set (keyObj, value) {
	defineProperty(keyObj, WeakMap.id, {value})
}
```


# Set
Set是元素值都是唯一的数组
```js
const s = new Set([1,2,3])

s.add(2)
s.delete(2)
s.has(2)
s.clear()
s.size
```

## 遍历
* forEach, keys, values, entries （keys的值与values相等）
* for of

## 数组去重
```js
Array.from(new Set(arr))
```

## WeakSet
JavaScript垃圾回收是一种内存管理技术。在这种技术中，不再被引用的对象会被自动删除，而与其相关的资源也会被一同回收。

Map和Set中对象的引用都是强类型化的，并不会允许垃圾回收。这样一来，如果Map和Set中引用了不再需要的大型对象，如已经从DOM树中删除的DOM元素，那么其回收代价是昂贵的。

为了解决这个问题，ES6还引入了另外两种新的数据结构，即称为WeakMap和WeakSet的弱集合。这些集合之所以是“弱的”，是因为它们允许从内存中清除不再需要的被这些集合所引用的对象。

* 元素只能是对象
* 不可遍历（所有的元素都是弱引用，如果别的地方没有用到这个元素对象，就会被垃圾回收）
