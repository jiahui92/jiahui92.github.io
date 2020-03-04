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


### 多路复用
keep-alive只是复用了TCP连接，但是多个文件需要串行请求，此时浏览器就做了一个优化，启动6~8个TCP连接来并行请求多个文件，但是这样子给服务器带来了一定的压力，不能够同时服务更多的用户（每个用户同时占用了多个TCP连接）。 多路复用后**同域名的所有通信都在一个TCP连接上完成**，将多TCP改为了多流通道，但是浏览器也会限制流通道的数目，并且request和response可以并行。【[参考资料](https://github.com/Advanced-Frontend/Daily-Interview-Question/issues/14)】


### 分桢、流传输
解决http1.0的线头阻塞
1. 分帧：header、data等帧
2. 流传输：帧编码、乱序、并行
![](/img/Snip20200304_16.png)


### 头部压缩
* 维护一份静态字典，用序号index来代表具体值，比如‘2’来表示"method:GET"。
* 同时也会维护一份动态表，将带指令的cookie等值存储进动态表，下次只需要发序号即可。
* 长度超过1字节的headerName也会被哈夫曼编码压缩

![](/img/Snip20200304_18.png)

压缩前后对比53%
![](/img/Snip20200304_19.png)


### 服务端推送
这个功能貌似是鸡肋，性能提升不多，只有8%，且需要配置nginx【[参考资料](https://www.ruanyifeng.com/blog/2018/03/http2_server_push.html)】
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



## HTTP3.0
本质是http3（HTTP/2 over QUIC）将基于UDP，从而减少了连接时间【[参考资料](https://www.zhihu.com/question/302412059)】
* 大大缩短连接建立时间
* 改进的拥塞控制


