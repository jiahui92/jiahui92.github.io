---
title: hacker
toc: true
hidden: true
date: 2022-12-01 00:00:00
tags:
---

# Kali
基于Linux的操作系统，集成许多hacker tool，一般都是针对`system`、`web`的攻击


# system
* 目的：获取系统or命令执行权限
* 方法
  * 系统漏洞扫描：攻击操作系统一般是使用`msfvenom`生成对应系统的木马，然后使用`metasploit`扫描被攻击者的系统漏洞，最后植入木马；如果没有漏洞，则只能通过社工的方法；
  * 端口扫描：使用`zenmap`扫描端口，查看有哪些软件，进而针对攻击
* 防御：

## tool
* metasploit: 集成所有常见操作系统（win/mac/ios/android）的攻击漏洞，比如win永恒之蓝等；命令必填参数：攻击ip、攻击漏洞、攻击成功后的操作
* msfvenom: 用于生成木马，命令必填参数：攻击者的ip、kali端口
  * 套壳：通常木马会被360火绒等工具检测出来，此时就需要套壳一下，比如压缩等方式影响识别；
* 

# web
* 目的：拖库、给网站植入木马、获取操作系统权限
* 方法：一般使用专门的漏洞扫描工具，本质的都是软件的漏洞，比如心跳攻击/内存安全漏洞；
  * sql注入
  * csrf/xss
* 防御：渗透测试、过滤特殊符号/sql语句；

## tool
* DVWA: 专门针对php的漏洞练习靶场
* sqlmap: sql注入检测工具（自动做类似`1' and 1=1#'`拼接注入），获取数据库username, pwd，也可以根据彩虹库自动爆破密码；

