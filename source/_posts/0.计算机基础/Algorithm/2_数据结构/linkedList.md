---
title: 链表
toc: true
date: 2020-03-20 00:00:03
tags:
---

## 一些技巧
* 打草稿，思路不容易乱
* 链表的插入操作不需要挪位置（对比数组）
* 快慢双指针可以找到链表中点，以及判断是否存在循环链路
* 减少`while`循环里的特判
  * while循环之后再处理剩余特殊节点
  * 使用哨兵节点减少`while`里的特殊逻辑
```js
let prevHead = new ListNode(-1)
prevHead.next = head;
```

## 环形链表

给定一个链表，判断链表中是否有环。

为了表示给定链表中的环，我们使用整数 pos 来表示链表尾连接到链表中的位置（索引从 0 开始）。 如果 pos 是 -1，则在该链表中没有环。

 
```
示例 1：

输入：head = [3,2,0,-4], pos = 1
输出：true
解释：链表中有一个环，其尾部连接到第二个节点。
```
![](https://assets.leetcode-cn.com/aliyun-lc-upload/uploads/2018/12/07/circularlinkedlist.png)

```
示例 2：

输入：head = [1,2], pos = 0
输出：true
解释：链表中有一个环，其尾部连接到第一个节点。
```
![](https://assets.leetcode-cn.com/aliyun-lc-upload/uploads/2018/12/07/circularlinkedlist_test2.png)


```
示例 3：

输入：head = [1], pos = -1
输出：false
解释：链表中没有环。
```
![](https://assets.leetcode-cn.com/aliyun-lc-upload/uploads/2018/12/07/circularlinkedlist_test3.png)


```js
var hasCycle = function(head) {
  let p = head;
  const s = new WeakSet();

  while (p) {
    if (s.has(p)) return true;
    s.add(p);
    p = p.next;
  }

  return false;
};


// 空间O(1)
// 采用双指针，一个指针一次走一步，一个指针一次走两步，如果有环的话，那么这两个指针一定会相遇。
var hasCycle = function(head) {
  let slow = head;
  let fast = head ? head.next : null;
  
  while (fast) {
    if (slow === fast) return true;
      
    slow = slow.next;
    fast = fast && fast.next ?
        fast.next.next : null;
  }
  
  return false;
};
```


## 反转链表
反转一个单链表。
```
示例:

输入: 1->2->3->4->5->NULL
输出: 5->4->3->2->1->NULL
```
```js
var reverseList = function(head) {
  if (!head) return null;

  // 1 -> 2 -> 3 -> 4
  let prev = null;
  let cur = head;

  while (cur) {
    const next = cur.next;
    cur.next = prev;
    prev = cur;
    cur = next;
  }

  return prev;
};
```
