---
title: 双指针
toc: true
date: 2020-03-18 00:00:02
tags:
---


## 寻找两个有序数组的中位数
https://leetcode-cn.com/problems/median-of-two-sorted-arrays/

给定两个大小为 m 和 n 的有序数组 nums1 和 nums2。

请你找出这两个有序数组的中位数，并且要求算法的时间复杂度为 O(log(m + n))。

你可以假设 nums1 和 nums2 不会同时为空。

```
示例 1:

nums1 = [1, 3]
nums2 = [2]

则中位数是 2.0
```
```
示例 2:

nums1 = [1, 2]
nums2 = [3, 4]

则中位数是 (2 + 3)/2 = 2.5
```

```js

// O(m+n)的算法会比较简单，通过双指针将两数组“拼合”成一个有序数组，然后开始遍历寻找排在(nums1.length + nums2.length) / 2 的数即可
var findMedianSortedArrays = function(nums1, nums2) {
  let i = 0, j = 0;
  const totalLen = nums1.length + nums2.length;
  const len = parseInt(totalLen / 2);
  const isSingle = totalLen % 2; // 是否为单数

  let result = 0;

  for (let k = 0; k <= len; k++) {
    // 谁小，先取谁，形成有序数组
    // 边界：注意nums1或nums2 提前被取完的情况
    let num = j >= nums2.length || nums1[i] < nums2[j] ? nums1[i++] : nums2[j++];
    // 单数取中间一个数，双数取中间两个数
    if (!isSingle && k == len - 1) result += num;
    if (k == len) result += num;
  }

  return isSingle ? result : result / 2;
};

// O(lg(m+n))则需要通过双指针把两个数组假装连接在一起做二分排序，做好分界之类的处理；当然题解里还有更优的遍历方法，而不是给整个数组做完二分排序，也不会影响原数组。
```



## 三数之和
https://leetcode-cn.com/problems/3sum/

给你一个包含 n 个整数的数组 nums，判断 nums 中是否存在三个元素 a，b，c ，使得 a + b + c = 0 ？请你找出所有满足条件且不重复的三元组。

注意：答案中不可以包含重复的三元组。

 
```
示例：

给定数组 nums = [-1, 0, 1, 2, -1, -4]，

满足要求的三元组集合为：
[
  [-1, 0, 1],
  [-1, -1, 2]
]
```

```js
// 题解: https://leetcode-cn.com/problems/3sum/solution/3sumpai-xu-shuang-zhi-zhen-yi-dong-by-jyd/
```

