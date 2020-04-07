---
title: http
toc: true
date: 2020-03-04 00:00:02
tags:
---


## HTTP1.1
* 长连接keep-alive：复用TCP连接
* cache 缓存
	* Cache-Control
	* Expires
	* Last-Modified
	* Etag
* 断点续传
* 身份认证
* 状态管理

### 线头阻塞
HTTP1的请求是串行的，如果前面的请求太慢了，就会阻塞到后面的请求。HTTP2帧编码，乱序执行，就不会有阻塞了。
![](/img/Snip20200304_17.png)




## HTTP2.0
【[参考资料](https://juejin.im/post/5c88f2066fb9a049c043e420)】
【[google参考资料](https://developers.google.com/web/fundamentals/performance/http2)】


### 多路复用
keep-alive只是复用了TCP连接，但是多个文件需要串行请求，此时浏览器就做了一个优化，启动6~8个TCP连接来并行请求多个文件，但是这样子给服务器带来了一定的压力，不能够同时服务更多的用户（每个用户同时占用了多个TCP连接）。 多路复用后**同域名的所有通信都在一个TCP连接上完成**，将多TCP改为了多流通道，但是浏览器也会限制流通道的数目，并且request和response可以并行。【[参考资料1](https://github.com/Advanced-Frontend/Daily-Interview-Question/issues/14)】【[参考资料2](https://zhuanlan.zhihu.com/p/29609078)】

![](https://pic1.zhimg.com/80/v2-dc7e9d5a6e2fe235fbf4687554998478_720w.jpg)



### 分桢、流传输
解决http1.0的线头阻塞 【[参考资料](https://www.cnblogs.com/purpleraintear/p/6026071.html)】
1. 分帧：将数据分为header、data等帧
2. 流传输：帧编码、乱序、并行
![](/img/Snip20200304_16.png)

```
DATA : 数据帧
HEADERS : 头部帧
PRIORITY : 设置流的优先级
RST_STREAM : 终止流
SETTINGS : 设置连接参数
PUSH_PROMISE : 服务器推送模拟请求帧
PING : 用来计算RTT时间和看是否服务器挂了的Stream
GOAWAY : 告诉对方停止再向当前连接创建stream
WINDOW_UPDATE : 流量控制
```

### 头部压缩
* 维护一份静态字典，用序号index来代表具体值，比如‘2’来表示"method:GET"。
* 同时也会维护一份动态表，将带指令的cookie等值存储进动态表，下次只需要发序号即可。
* 长度超过1字节的headerName也会被哈夫曼编码压缩

![](/img/Snip20200304_18.png)

压缩前后对比53%

![](/img/Snip20200304_19.png)

![](https://developers.google.com/web/fundamentals/performance/http2/images/header_compression01.svg)


### 服务端推送
这个功能貌似是鸡肋，性能提升不多，只有8%，且需要配置nginx；【[参考资料](https://www.ruanyifeng.com/blog/2018/03/http2_server_push.html)】【[搭配cookie进行Server Push](https://cloud.tencent.com/developer/article/1030524)】【[PUSH_PROMIS](https://cloud.tencent.com/developer/article/1004340)】

![](/img/Snip20200304_20.png)
```nginx
location \ {
  ...
  https_push /style.css;

  # 假如浏览器端存在缓存版本的话，那么服务端继续推送会造成资源浪费，所以需要优化一下，在第一次访问时种下cookie，之后的访问都不主动推送了。
  add_header Set-Cookie "session=1";
  add_header Link $resources;
}
```
推送资源受限于RequestHeader的`:authority: cdn.bootcss.com`字段的同源策略；

### 伪头部字段
http2中默认部分字段采用伪Header字段 `:method` `:scheme` `:status` `:path` `:authority` 来代替HTTP1的大写字段；


### 向下兼容HTTP1.x
【[参考资料](https://segmentfault.com/a/1190000002896785)】
* 在HTTP情况下，浏览器通过下面的`Upgrade:h2c`字段表明自己支持HTTP2，如果服务端也支持的话，则会返回`101 Switching Protocol`；
* 在HTTPS情况下，浏览器和服务器在TLS握手阶段决定好用什么协议；
```
GET / HTTP/1.1
Host: server.example.com
Connection: Upgrade, HTTP2-Settings
Upgrade: h2c
HTTP2-Settings: <base64url encoding of HTTP/2 SETTINGS payload>


HTTP/1.1 101 Switching Protocols
Connection: Upgrade
Upgrade: h2c
```


## HTTP3.0
本质是http3（HTTP/2 over QUIC）将基于UDP，从而减少了连接时间【[参考资料](https://www.zhihu.com/question/302412059)】
* 大大缩短连接建立时间
* 改进的拥塞控制


