---
title: CSS优先级
toc: true
date: 2020-02-27 00:00:01
tags:
---

* important
* 内联样式
* id
* class, attr, 伪类
* 标签选择器, 伪元素选择器
* 后面的css覆盖前面的（和className先后没有关系）



```html
<style>
  .green { bg: green }
  .red { bg: red }
</style>

<!-- 最终这个div是红色的 -->
<div class="red green"></div>

```
