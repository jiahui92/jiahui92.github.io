---
title: DNS
toc: true
date: 2020-03-03 00:00:04
tags:
---

## DNS 域名解析服务器
将域名解析为IP地址
* 优先读缓存： 浏览器 > 系统 > 路由器 > ISP > DNS递归查询
* 从rootDNS获取到顶级域名服务器的地址 `-->` 再从TLD顶级域名DNS获取到 `-->` 最后再询问域名解析商
  * rootDNS: 全球只有13台，用于保存顶级域名的地址
  * TLD顶级域名: 指com, cn这些
  * 域名解析商: 阿里万网之类的

<!-- ![](/img/Snip20200304_12.png) -->
![](https://user-gold-cdn.xitu.io/2018/12/22/167d5d6b03fe52c5?imageView2/0/w/1280/h/960/format/webp/ignore-error/1)




### 根据顶级域名分布式部署
![](/img/Snip20200304_13.png)


## 其他资料
* [ICANN](https://www.ruanyifeng.com/blog/2018/05/root-domain.html)
