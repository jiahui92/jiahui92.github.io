---
title: 贪心算法
toc: true
date: 2020-03-18 00:00:01
tags:
---

## 买卖股票的最佳时机
https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock/

给定一个数组，它的第 i 个元素是一支给定股票第 i 天的价格。

如果你最多只允许完成一笔交易（即买入和卖出一支股票一次），设计一个算法来计算你所能获取的最大利润。

注意你不能在买入股票前卖出股票。
```
示例 1:

输入: [7,1,5,3,6,4]
输出: 5
解释: 在第 2 天（股票价格 = 1）的时候买入，在第 5 天（股票价格 = 6）的时候卖出，最大利润 = 6-1 = 5 。
     注意利润不能是 7-1 = 6, 因为卖出价格需要大于买入价格。
```
```
示例 2:

输入: [7,6,4,3,1]
输出: 0
解释: 在这种情况下, 没有交易完成, 所以最大利润为 0。
```


```js
/**
 * @param {number[]} prices
 * @return {number}
 */
var maxProfit = function(prices) {
  /**********************暴力法 O(n^2) */
  let max = 0;
  for (let i = 0; i < prices.length; i++) {
    for (let j = i; j < prices.length; j++) {
      if (prices[i] < prices[j]) {
        max = Math.max(max, prices[j] - prices[i]);
      }
    }
  }
  return max;


  /**********************O(n) */
  let result = 0;
  let minPrice = Infinity;
  for (let i = 0; i < prices.length; i++) {
    if (prices[i] < minPrice) {
      minPrice = prices[i];
    } else {
      result = Math.max(result, prices[i] - minPrice);
    }
  }
  return result;
};
```

## 买卖股票的最佳时机2
https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock-ii/

给定一个数组，它的第 i 个元素是一支给定股票第 i 天的价格。

设计一个算法来计算你所能获取的最大利润。你可以尽可能地完成更多的交易（多次买卖一支股票）。

注意：你不能同时参与多笔交易（你必须在再次购买前出售掉之前的股票）。
```
示例 1:

输入: [7,1,5,3,6,4]
输出: 7
解释: 在第 2 天（股票价格 = 1）的时候买入，在第 3 天（股票价格 = 5）的时候卖出, 这笔交易所能获得利润 = 5-1 = 4 。
     随后，在第 4 天（股票价格 = 3）的时候买入，在第 5 天（股票价格 = 6）的时候卖出, 这笔交易所能获得利润 = 6-3 = 3 。
```
```
示例 2:

输入: [1,2,3,4,5]
输出: 4
解释: 在第 1 天（股票价格 = 1）的时候买入，在第 5 天 （股票价格 = 5）的时候卖出, 这笔交易所能获得利润 = 5-1 = 4 。
     注意你不能在第 1 天和第 2 天接连购买股票，之后再将它们卖出。
     因为这样属于同时参与了多笔交易，你必须在再次购买前出售掉之前的股票。
```

```
示例 3:

输入: [7,6,4,3,1]
输出: 0
解释: 在这种情况下, 没有交易完成, 所以最大利润为 0。
```

```js
/**
 * @param {number[]} prices
 * @return {number}
 */
var maxProfit = function(prices) {
  let profit = 0;
  for (let i = 1; i < prices.length; i++) {
    // 这道题我的理解有点问题：在当天卖出之后，其实可以立马再买回来的
    const p = prices[i] - prices[i-1];
    if (p > 0) profit += p;
  }
  return profit;
};
```


## 加油站
https://leetcode-cn.com/problems/gas-station/

在一条环路上有 N 个加油站，其中第 i 个加油站有汽油 gas[i] 升。

你有一辆油箱容量无限的的汽车，从第 i 个加油站开往第 i+1 个加油站需要消耗汽油 cost[i] 升。你从其中的一个加油站出发，开始时油箱为空。

如果你可以绕环路行驶一周，则返回出发时加油站的编号，否则返回 -1。

说明: 

