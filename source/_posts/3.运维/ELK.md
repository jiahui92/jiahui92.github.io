---
title: ELK 日志收集分析
toc: true
date: 2020-03-02 00:00:05
tags:
---

## ELK
[参考资料](https://www.zhihu.com/question/21427267)
* Filebeat 将日志录入Logstash
* Logstash 日志收集、过滤
* Elasticsearch 日志搜索（也可收集）
* Kibana 可视化日志分析 

![](https://images2018.cnblogs.com/blog/874963/201808/874963-20180815142101389-1765706122.png)





## ELK线上服务
* 部分云服务商会提供ELK，比如Amazon和阿里云
* https://www.elastic.co/cn


## 安装ELK7
* require: docker17.5+, 1.5GB RAM 【[参考资料](https://github.com/deviantony/docker-elk)】
```sh
git clone https://github.com/deviantony/docker-elk.git

cd docker-elk

docker-compose up -d
```
* 访问 http://localhost:9200
* 账号密码 elastic changeme
* 访问 http://localhost:5601
* 修改密码: Management > User > elastic

## Filebeat
> `filebeat -e`启动后，可以留意console里输出的`Harvester started for file: xxx`相关信息，里面包含了filebeat正在监听的日志文件，确保没有遗漏；如果是通过`systemctl`启动，可以通过`systemctl status filebeat -l`来查看查看日志
* [filebeat + elasticsearch](https://www.heroyf.club/2018/08/15/elk/)
* [filebeat + logstash](https://www.bmc.com/blogs/elasticsearch-logs-beats-logstash/)
* [filebeat.module](https://www.cnblogs.com/minseo/p/10607540.html): filebeat有很多现成module，包括nginx、docker之类的，`filebeat modules enable nginx` 就可以获取nginx的日志了
* [beat的各种类型](https://www.elastic.co/downloads/beats): filebeat, metricbeat ...


## Zipkin 日志链路追踪
![](/img/Snip20200303_1.png)
zipkin是一个可视化查询全链路日志的系统，并且可以知道每个链路上的耗时； 【[参考资料](https://github.com/openzipkin/zipkin)】
* 在所有后端接口调用添加"X-Request-Id"请求头
* 在一个有依赖链路的后端接口报错时，通过reuqestId快速找出对应报错时的一条调用链路



## 其它
* [Kibana可视化日志分析入门教程](https://www.cnblogs.com/cjsblog/p/9476813.html)
