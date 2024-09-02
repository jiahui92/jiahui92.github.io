---
title: webrtc
toc: true
hidden: true
date: 2020-04-07 00:00:01
tags:
---
Web Real-Time Communication

# 概念
[一文看懂WebRTC建连过程](https://juejin.cn/post/7323087699479838730)
[![](image.png)](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/663812cc30334d299f0b1de90fadbfec~tplv-k3u1fbpfcp-jj-mark:3024:0:0:0:q75.awebp#?w=3718&h=1808&s=242340&e=png&b=f0f4fc)
* ICE
  * STUN协议: 获取本机的内网地址或公网地址&端口
    * [Free STUN server](https://gist.github.com/sagivo/3a4b2f2c7ac6e1b5267c2f1f59ac6c6b)
  * TURN协议：STUN直连失败时的备用方案，相当于增加一台中继服务器来传输数据
  * [ICE Test](https://webrtc.github.io/samples/src/content/peerconnection/trickle-ice/)
* SDP: 协商使用何种格式/类型的video等数据进行传输
  * offer, answer

如无特殊情况，建议使用[peerjs](https://github.com/peers/peerjs)，自带免费的信令服务器用于交换ice，api也十分简洁【[demo](https://github.com/jiahui92/playground/blob/master/web-rtc/src/web-rtc.ts)】



# NAT的穿透性
* [五种NAT的穿透性](https://zhuanlan.zhihu.com/p/108635427)，并非所有NAT都是可穿透的，比如对称型NAT
  * [对称型NAT穿透可行性：预测端口](https://blog.csdn.net/l807575/article/details/104382094)
* 其余P2P: IPV6, 花生壳DDNS



# 其它参考资料
[知乎问答：可以用WebRTC来做视频直播吗？](https://www.zhihu.com/question/25497090/answer/43395462?utm_source=com.youdao.note&utm_medium=social&utm_oi=778052917897728000)
* 只适合8人以内视频会议，不适合直播
* P2P
  * ipv4穿透
  * 网络不稳定

[WebRTC 点对点直播](https://segmentfault.com/a/1190000008416360?utm_medium=referral&utm_source=tuicool)