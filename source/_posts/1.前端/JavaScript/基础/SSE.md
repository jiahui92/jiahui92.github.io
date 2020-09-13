---
title: 服务器推送 SSE
toc: true
date: 2020-09-13 00:00:13
tags:
---

## 短轮询
定时ajax，并且服务器马上返回请求

## 长轮询
定时ajax，服务器只等到有数据时才返回请求

## http流
利用readyState==3(接收状态) createStreamingClient，不让请求断开/结束

## SSE
Server-Send-Events 服务器响应的MIME必须是`text/event-stream`，[兼容性95%](https://caniuse.com/eventsource)
```js
var source = new EventSource("my.php");
source.open(); 
source.onmessage = function(e){e.data}; 
source.close()
```

## websocket
* 双向通道 要使用ws协议
* WebSocket兼容方案：组合XHR与SSE

```js
var socket = new WebSocket("ws/www.example.com/server.php");
socket.send("Message"); 
socket.onmessage = function(e){e.data}; 
socket.close()
```
