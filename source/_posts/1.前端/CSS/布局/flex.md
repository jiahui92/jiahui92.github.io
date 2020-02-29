---
title: flex
toc: true
date: 2020-02-29 00:00:01
tags:
---

兼容性 98%
* IE 10 partial, IE 11
* mobile 100%支持

## flex关注点
* 父容器属性
	* 主轴
	* 交叉轴
* 子元素属性
	* 宽 | 高 | 比例
	* 位置


### 父容器属性
#### justify-content
* flex-start
* flex-end
* center
* space-between
* space-around

#### align-items
* flex-start
* flex-end
* center
* stretch !!!

#### 其余
* flex-flow: flex-direction flex-wrap
* flex-direction: row|row-reverse|column|column-reverse
* flex-wrap: nowrap|wrap|wrap-reverse


### 子元素属性
#### flex
flex单值时
* 有单位则为flex-basis ( 10px, 10rem, auto )
* 无单位则为flex-grow (1,2,3)

flex两值时
* flex-grow | flex-basis
* flex-grow | flex-shrink

flex三值时
* flex-grow | flex-shrink | flex-basis

flex默认值或none时
* flex: 0 0 auto


#### align-self (mobile 91%)
* flex-start
* flex-end
* center
* stretch


#### 其余
* order: 按照从小到大的顺序来排列
