---
title: var&let
toc: true
date: 2020-09-13 00:00:01
tags:
---


# let
* 防止变量名提升
* 块级作用域


```javascript
for(let i) setTImeout(() => log(i))
// 外部无法访问i
// 内部有块级作用域，log(i)正常显示

// 最终被编译成
function _loop (i) {
	setTImeout(() => log(i) )
}

for(var i) _loop(i)  // i会被保存在_loop的栈内存中

```
