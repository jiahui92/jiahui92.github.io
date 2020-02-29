---
title: 1px
toc: true
date: 2020-02-29 00:00:03
tags:
---

设计说这个1px border在苹果手机下显示起来太粗了（比如下图的"normal"），需要展示成下图的"all"
![](/img/Snip20200229_23.png)

## 基础概念
* 设备像素/物理像素dp: device pixel
* 设备像素比dpr: device pixel ratio
* rentina屏幕: 视网膜屏幕，dpr > 1
* css像素 px
  * px是一个相对单位
  * 1px在1dpr屏幕下为1dp
  * 1px在2dpr屏幕下为2dp

这样开发者使用1px时，  rentina屏幕将用多个物理像素来显示，防止过小。不同手机下的1px也差不多大小。



## 1dp解决方案
当想要在rentio屏显示1dp的border时，有三个办法

### .hairlines + transform
transform: scale(0.5) 缩小1px的border
```js
if (window.devicePixelRatio && devicePixelRatio >= 2){
    document.body.className += ' hairlines';
}
```
```css
.hairlines .line {
    position: relative;
    margin-bottom: 20px;
    border:none;
}
.hairlines .line:after{
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    border: 1px solid #000;
    box-sizing: border-box;
    width: 200%;
    height: 200%;
    transform: scale(0.5); /* 3倍屏下可能会显示为1px | 1.5px | 2px */
    transform-origin: left top;
}
```


### 0.5px
IOS8以下和部分安卓设备的rentina不支持0.5px，该方案下这些设备依然会显示"1px"(dpr个dp)
```js
if (window.devicePixelRatio && devicePixelRatio >= 2) {
  var testElem = document.createElement('div');
  testElem.style.border = '.5px solid transparent';
  document.body.appendChild(testElem);
  if (testElem.offsetHeight == 1)
  {
    document.querySelector('html').classList.add('hairlines');
  }
  document.body.removeChild(testElem);
}
```
```css
div { border: 1px solid #000; }
.hairlines div { border-width: 0.5px; }
```

### meta.viewport.scale = 1/dpr
这个办法有点得不偿失，比如原来浏览器默认的`body.fontSize:16px`，将会变得很小（变成未修改前的8px）。并且有些安卓容器没开启meta.viewport的设置。所以一般都不采用。