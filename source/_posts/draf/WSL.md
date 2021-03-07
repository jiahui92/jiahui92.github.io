---
title: WSL
toc: true
hidden: true
date: 2020-04-07 00:00:06
tags:
---

## 安装
xxx

## 问题
### 连接不上
* [永久解决：使用NoLsp.exe设置](https://github.com/microsoft/WSL/issues/4177)
* 临时解决
```sh
netsh winsock reset
```

### 宿主机卡死
通过`C:\Users\xxxx\.wslconfig`合力分配资源，避免和宿主机发生资源冲突，通常设置为90%的内存和CPU资源；
```sh
[wsl2]
# kernel=<path>              # An absolute Windows path to a custom Linux kernel.
memory=10GB              # How much memory to assign to the WSL2 VM.
processors=14       # How many processors to assign to the WSL2 VM.
swap=8GB                # How much swap space to add to the WSL2 VM. 0 for no swap file.
# swapFile=<path>            # An absolute Windows path to the swap vhd.
# localhostForwarding=<bool> # Boolean specifying if ports bound to wildcard or localhost in the WSL2 VM should be connectable from the host via localhost:port (default true).

# <path> entries must be absolute Windows paths with escaped backslashes, for example C:\\Users\\Ben\\kernel
# <size> entries must be size followed by unit, for example 8GB or 512MB
```

### ip不固定
xxx
