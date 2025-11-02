---
title: remote
toc: true
date: 2025-11-01 00:00:00
tags:
---

## 远程工具
* 远程桌面: toDesk, rustDesk, moonlight/sunshine
* ssh: tailscale

## 内网穿透
* ipv4, ipv6
* 

### 问题排查
* 动态域名: ddns-go


#### ipv6问题排查流程
* ipv6检测 https://testipv6.cn/
* ipv6测速 https://test.ustc.edu.cn/

* curl -v google.com
* 是否能联通: ping -6 ipw.cn
* dns服务: nslookup -type=AAAA ipw.cn 2001:4860:4860::8888
  * 查看nameserver的地址显示的是对应哪个设备的
* 设备跳转: tracert -6 2607:f8b0:4005:805::200e
  * 本机 --> 路由器 --> 光猫
* vpn: dns劫持模式不要使用fake-ip，改用redir-host
* 关闭路由器/光猫 防火墙（路由器或光猫改桥接/软路由）
* dns问题：设置网卡的dns服务，然后ipconfig /all 看下是否设置成功
```sh
## wsl .wslconfig
[wsl2]
networkingMode=mirrored
ipv6=true
```
