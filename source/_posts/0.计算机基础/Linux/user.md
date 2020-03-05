---
title: 用户
toc: true
date: 2020-03-05 00:00:05
tags:
---


* 用户管理: useradd, userdel, usermod
* 用户组管理: groupadd, groupdel, groupmod

```sh
useradd -m guangjun2
adduser guangjun3
userdel -f guangjun3

passwd guangjun2 # 修改guangjun的密码
passwd -l guangjun2 # 锁定账户
passwd -u guangjun2 # 解锁账户

etc/passwd # 查看所有用户
etc/group # 查看所有用户组
```
