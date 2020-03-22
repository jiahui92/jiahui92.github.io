---
title: 数组
toc: true
date: 2020-03-20 00:00:02
tags:
---


## 数据结构
### 堆栈

### 队列

### 位图
查找增删	O(1)

应用于整型（或能转换为整型）的海量数据；

```js
int a[N/31+1]

indexLoc = N/32;
bitLoc = N%32;

function set(i){
  a[indexLoc] |= 1<<bitLoc;
}

function get(i){
  return a[indexLoc] >> bitLoc & 1;  
}
```



## 算法
### 去重 dup
```js
function removeDup (arr) {

  if (!arr) return [];

  const result = [];
  const hashMap = {};

  for (let item of arr) {
    if (!hashMap[item]) {
      hashMap[item] = true;
      result.push(item);
    }
  }

  return result;
}


function removeDup (arr) {
  if (!arr) return [];
  return Array.from(new Set(arr));
}

```



### 乱序 shuffle
```js
// 每个元素被换去的新位置的概率不等
function shuffle (arr) {
  if (!arr) return [];

  for (let i = 0; i < arr.length; i++) {
    const newIndex = parseInt(Math.random() * arr.length);
    [arr[i], arr[newIndex]] = [arr[newIndex], arr[i]];
  }

  return arr;
}


// 著名的Fisher-Yates shuffle 洗牌算法
// 概率相等且一定不会出现在原来的位置
function shuffle (arr) {
  if (!arr) return [];

  let i = arr.length;
  while (i > 0) {
    const newIndex = parseInt(Math.random() * i--);
    [arr[i], arr[newIndex]] = [arr[newIndex], arr[i]];
  }

  return arr;
}
/*
  共有 [1,2,3,4,5,6,7,8,9,10] 10张牌
  第一轮：将随机从"1~9"抽一张与"10"换位，"1"被抽中/被放在第10张牌位置的概率是1/9；
  第二轮：将随机从"1~8"抽一张与“9”或"10"换位；考虑到经过第一轮后：
    a. "1"出现在10的位置的概率为1/9；
    b. "1"不出现在10的位置的概率为8/9；那么第二轮时"1"有1/8的概率出现在"9"的位置；于是结合第一轮的可能结果计算可得实际概率为 8/9 * 1/8 = 1/9 ；
  第三轮：同样得，"1"出现在“7”的位置的概率为 8/9 * 7/8 * 1/7 = 1/9；
  ...

  经过9轮可得，"1"出现在任意位置的概率都是1/9；同理可得"1~9"都是一样的

  对于"10"，考虑一种简单的情况，即计算“10”出现在"9"的位置的概率；
  “10”要出现在“9”的位置，首先第一轮要被换到“1～8”的位置（如果被换到“9”的位置，那么第二轮就会被换到"1~8"的位置），这个概率是8/9；
  第二轮被抽中换到"9"的位置的概率是1/8；结合两轮计算，概率为8/9 * 1/8 = 1/9；
  
*/


```



### 拍平 flatten
```js
function flatten (arr) {
  if (!arr) return [];
  const result = [];

  function f (a) {
    for (let item of a) {
      Array.isArray(item) ? f(item) : result.push(item);
    }
  }

  f(arr);

  return result;
}

// [1,[2,3]].toString() ==> ['1','2','3']
// 这种利用Array.toString挺快捷，但是有bug的
// flatten([1,[2,[3],[]]])
//    输出: ['1','2','3','']，元素都变成了字符串且结果因为空数组而多了一个空字符串
function flatten (arr) {
  if (!arr) return [];
  return arr.toString().split(',');
}
```



### 过滤 filter
```js
function filter (arr, fn) {
  if (!arr) return [];
  if (typeof fn !== 'function') throw Error(`${fn} is not a function`);

  const result = [];
  arr.forEach(item => {
    if (fn(item)) result.push(item);
  })

  return result;
}
```
