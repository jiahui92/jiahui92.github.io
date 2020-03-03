---
title: 其它
toc: true
date: 2020-03-02 00:00:99
tags:
---

## 测速
### 网络
```sh
yum install -y speedtest
speedtest-cli
```

### 硬盘
速度对比：（SSD可以当作虚拟内存用？）
* 内存：10GB/s
* SSD硬盘 1GB/s
* 普通硬盘 200MB/s

```sh
yum install -y hdparm
df / -h # 查看硬盘位置
hdparm -Tt /dev/vda1
```


## 其它
* [shell](https://github.com/qinjx/30min_guides/blob/master/shell.md)
* jira
* wiki
* 权限系统
* 审批系统
* 工单系统
