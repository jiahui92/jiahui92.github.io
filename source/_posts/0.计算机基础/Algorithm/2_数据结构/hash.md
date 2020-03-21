---
title: hash表
toc: true
date: 2020-03-20 00:00:01
tags:
---

## 基础

### 哈希（非哈希表）
* 集合A到集合B的映射；
* 哈希函数：MD5, SHA；
* hash的应用：文件对比，密码存储；

### 设计hash函数
1.直接定址：addr(k) = a*key+b
2.平方取中：{421，423，436}，平方{177241，178929，190096}，取{72，89，00}
3.折叠：图书的ISBN号为8903-241-23，可以将addr(key)=89+03+24+12+3
4.取模：address(key)=key%p；p非常关键



## 存在重复元素
https://leetcode-cn.com/problems/contains-duplicate/

给定一个整数数组，判断是否存在重复元素。

如果任何值在数组中出现至少两次，函数返回 true。如果数组中每个元素都不相同，则返回 false。

```
示例 1:

输入: [1,2,3,1]
输出: true
```
```
示例 2:

输入: [1,2,3,4]
输出: false
```
```
示例 3:

输入: [1,1,1,3,3,4,3,2,4,2]
输出: true
```
```js
var containsDuplicate = function(nums) {
  const obj = {};
  for (let i = 0; i < nums.length; i++) {
    if (obj[nums[i]]) return true;
    obj[nums[i]] = true;
  }
  return false;
};
```


## 两数之和
https://leetcode-cn.com/problems/two-sum/

给定一个整数数组 nums 和一个目标值 target，请你在该数组中找出和为目标值的那 两个 整数，并返回他们的数组下标。

你可以假设每种输入只会对应一个答案。但是，你不能重复利用这个数组中同样的元素。

```
示例:

给定 nums = [2, 7, 11, 15], target = 9

因为 nums[0] + nums[1] = 2 + 7 = 9
所以返回 [0, 1]
```