如果题目有解，该答案即为唯一答案。
输入数组均为非空数组，且长度相同。
输入数组中的元素均为非负数。

```
示例 1:

输入: 
gas  = [1,2,3,4,5]
cost = [3,4,5,1,2]

输出: 3

解释:
从 3 号加油站(索引为 3 处)出发，可获得 4 升汽油。此时油箱有 = 0 + 4 = 4 升汽油
开往 4 号加油站，此时油箱有 4 - 1 + 5 = 8 升汽油
开往 0 号加油站，此时油箱有 8 - 2 + 1 = 7 升汽油
开往 1 号加油站，此时油箱有 7 - 3 + 2 = 6 升汽油
开往 2 号加油站，此时油箱有 6 - 4 + 3 = 5 升汽油
开往 3 号加油站，你需要消耗 5 升汽油，正好足够你返回到 3 号加油站。
因此，3 可为起始索引。
```

```
示例 2:

输入: 
gas  = [2,3,4]
cost = [3,4,3]

输出: -1

解释:
你不能从 0 号或 1 号加油站出发，因为没有足够的汽油可以让你行驶到下一个加油站。
我们从 2 号加油站出发，可以获得 4 升汽油。 此时油箱有 = 0 + 4 = 4 升汽油
开往 0 号加油站，此时油箱有 4 - 3 + 2 = 3 升汽油
开往 1 号加油站，此时油箱有 3 - 3 + 3 = 3 升汽油
你无法返回 2 号加油站，因为返程需要消耗 4 升汽油，但是你的油箱只有 3 升汽油。
因此，无论怎样，你都不可能绕环路行驶一周。
```

```js
var canCompleteCircuit = function(gas, cost) {
  /**
   * gas  = [1,2,3,4,5]
   * cost = [3,4,5,1,2]
   * left = [-2,-2,-2,3,3]
   */
  let len = gas.length;
  let count = 0;
  let result = 0;
  let nowGas = 0; // 行驶过程中，当前剩余汽油
  const left = []; // 剩余油量／相差
  for (let i = 0; i < len; i++) {
    left[i] = gas[i] - cost[i];
    count += left[i];
    nowGas += left[i];
    // 小于0表示不是从之前的result出发
    // 继续尝试下一个点i+1
    if (nowGas < 0) {
      nowGas = 0;
      result = i + 1;
    }
  }
  // 耗油量 > 加油量
  return count < 0 ? -1 : result;
};
```


## 跳跃游戏
https://leetcode-cn.com/problems/jump-game/

给定一个非负整数数组，你最初位于数组的第一个位置。

数组中的每个元素代表你在该位置可以跳跃的最大长度。

判断你是否能够到达最后一个位置。
```
示例 1:

输入: [2,3,1,1,4]
输出: true
解释: 我们可以先跳 1 步，从位置 0 到达 位置 1, 然后再从位置 1 跳 3 步到达最后一个位置。
```
```
示例 2:

输入: [3,2,1,0,4]
输出: false
解释: 无论怎样，你总会到达索引为 3 的位置。但该位置的最大跳跃长度是 0 ， 所以你永远不可能到达最后一个位置。
```

```js
var canJump = function(nums) {
  /**********回溯法O(n^2) */
  let len = nums.length;
  let result = false;
  
  function f (j) {
    if (j >= len - 1) result = true; 
    if (result) return;
    // for (let i = 0; i < nums[j] && i < len; i++) {
    for (let i = nums[j] - 1; i >= 0; i--) {
      f(j+i+1);
    }
  }

  f(0);
  return result;
  

  /**********O(n) */
  let maxI = 0; // 最远能去到的i
  for (let i = 0; i < nums.length; i++) {
    // i>maxI表示不可能跳到i这个位置的
    if (i > maxI) return false;
    // i+num[i]表示当前位置i最远能去到的位置
    maxI = Math.max(maxI, i + nums[i]);
  }
  return true;

  // 反过来遍历也可以
};
```