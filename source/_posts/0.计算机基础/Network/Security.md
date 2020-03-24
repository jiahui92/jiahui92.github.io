---
title: 安全
toc: true
date: 2020-03-03 00:00:10
tags:
---


## XSS
cross site script 跨站脚本攻击 【[参考资料](https://tech.meituan.com/2018/09/27/fe-security.html)】
* 存储型：往评论、文章等注入，然后返回给前端
* 插入型：往url上插入script等代码
* document.referer：利用js里用到这个变量

```html
<!-- 文章注入 -->
<img onerror="alert(1)" />

<!-- 评论注入 -->
<script>alert(1)</script>
```


### 应对
* 后端保存和读取前都过滤一下
* 前端展示前用xss库过滤一下
* 谨慎用eval
* CSP


#### CSP
指定某些资源只能够从某些域名加载，否则上报警告【[参考资料](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/CSP)】
Content-Security-Policy
* default-src: 未配置的取这个值
* img-src
* script-src
* media-src
* report-uri 上报警告的url


------------------


## CSRF
Cross-site request forgery 跨站请求伪造 【[参考资料](https://www.cnblogs.com/HYDDD/ARCHIVE/2009/04/09/1432744.HTML)】
* 引导用户访问该链接 `https://xxx.com/delete/1`
* 引导用户访问包含该代码的页面 `<img src="https://xxx.com/delete/1" />`
* 用隐藏form表单跨域POST
* 嵌入iframe，然后遮挡住iframe里的重要按钮，引导用户去点击



### 应对
* 使用POST请求并带上token [koa-jwt插件](https://juejin.im/post/5c009f02f265da616301c978) [jwt的缺陷](https://learnku.com/articles/22616)
* X-OPTIONS-FRAME等 [koa-helm插件](https://cnodejs.org/topic/5a502debafa0a121784a89c3)


------------------

## SQL注入
* [使用sequelize等ORM类库](https://github.com/sequelize/sequelize)
* 使用query函数的查询参数占位符
```js
connection.query('select * where name = ?', [name], () => {
  // xxx
})
```

------------------



## 反爬虫
* 要求登录
* 限制ip
* user-agent
* 验证码


## HTTP劫持
HTTP的风险：窃听、篡改、冒充；可以升级到HTTPS来防御；


## SYN flood
TCP连接的第一个包，非常小的一种数据包。SYN 攻击包括大量此类的包，由于这些包看上去来自实际不存在的站点，因此无法有效进行处理。每个机器的欺骗包都要花几秒钟进行尝试方可放弃提供正常响应。【[参考资料](https://baike.baidu.com/item/syn)】
* 服务器减少等待时间
* 服务器取消重复发送确认请求
* Serverless laas
* failban: 禁用ip


## DNS劫持和劫持
【[参考资料](https://www.inforsec.org/wp/?p=3161)】
DNS Sec: 加密DNS解析请求


## ARP攻击
【[参考资料](https://www.zhihu.com/question/23401171)】
* 动态ARP检测：记录MAC和IP的绑定
* ARP防火墙

