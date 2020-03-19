---
title: 动态规划
toc: true
date: 2020-03-18 00:00:03
tags:
---

## 零钱兑换
https://leetcode-cn.com/problems/coin-change/

给定不同面额的硬币 coins 和一个总金额 amount。编写一个函数来计算可以凑成总金额所需的最少的硬币个数。如果没有任何一种硬币组合能组成总金额，返回 -1。

```
示例 1:

输入: coins = [1, 2, 5], amount = 11
输出: 3 
解释: 11 = 5 + 5 + 1
```
```
示例 2:

输入: coins = [2], amount = 3
输出: -1
```
说明:
你可以认为每种硬币的数量是无限的。

```js

// 动态规划: O(m*n) + 剪枝
var coinChange = function(coins, amount) {

  const dp = new Array(amount + 1).fill(Infinity);

  dp[0] = 0;

  for (let i = 1; i <= amount; i++) {
    for (let c of coins) {
      if (i - c >= 0) {
        // dp[i - c] + 1 表示 在"i-c"这个价格上，+1枚硬币
        dp[i] = Math.min(dp[i - c] + 1, dp[i]);
      }
    }
  }

  // coins: [1,2,5], amount: 11
  // dp: [ 0, 1, 1, 2, 2, 1, 2, 2, 3, 3, 2, 3 ]

  return Number.isFinite(dp[amount]) ? dp[amount] : -1;
}


// 回溯法: O(m*n) 无剪枝
var coinChange = function(coins, amount) {

  if (amount == 0) return 0;

  // coins 排序
  coins.sort((a, b) => a - b < 0 ? -1 : 1);

  let result = -1;
    
  function f (useArr = [], leftAmount) {

    if (result > -1) return;

    for (let i = coins.length - 1; i >= 0; i--) {
      const newUseArr = [...useArr, coins[i]];
      const left = leftAmount - coins[i];
      if (left > 0) {
        f(newUseArr, leftAmount - coins[i]);
      } else if (left == 0) {
        result = newUseArr.length;
      }
    }
  }

  f([], amount);

  return result;
};
```

