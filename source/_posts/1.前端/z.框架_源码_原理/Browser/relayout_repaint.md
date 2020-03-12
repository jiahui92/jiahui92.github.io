---
title: 重排、重绘、合成
toc: true
date: 2020-03-12 00:00:02
tags:
---

![](/img/Snip20200312_1.png)

* 重排Relayout - Layout
* 重绘Repaint - Paint
* 合成 Composite


## 触发重排重绘
【[参考资料](https://www.ruanyifeng.com/blog/2015/09/web-page-performance-in-depth.html)】
* 添加、删除DOM节点会触发Relayout
* 写操作之后马上读取某些属性会引起Relayout（如果写操作后不重新计算Render Tree或Layout，那么后续js读取的值可能是错误的）
  * offsetTop/offsetLeft/offsetWidth/offsetHeight
  * scrollTop/scrollLeft/scrollWidth/scrollHeight
  * clientTop/clientLeft/clientWidth/clientHeight
  * getComputedStyle()
* dispaly:none之类的css变动，详细看接下来的内容



## 优化
【[参考资料](https://developers.google.com/web/fundamentals/performance/rendering?hl=zh-CN)】

![](/img/Snip20200312_4.png)
* 减少DOM数量以及简化层级
* documentFragement
* 批量修改dom再读取dom
* 使用position:fixed和absolute：元素改变后牵涉到的Layout变动范围比直接修改margin小


![](/img/Snip20200312_5.png)
* visibility:none只影响重绘，display:none影响重排重绘

![](/img/Snip20200312_6.png)
* 使用css动画属性transforms代替js操作：Composite／GPU可以利用Raster上传过的图片缓存处理动画效果，因此不影响重排重绘
* canvas和video等也是直接在Composite处理的


实际上，各浏览器的css实现存在差异，导致以上的优化并不是对每一个浏览器都有效的【[参考资料](https://csstriggers.com/)】
![](/img/Snip20200312_7.png)


### 最后的优化手段:will-change
将有动画的dom使用will-change提升到layer，并提前告诉浏览器即将要做什么变动，让浏览器做好准备（代替以往使用transform:translateZ(0)的做法）【[参考资料](https://developer.mozilla.org/en-US/docs/Web/CSS/will-change)】


```css
will-change: auto;
will-change: scroll-position;
will-change: contents;
will-change: transform;
will-change: opacity;
will-change: left, top;
```

不要一直挂着will-change[参考资料](https://blog.lbinin.com/frontEnd/CSS/will-change.html)
```css
/* Good */
.will-change-parent:hover .will-change {
  will-change: transform;
}
.will-change {
  transition: transform 0.3s;
}
.will-change:hover {
  transform: scale(1.5);
}

/* Good */
.will-change {
	transition: transform 0.3s;
}
.will-change:hover {
	will-change: transform;
}
.will-change:active {
	transform: scale(1.5);
}
```