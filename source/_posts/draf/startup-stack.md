---
title: startup stack
toc: true
hidden: true
date: 2020-04-07 00:00:02
tags:
---

【web、小程序、app】、pc、chrome插件


## 技术栈
主要与cloudflare, vercel等云服务商提供的免费服务有关
* frontend
  * SSG: Hugo/Hexo, Nextjs
    * nextUI/shadcn
  * SSR: Nextjs/Remix
  * CSR
* backend:
  * static: cloudflare pages
  * cpu: cloudflare worker, supabase/firebase
  * db: cloudflare D1, TiDB Cloud, supabase
  * kv: cloudflare
* crawler: crawlee

## 流量
* seo
  * 关键词：日常流量+长尾、难度<20、trending
  * 外链: seo联盟
  * 主动向搜索引擎提交链接
* 自媒体
  * tiktok, youtube, reddit, producthunt
* 邮箱营销
* 广告
* 拉新

### seo tech checklist
* [ ] favicon
* [ ] title(50), desc(150)
* [ ] sitemap
* [ ] robots.txt
* [ ] google analytics
* [ ] [JSON-LD](https://schema.org/docs/schemas.html)
* [ ] open graph
  * title, description, image
  * site_name, url, type
  * updated_time, author, article
* [ ] indexNow: update frequently
* [ ] backlinks
  * [ ] [auto link](https://www.zhanid.com/tool/wailian.html)
  * [ ] 社交平台
    * [ ] GSA Search Engine Ranker
  * [ ] 友链
    * [ ] 信息收录平台
* [ ] [seo checklist](https://seo.chinaz.com/)


## 云服务对比
国内cloudflare速度比较慢，但总体是费率比较低的云服务

### function
worker是无状态的，相比gcloud是express实例（数据库连接池、ip-limit）
* cloudflare worker: 300w req/month
* google cloud: 200w req/month 按量计费
* aws: 100w req/month 按量计费

### DB
这些db都是需要使用后端进行网络连接，所以都会有挺大的网络延迟，除非后端本身离数据库很近，比如cloudflare worker
* cloudflare D1
  * 5gb, 10b~1m req/month
  * 类SQLite, 分布式数据库, 自动备份近30天
  * 底层使用http进行访问；无数据库连接池
* TiDB Cloud
  * 5gb, 20b req/month (可以创建5个实例)
  * 类MySQL，分布式数据库


### Login
* OAuth
  * [apply](https://github.com/mthli/lemonsqueepy/wiki/Tutorial-%28Chinese%29)
  * backend: [grant](https://github.com/simov/grant)
    * google cloud function: free 200k/month
  * frontend: [react-oauth](https://www.npmjs.com/package/@react-oauth/google)
* Email+jwt验证: 量大的话需购买SMTP服务，否则会有发送数量限制或被当作垃圾邮件
  * gmail: 500/day
  * outlook: 300/day
  * zoho: 5k/month
  * Amazon SES: 1k/month, 超过后 0.1$/1k
* chrome extension
  * chrome.identity.getProfileUserInfo

### Pay
* 个人
  * Paddle (费率5.5%)
  * lemonsqueezy (费率8%)
  * gumroad (费率13%)
  * kodepay (集成了登录、但只有基础订阅功能，初期只能一次性付费)
  * 谷歌支付
* 企业
  * stripe
  * paypal
  * fastsprint, chargebee
* 其它
  * Ko-Fi (捐赠类)
  * Payoneer (收款)
