---
title: cookie
toc: true
date: 2020-09-13 00:00:12
tags:
---

![](/img/Snip20200913_2.png)
* name
* value
* domain
* path
* Expired/Max-age
* HttpOnly: 为true时js不能读取，更安全


## Secure
是否只能在https下被读取【[参考资料](https://segmentfault.com/q/1010000013060848/a-1020000013062426)】


## SameSite
普及之后可以替换jwt方案（CSRF攻击），但有兼容性问题：[caniuse 93%](https://caniuse.com/same-site-cookie-attribute)
* `strict | lax | none` 【[参考资料](https://www.ruanyifeng.com/blog/2019/09/cookie-samesite.html)】
* strict: 这个规则过于严格，可能造成非常不好的用户体验。比如，当前网页有一个 GitHub 链接，用户点击跳转就不会带有 GitHub 的 Cookie，跳转过去总是未登陆状态。
* lax: 目前浏览器默认行为，只有在导航行为或GET请求时（比如点击a链接），才会将对应域名的cookie发送出去
* none: 在设置了`Secure`时，可以设置此值，将会在任何情况下都发送cookie

## 后端设置cookie
通过在response.header中`Set-Cookie`来设置

