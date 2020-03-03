---
title: Consul K/V配置
toc: true
date: 2020-03-02 00:00:06
tags:
---

Consul可用于
* 配置key/value服务
  * 灰度开关
  * 运营配置（但交互不友好，也缺少很多功能，比如根据用户、设备、时间投放之类的）
* 健康检查
* 服务发现/分布式部署



## 安装
```sh
# -ui表示开启WebUI
docker run -d -p 8500:8500 -v consul:/consul/data --name=consul -e CONSUL_BIND_INTERFACE=eth0 consul agent -server -ui -bind 0.0.0.0 -client 0.0.0.0 -bootstrap -bootstrap-expect 1
```

* consul的登录认证使用的是ACL，但是不太好用，可以使用[nginx.auth_basic](../Nginx/Auth_basic)简单得加一道登录认证；
* consul的kv API也不太好用，加一段nginx让接口访问更友好一些，详细见下；这样就从原来的`https://consul.xxx.com/v1/kv/test1?raw`，变成了`https://data.xxx.com/test1`
```nginx
server {
  include snippets/ssl.conf;
  server_name data.xxx.com;

  location ~ /(.*) {
    proxy_method 'GET'; # 强制设置Request Header
    proxy_hide_header Content-Type; # 删除Response Header
    add_header Content-Type 'application/json; charset=utf-8';
    add_header Access-Control-Allow-Origin '*';
    proxy_pass http://127.0.0.1:8500/v1/kv/$1?raw;
  }
}
```

## 其它
* [kv API 支持参数 (增删改查)](https://www.consul.io/api/kv.html)
* [ACL 登录&权限管理](https://muka.app/?p=336)
* [使用手册](https://blog.csdn.net/liuzhuchen/article/details/81913562)
