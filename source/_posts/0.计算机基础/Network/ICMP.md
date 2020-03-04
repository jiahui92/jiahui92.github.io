---
title: ICMP
toc: true
date: 2020-03-03 00:00:03
tags:
---

## ICMP 网络控制消息协议
* ICMP协议规定：目的主机必须返回ICMP回送应答消息给源主机。如果源主机在一定时间内收到应答，则认为主机可达。
* 当路由器端处理报文发生意外时（超时、ip不可达、端口不存在），会返回一个包含错误类型的ICMP报告给发送端。


### ping
ping命令是基于 IP 和 ICMP，不涉及UDP/TCP，因而不能`ping http://198.168.0.1`。【[参考资料](https://blog.csdn.net/inject2006/article/details/2139149)】

### traceroute
