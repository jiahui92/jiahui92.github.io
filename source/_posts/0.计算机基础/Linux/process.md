---
title: 进程管理
toc: true
date: 2020-03-05 00:00:07
tags:
---

## 进程管理
```sh
# 查看nginx进程信息
ps aux | grep nginx
# 或者通过htop来可视化管理进程，支持列成树状关系、排序、过滤、Kill、搜索
yum install -y htop


# 查询占用80端口的进程id
lsof -i:80
# 或
netstat -anp | grep 80

# 通过id杀掉进程
kill -9 8456
# 如果杀掉后又自动重启了，则可能存在守护进程
systemctl stop nginx
```

### systemctl
守护进程&启动管理【[参考资料](https://blog.csdn.net/skh2015java/article/details/94012643)】
```sh
# 开启服务
systemctl start docker

# 开机启动
systemctl enable docker

# 查看开机启动信息
systemctl list-units --type=service

# 查看进程的状态和日志
systemctl status docker -l

# 查看进程的完整日志
journalctl -u docker.service
```


## 拓展：进程、线程、协程
* 一个软件可以创建多个进程
* 创建进程时会申请一块独立的内存空间和一个线程
* 进程可以申请多个线程来辅助工作
* 线程是CPU纬度的
* 如何调度进程和线程，完全由操作系统决定，程序自己不能决定什么时候执行，执行多长时间
* 进程间是相互隔离的，拥有独立的内存空间，相比多线程更安全，只能通过`IPC`进行数据通信
* 线程间的内存空间是共享的（使用的同一进程的内存），所以可以通过全局变量来进行通信。但同时操作一个变量有可能带来一些问题，所以引入了各种锁（互斥锁：防止多个线程同时读写某一块内存区域）

### 协程
* 协程是属于线程的。协程程序是在线程里面跑的，因此协程又称微线程和纤程等
* 比如Promise， yield


### IPC
进程间通信 Inter-Process Communication 【[参考资料](https://blog.csdn.net/dxdxsmy/article/details/6653189)】
* 信号: 异步通信机制；订阅发布机制；
* 管道
  * [匿名管道](https://www.cnblogs.com/chengmo/archive/2010/10/21/1856577.html): `cat 1.txt | grep 'xxx'`
  * [命名管道FIFO](https://blog.csdn.net/ljianhui/article/details/10202699): 本质通过创建一个文件来交换信息
* System V
  * 信号量
  * 共享内存
  * 消息队列
* Socket


### 死锁
当两个以上的运算单元，双方都在等待对方停止运行，以获取系统资源，但是没有一方提前退出时，就称为死锁。



### SIGKILL
当父进程收到子进程的`SIGCHLD/SIGKILL`信号时，正常情况下下会调用wait()来收集子进程信息，然后子进程就会开始终结；但是父进程因为某些原因没有调用wait()的话，那么该子进程就会卡在那里，变成`僵尸进程`，一直退不出；直到父进程被终结，此子进程再变为`孤儿进程`时，才会被`init进程`回收；

#### 例子
ssh退出后，ssh下的所有子进程会被关闭【[参考资料1](https://github.com/CyC2018/CS-Notes/blob/master/notes/Linux.md#sigchld)】【[参考资料2](https://blog.51cto.com/zjking/1117828)】
* ssh父进程退出后，其运行的wget下载子进程会成为`孤儿进程 `，并被init进程收养和终止
* `systemd和nohup的进程`不是归属于`sshd进程组`，所以不会随着ssh进程的终结而终结
```sh
# 使用nohup进程执行任务，以免退出登录任务被回收
nohup ./install.sh &> ~/output.log &
# 查询任务
jobs -l
```


### 多任务的实现方式
* 多进程模式
* 多线程模式
* 多进程+多线程模式


## 拓展：系统启动
![](/img/Snip20200305_30.png)

【[参考资料](https://www.runoob.com/linux/linux-system-boot.html)】

### init进程
Linux在不同场合开机时，分配不同运行级别的开机程序
> * 运行级别0：系统停机状态，系统默认运行级别不能设为0，否则不能正常启动
> * 运行级别1：单用户工作状态，root权限，用于系统维护，禁止远程登陆
> * 运行级别2：多用户状态(没有NFS)
> * 运行级别3：完全的多用户状态(有NFS)，登陆后进入控制台命令行模式
> * 运行级别4：系统未使用，保留
> * 运行级别5：登陆后进入图形GUI模式
> * 运行级别6：系统正常关闭并重启，默认运行级别不能设为6，否则不能正常启动

### init.d
启动systemctl设置过的自启程序
