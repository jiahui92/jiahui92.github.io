---
title: Network Access Layer
toc: true
date: 2020-03-03 00:00:01
tags:
---

## 两种网
* WAN: 广域网 Wide Area Network
* LAN: 局域网 Local Area Network
* WLAN: 无线局域网 Wireless LAN

以路由器为例子，WAN表示对外的接口，连接运营商，而LAN和WLAN是对内的接口【[参考资料](https://blog.csdn.net/github_27263697/article/details/79482078)】



## 网际相连
一次互联网请求的过程： DNS --> IP --> 子网掩码 --> ARP --> MAC地址 【[参考资料](https://www.cnblogs.com/JuneWang/p/3917697.html)】
1. 通过DNS将域名解析成IP
2. 通过子网掩码计算当前IP与目标IP是不是在同一个局域网内
3. 是的话通过ARP获取MAC，如果不是的话，则要通过默认网关去寻找
4. 网关重复1的过程


### 有了 IP 地址，为什么还要用 MAC 地址
【[参考资料](https://www.zhihu.com/question/21546408)】
* 历史遗留问题：早期的网络比较小，所以只通过MAC地址来寻址，但现在网络比较大，不可能记录完毕所有的MAC地址，所以引入了“局域网”和IP的概念。现在也无法改变，每帧数据都会带下一跳地址（MAC地址）
* DHCP和交换机都基于MAC地址

#### 路由器和交换机的区别
* 交换机通常用来组建一个局域网，不支持ip，只支持MAC；便宜、高效；
* 路由器通常用来联通两个局域网，并且会给每台机器分配一个ip；本质也是一个交换机；


## PPP Point-to-Point Protocol 点对点
【[参考资料](https://www.kancloud.cn/lifei6671/tcp-ip/139863)】

* 封帧
* 差错检测: 立即抛弃有错误的帧，防止浪费网络资源

![](/img/Snip20200304_3.png)

* 每一帧开头结尾都是0x7E
* “协议”的值表示协议的类型
	* 0x0021 代表信息部分为IP数据报
	* 0xC021 链路控制数据
	* 0x8021 网络控制数据
* CRC用于差错检测


## Ethernet 以太网
以太网与PPP区别【[参考资料](https://www.zhihu.com/question/52725372)】
* 以太网是设计给广播网络，PPP设计用于点对点网络
* 以太网的帧头包含`目的MAC地址`和`源头MAC地址`，而PPP的因为双都知道对方的地址了，所以帧头里就不需要带上自己的地址信息了

![很多协议都基于Ethernet](/img/Snip20200304_6.png)



