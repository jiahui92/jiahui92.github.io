---
title: index
toc: true
date: 2020-03-11 00:00:00
tags:
---

* [MDN HTML 标签](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element)
* 语义化的标签通常是为了SEO和方便盲人阅读设备识别



## base
自动补充页面上所有的url链接和`<a>`标签target的属性【[参考资料](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/base)】；本质是修改了`document.baseURI `的值，默认值为`location.href`；
```html
<head>
  <base href="http://www.w3school.com.cn/i/" />
  <base target="_blank" />
</head>

<body>
  <!-- 相当于 src="http://www.w3school.com.cn/i/eg_smile.gif" -->
  <img src="eg_smile.gif" />
  <!-- 自动往a标签增加target属性 -->
  <a href="http://www.w3school.com.cn">W3School</a>
  <!-- 相当于 href="http://www.w3school.com.cn/i/index.html" -->
  <a href="index.html">W3School</a>
  <!-- 这个href不会被改变 href="http://www.w3school.com.cn/index.html" -->
  <a href="/index.html">W3School</a>
</body>
```


## pre
通常用来显示后台在`<textarea>`中编辑的信息，直接用div展示的话，换行符不会展示出来；或者使用`white-space:pre-wrap`代替；



## bdo
改变文本的显示方向，从左到右，或从右到左
```html
<p>This text will go left to right.</p>
<p><bdo dir="rtl">This text will go right 
to left.</bdo></p>
```

