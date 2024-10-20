---
title: 一些概念
toc: true
date: 2020-03-02 00:00:03
tags:
---


## 日志、链路追踪
log4j, ELK, Zipkin



## 微服务
将后端服务拆分得更专业、细化，以往的用户或登录相关数据可能会分布在各个后端，现在都集中在一个微服务中，谁需要谁调用；但是可能会有性能瓶颈，之前的某些数据可以在本地调用，现在得走网络调用了；于是补了一个方案，将数据实时性要求不高的网络调用缓存在本地中；


## 集群
这些感觉k8s会内置处理了
* 负载均衡
* 守护进程、领导选举
* 数据同步*: 共享内存? List-Watch?


## 消息队列
* 基于订阅发布模式的消息队列，发布者可以直接把消息丢给专门处理消息队列的服务器就可以直接返回了；以往一对一的调用，发布者需要确保订阅者都收到信息了，这个过程会产生“等待”；当流量突然加大时，这种“等待”行为可能会压垮服务器；在没有消息队列服务器的情况下，以往只能够给各种业务一起加机器，现在只要给消息队列加机器就行了；而且发布者也不需要自己去管理有哪些订阅者；【[参考资料1](https://github.com/CyC2018/CS-Notes/blob/master/notes/%E6%B6%88%E6%81%AF%E9%98%9F%E5%88%97.md)】【[参考资料2](https://blog.csdn.net/qq_35860138/article/details/81872911)】
* 可以把秒杀系统的并行减库存操作改为串行执行，达到解耦

![](https://img-blog.csdn.net/20180820161018981?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzM1ODYwMTM4/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)


## 容灾&缓存
【[参考资料](https://zhuanlan.zhihu.com/p/89763978)】
* CDN
  * Nginx缓存
    * redis缓存
      * 后端服务

![](https://pic3.zhimg.com/80/v2-107bac5b6ee48b98de7b9ac8b380933a_720w.jpg)


## Elasticsearch
当SQL遇到大文本匹配、复杂搜索（比如商品搜索） 瓶颈时，可以考虑把数据同步到elasticsearch，并使用他的搜索，能实现同义词等复杂搜索，并且速度很快（相比数据库，大文本匹配使用倒排索引优化过，类似数据预处理了，简单需求也可使用mysql.fulltext）


