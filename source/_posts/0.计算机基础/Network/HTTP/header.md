---
title: header
toc: true
date: 2020-03-04 00:00:01
tags:
---

## Status
【[参考资料](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Status)】
* 1xx: 信息响应
  * 101 Switching Protocol
  ```
  HTTP/1.1 101 Switching Protocols
  Upgrade: websocket
  Connection: Upgrade
  ```
* 2xx: 成功响应
* 3xx: 重定向
  * 301
    * Move Permanently 永久重定向；
    * 优化SEO：直接跳转到首页，权重给到新域名；
  * 302
    * Move Temperarily 临时重定向
  * 304
    * Not Modified 文件未修改，重定向到缓存文件
  * 303
    * POST重定向
  * 307
    * POST不重定向，302具有不确定性，浏览器实现不一样
* 4xx: 客户端响应
  * 400
    * Bad Request 由于客户端请求有语法错误，不能被服务器所理解
    * 403
    * Forbidden 服务器收到请求，但是拒绝提供服务。服务器通常会在响应正文中给出不提供服务的原因
* 5xx: 服务端响应
  * 500
    * Internal Server Error 服务器发生不可预期的错误，导致无法完成客户端的请求。



## Keep-Alive
HTTP协议的keep-alive 主要是为了让多个 http 请求共享一个 Tcp 连接，以避免每个 Http 又新建一个 TCP 连接。每个 Http 服务器默认的 keep-alive 时间可能是不一样的。


## Method
* `GET、POST`
* `OPTIONS`: CORS时，简单POST请求会直接请求，如果时非简单请求，会先发一个OPTIONS请求【[参考资料](http://www.ruanyifeng.com/blog/2016/04/cors.html)】
* `HEAD`: 只包含http header的请求
* `PUT、DELETE`: PUT，DELETE操作是幂等的。所谓幂等是指不管进行多少次操作，结果都一样。比如我用PUT修改一篇文章，然后再做同样的操作，每次操作后的结果并没有不同，DELETE也是一样。而连续调用多次POST方法可能会有副作用，比如将一个订单重复提交多次。每次调用的URI都是一样的，ID也在URI上，但要是后端实现不一样的话，这个接口也不能够被调用多次吧？


## CORS

* Origin: 包含客户端请求的协议、域名、端口
* Access-Control-Allow-Origin
* Access-Control-Allow-Methods
* Access-Control-Allow-Credentials
* 简单请求下，不会发Option请求【[参考资料](http://www.ruanyifeng.com/blog/2016/04/cors.html)】
![](/img/Snip20200304_22.png)



## Cache
![](/img/Snip20200304_23.png)

```
Cache-control: must-revalidate
Cache-control: no-cache
Cache-control: no-store
Cache-control: no-transform
Cache-control: public
Cache-control: private
Cache-control: proxy-revalidate
Cache-Control: max-age=<seconds>
Cache-control: s-maxage=<seconds>
```

【[参考资料](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Caching_FAQ)】

### 无缓存 no store
```
Cache-Control: no-store
```

### 协商缓存 shared cache
```sh
Cache-Control: no-cache

# 用于兼容HTTP/1.0的客户端
Pragma: no-cache
```
第一次请求时，服务器可以给浏览器传ETag或Last-Modified；下次请求时浏览器会根据此标记决定要不要重新下载文件；

#### ETag
* If-Match
* If-None-Match

#### Last-Modified
* If-Modified-Since
* If-Unmodified-Since


### 强缓存 private cache
```
Cache-Control: max-age=60, must-revalidate
```
must-revalidate的意思是"max-age=X, must-refetch"，一旦过期，必须重新请求整个文件

#### Expires
当用max-age时，这个会被忽略


### 代理服务器的缓存
`Cache-control: private` 则表示该响应是专用于某个用户，比如登录用户的，代理服务器不能缓存此响应。



## Cookie
* Set-Cookie: 服务端给客户端返回的cookie
* Cookie


## X-Requested-With
这个header不是标准，用于给服务器判断是不是ajax请求。【[参考链接](https://www.zhihu.com/question/30795602)】


## Encoding
### Accept
出现在Request Header中，表示客户端能接受什么类型的内容
```
accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3
```

### Content-Type
出现在Response Header中，表明这个资源的类型
```sh
text/html; charset=utf-8

multipart/form-data; boundary=-----xxxxx
```

### Accept-Encoding
```
accept-encoding: gzip, deflate, br
```

### Content-Encoding
```
content-encoding: gzip
```

### Transfer-Encoding
Transfer-Encoding 是一个用来标示 HTTP 报文传输格式的头部值。尽管这个取值理论上可以有很多，但是当前的 HTTP 规范里实际上只定义了一种传输取值——`chunked`。用于表示消息体由数量未定的块组成，并以最后一个大小为0的块为结束。

#### chunked 和 multipart区别
* chunked是服务端发起的，可以边计算边传输的
* `Content-Type: multipart`是浏览器端发起的，必须提前全部准备好的表单数据




## Vary
【[参考资料](https://imququ.com/post/vary-header-in-http.html)】
* `Vary: User-Agent` 缓存服务器要区分移动端和PC端来缓存
* `Vary: Cookie` 告诉代理机，如果设置缓存的话，应该根据Cookie的值来存储多份
* `Vary: Accept-Encoding` 有些实现得有 BUG 的缓存服务器，会忽略响应头中的 Content-Encoding，从而可能给不支持压缩的客户端返回缓存的压缩版本。有两个方案可以避免这种情况发生：
  * 将响应头中的 Cache-Control 字段设为 private，告诉中间实体不要缓存它；
  * 增加 Vary: Accept-Encoding 响应头，明确告知缓存服务器按照 Accept-Encoding 字段的内容，分别缓存不同的版本；



## Other
* Host
* Referer
* User-Agent
* Server: Apache/2.4.1 (Unix)
