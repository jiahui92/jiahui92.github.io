---
title: 网络相关
toc: true
date: 2020-03-05 00:00:08
tags:
---




```sh
# 查看延迟和丢包
ping 192.168.1.1


# 相比ping，能查看到达服务器之前的中间网关信息
traceroute 192.168.1.1
  traceroute to 192.168.1.1 (192.168.1.1), 64 hops max, 52 byte packets
  1  xiaoqiang (192.168.31.1)  7.422 ms  4.277 ms  2.400 ms
  2  192.168.101.1 (192.168.101.1)  3.037 ms  3.310 ms  3.788 ms
  3  100.64.0.1 (100.64.0.1)  20.784 ms  13.596 ms  17.290 ms
  4  202.105.158.1 (202.105.158.1)  12.368 ms
      61.146.243.85 (61.146.243.85)  11.877 ms *


# 查看域名服务器地址
dig baidu.com
  ...
  ;; ANSWER SECTION:
  baidu.com.		30	IN	A	220.181.38.148
  baidu.com.		30	IN	A	39.156.69.79

  ;; Query time: 45 msec
  ;; SERVER: 192.168.31.1#53(192.168.31.1)
  ;; WHEN: Thu Mar 05 18:03:23 CST 2020
  ;; MSG SIZE  rcvd: 70


# 查看本机IP、DNS等
ifconfig eth0
  eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 172.18.51.121  netmask 255.255.240.0  broadcast 172.18.63.255
        ether 00:16:3e:14:c1:f6  txqueuelen 1000  (Ethernet)
        RX packets 9441656  bytes 7583854946 (7.0 GiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 7466921  bytes 11947535284 (11.1 GiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```



## tcpdump
类似charles抓包的工具【[参考资料](https://shanyue.tech/op/linux-tcpdump.html)】
```
yum install -y tcpdump

tcpdump tcp port 443 and host 172.18.0.10
tcpdump icmp
```

