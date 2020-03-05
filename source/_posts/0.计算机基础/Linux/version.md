---
title: 系统版本
toc: true
date: 2020-03-05 00:00:01
tags:
---


 版本 | 特点 | 大小
---------|----------|---------
 Alpine | 极小的系统 | 5MB
 CentOS | 免费版，一般服务器用这个 | 200MB
 RedHat | 提供技术服务支持的CentOS |
 Debian | 比CentOS小，但文档不够丰富 | 84MB
 Ubuntu | 带图形界面 | 1.8GB


## 安装包
【[参考资料](https://unix.stackexchange.com/questions/103531/what-are-deb-and-rpm-and-how-are-they-different-from-msi)】
* .deb文件常用于Debian, Ubuntu
* .rpm文件常用于CentOS；yum就是基于rpm的
```sh
rpm -i xxx.rpm
```
