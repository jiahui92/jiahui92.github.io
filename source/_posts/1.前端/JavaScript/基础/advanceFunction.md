---
title: 高级函数
toc: true
date: 2020-09-13 00:00:08
tags:
---

# 闭包
缓存请求，通过key来获取

# 即使函数
定义函数后立即执行
```js
(function abc(){alert(1)})()
```

# 惰性函数
函数内部重定义自己
这样调用函数的时候，函数会被重定义
```js
function abc(){
    alert(1);
    function abc(){
        alert(2)
    }
}
```

# 柯里化
带记忆功能的函数
```js
add(3)(4)
```
