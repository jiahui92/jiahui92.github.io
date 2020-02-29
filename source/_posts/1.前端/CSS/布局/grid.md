---
title: grid
toc: true
date: 2020-02-29 00:00:02
tags:
---

兼容性 92%
* IE 10 partial
* Android 5
* not qq browser


兜兜转转又回到了table布局【[参考资料](https://juejin.im/entry/5894135c8fd9c5a19507f6a1
)】

### display
* grid
* inline-grid: 行内grid元素
* subgrid: 继承相关 (lv2 working draf)


### grid-template-rows & columns
```css
.container{
  grid-template-columns: 40px 50px auto 50px 40px;
  grid-template-rows: 25% 100px auto;
}
```
![](/img/Snip20200229_26.png)


### grid-template-areas
```css
.item-a{ grid-area: header; }  
.item-b{ grid-area: main; }  
.item-c{ grid-area: sidebar; }  
.item-d{ grid-area: footer; }  

.container{    
  width: 300px;
  height:200px;   
  display:grid;   
  grid-template-columns: 1fr 1fr 1fr 1fr;
  grid-template-rows: auto;
  grid-template-areas:
    "header header header header"   
    "main    main    .    sidebar"   
    "header footer header footer";
}
```
![](/img/Snip20200229_27.png)


### grid-column-gap, grid-row-gap
![](/img/Snip20200229_28.png)

### justify-items
![](/img/Snip20200229_29.png)

### align-items
![](/img/Snip20200229_30.png)

### justify-content
![](/img/Snip20200229_32.png)

### align-content
![](/img/Snip20200229_33.png)

### item/child的css
* grid-area
* justify-self
* align-self
* grid-column
* grid-row

```css
.item-a{
  grid-column: 1 / 2;
  grid-row: 2 / 3;
}  

.item-b{
  grid-column: 5 / 6;
  grid-row: 2 / 3;
}
```
![](/img/Snip20200229_34.png)


```css
.container {
  grid-auto-columns: 60px;
}
```
![](/img/Snip20200229_35.png)

