---
title: DNS
toc: true
date: 2020-03-03 00:00:04
tags:
---

## DNS 域名解析服务器
将域名解析为IP地址
* 优先读缓存： 浏览器 > 系统 > 路由器 > ISP > DNS
* 先询问root DNS，再询问顶级域名DNS，再询问域名解析商（顶级域名是指com, cn这些）
![](/img/Snip20200304_12.png)


### 根据顶级域名分布式部署
![](/img/Snip20200304_13.png)
