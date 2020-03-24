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
https://leetcode-cn.com/problems/linked-list-cycle/

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
https://leetcode-cn.com/problems/reverse-linked-list/

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

## 奇偶链表
https://leetcode-cn.com/problems/odd-even-linked-list/

给定一个单链表，把所有的奇数节点和偶数节点分别排在一起。请注意，这里的奇数节点和偶数节点指的是节点编号的奇偶性，而不是节点的值的奇偶性。

请尝试使用原地算法完成。你的算法的空间复杂度应为 O(1)，时间复杂度应为 O(nodes)，nodes 为节点总数。

```
示例 1:

输入: 1->2->3->4->5->NULL
输出: 1->3->5->2->4->NULL
```
```
示例 2:

输入: 2->1->3->5->6->4->7->NULL 
输出: 2->3->6->7->1->5->4->NULL
```
说明:

应当保持奇数节点和偶数节点的相对顺序。
链表的第一个节点视为奇数节点，第二个节点视为偶数节点，以此类推。

```js
var oddEvenList = function(head) {
  if (!head) return null;
  
  let p = head;
  let head2 = p.next;
  let q = p.next;

  // 1->2->3->NULL
  // 1->2->3->4->NULL
  
  while (q) {
    p.next = q ? q.next : null;
    if (p.next) p = p.next;
    q.next = p.next;
    q = p.next;
  }

  p.next = head2;

  return head;
};
```
