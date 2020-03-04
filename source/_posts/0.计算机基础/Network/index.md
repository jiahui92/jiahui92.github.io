---
title: OSI
toc: true
date: 2020-03-03 00:00:00
tags:
---

## OSI
Open Systems Interconnection Model
这种分层模型的好处就是可以对任何一层进行独立升级、优化，只要保持接口不变那么这个模型整体就不会有问题，比如说物理层从以太网线到光纤，我们的网络速度大大提高，但是整个技术革新的时候，其他层是没有做更多工作的，工作只在物理层完成。这样做的好处也同时提高了我们技术的发展革新速度。
* 应用层
* 会话层
* 传输层
* 网络层
* 数据链路层
* 物理层

然而实际中并没有使用七层模型(OSI)，而是简化后的四层模型(TCP/IP)

![](/img/Snip20200303_2.png)


## TCP/IP
【[参考资料](https://zhuanlan.zhihu.com/p/34740683)】

### 应用层 Application Layer
定义了应用交换数据的协议，按照协议将传输的内容进行格式转换（文字、图片、视频）并加密，或者根据协议进行解读。例子：HTTP、DNS

### 传输层 Transport Layer
分割数据，并往上加一些标记，比如当前应用的端口号。例子：TCP/UDP

### 互联网层 Internet Layer
数据分组，并在分组头部加上目标地址的IP

### 网络访问层 Network Access Layer
最后将数据转化为二进制，寻找MAC地址，开始发送


### TCP/IP协议族
基于TCP/IP协议【[参考资料](https://www.runoob.com/tcpip/tcpip-protocols.html)】
> TCP, IP, HTTP, HTTPS, SSL, SMTP, DHCP, ICMP, ARP, RARP
