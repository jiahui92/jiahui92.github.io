---
title: 数组
toc: true
date: 2020-03-20 00:00:02
tags:
---


## 堆栈


## 队列
### 去重 dup
### 乱序 shuffle
### 拍平 flatten
### 过滤 filter

## 位图
查找增删	O(1)

应用于整型（或能转换为整型）的海量数据；

```js
int a[N/31+1]

indexLoc = N/32 = N >> 5;
bitLoc = N%32 = N & 32;

function set(i){
  a[indexLoc] |= 1<<bitLoc;
}

function get(i){
  return a[indexLoc] >> bitLoc & 1;  
}
```
