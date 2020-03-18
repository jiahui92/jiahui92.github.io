---
title: upstream 负载均衡
toc: true
date: 2020-03-02 00:00:05
tags:
---

[参考资料](https://blog.csdn.net/xyang81/article/details/51702900)
[官方文档](https://nginx.org/en/docs/http/ngx_http_upstream_module.html#upstream)
```nginx
upstream backend {
  server 192.168.0.100:8080 weight=2 max_fails=3 fail_timeout=15;;  # 2/6次，失败超过3次则换机器，并且15s内不会再访问此机器
  server 192.168.0.101:8080 weight=3;  # 3/6次
  server 192.168.0.102:8080 weight=1;  # 1/6次

  server 192.168.0.103:8080 backup; # 所有机器挂了之后，才会访问backup服务器
}

...
location /http/ {
  proxy_pass http://backend;
}
```
weight默认为1
max_fails默认为1
fail_timeout默认为10s
down 关闭某机器
max_conns 限制最大连接数量


## fair
第三方模块，自动选择压力最小/响应最快的机器
```nginx
upstream backend {
  fair;
  server 192.168.0.100:8080;
  server 192.168.0.101:8080;
  server 192.168.0.102:8080;
}
```
