---
title: App Shell
toc: true
date: 2020-03-01 00:00:04
tags:
---

### 骨架屏
【[参考资料](https://korbinzhao.github.io/%E5%89%8D%E7%AB%AF%E5%BC%80%E5%8F%91/%E9%AA%A8%E6%9E%B6%E5%B1%8F/2018/06/23/skeleton-auto-generator/)】
* puppeteer渲染
* 移除非首屏元素及其css（移除无关css的技巧：直接使用querySelector去查询该css的选择器，如果查询不到，则表示这个css是无用的）
* 修改img,a,text的样式，比如imgSrc替换为背景色
* 生成base64图片（比生成html+css小很多，4k vs 23k）
* 输出到html


#### 插件 
[vue-page-skeleton-webpack-plugin](https://github.com/ElemeFE/page-skeleton-webpack-plugin)
