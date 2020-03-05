---
title: 系统信息
toc: true
date: 2020-03-05 00:00:03
tags:
---

## htop工具
```sh
yum install -y htop
```
![](/img/Snip20200305_31.png)

## 查看Linux版本信息
```sh
uname -a # 查看内核／Linux版本／CPU
  Linux iZwz9ghknuclpf49gs9Z 3.10.0-1062.9.1.el7.x86_64 1 SMP Fri Dec 6 15:49:49 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux

cat /etc/centos-release # 查看centos版本号
  CentOS Linux release 7.7.1908 (Core)
```


## 查看CPU等
【[参考资料](https://blog.csdn.net/zdwzzu2006/article/details/7747977)】
```sh
cat /proc/cpuinfo
cat /proc/devices # 已经加载的设备
cat /proc/uptime # 系统已经运行了多久
```


## 查看内存
```sh
free -h

              total        used        free      shared  buff/cache   available
Mem:           7.6G        5.3G        321M         22M        2.0G        2.0G
Swap:            0B          0B          0B
```

## 查看硬盘
```
df -h
df -h /var

文件系统        容量  已用  可用 已用% 挂载点
devtmpfs        3.9G     0  3.9G    0% /dev
/dev/vda1        40G   35G  3.2G   92% /
```

## 登录信息
```
last -a | head -3

root     pts/22       Thu Mar  5 15:06   still logged in    113.118.35.52
root     pts/0        Thu Mar  5 14:41   still logged in    113.118.35.52
root     pts/22       Tue Mar  3 14:32 - 16:43  (02:11)     183.13.123.33
```