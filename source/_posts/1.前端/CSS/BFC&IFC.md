---
title: BFC&IFC
toc: true
date: 2020-02-27 20:17:37
tags:
---


## BFC
> BFC 可以简单的理解为某个元素的一个 CSS 属性，只不过这个属性不能被开发者显式得修改，拥有这个属性的元素对内部元素和外部元素会表现出一些特性，这就是BFC。【[参考资料1]([MDN.BFC](https://developer.mozilla.org/zh-CN/docs/Web/Guide/CSS/Block_formatting_context))】【[参考资料2](https://juejin.im/post/5909db2fda2f60005d2093db)】


### 触发BFC的条件
* 浮动元素float
* position: absoulte | fixed
* display: block | inline-block | flex
* overflow: hidden | auto | scroll

### BFC的作用
* BFC是一个封闭的大箱子，里面无论怎么弄，都会包裹子元素
  * BFC父元素会包裹子元素的margin
  * BFC父元素会包裹浮动的子元素
  * 特殊情况：只会被包裹inline子元素的content，其余被截断或超出父元素（overflow:hidden截断 | position:absolute超出）；但超出部分还是不会影响外部元素的排列；
* BFC元素不会被floatBox覆盖，普通元素会被覆盖（防止floatLeft覆盖rightDiv／取消img环绕效果）
* 相邻块级BFC的垂直margin会发生折叠
* 两列布局：自适应宽度

<p class="codepen" data-height="600" data-theme-id="dark" data-default-tab="result" data-user="guangjun" data-slug-hash="WNvjydB" style="height: 265px; box-sizing: border-box; display: flex; align-items: center; justify-content: center; border: 2px solid; margin: 1em 0; padding: 1em;" data-pen-title="BFC">
  <span>See the Pen <a href="https://codepen.io/guangjun/pen/WNvjydB">
  BFC</a> by guangjun (<a href="https://codepen.io/guangjun">@guangjun</a>)
  on <a href="https://codepen.io">CodePen</a>.</span>
</p>
<script async src="https://static.codepen.io/assets/embed/ei.js"></script>


## IFC
> inline/inline-block元素会有一套默认的垂直对齐规则，有时候会对不齐，使用`vertical-align`设置即可【[参考资料](https://www.cnblogs.com/leolovexx/p/9873278.html)】
![alt](/img/Snip20200228_14.png)

* inline元素的baseline，为内容盒content-box里面文本框的基线
* 如果inline-block内部有内容，则baseline为内容最下方的baseline
* 如果Inline-block内部无内容，则baseline与margin-box的下边缘重合
* 如果overflow属性不为默认值visible，则baseline与margin-box的下边缘重合
