---
title: Auth_basic
toc: true
date: 2020-03-02 00:00:02
tags:
---

为网站添加一道简单的登录认证【[参考资料](https://blog.csdn.net/bbwangj/article/details/82817874)】


## basic
![](https://img-blog.csdn.net/20180922213917499?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2Jid2FuZ2o=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)
```sh
yum install -y httpd-tools

htpasswd -c /etc/nginx/passwd your_account 

# nginx.conf
server {

  auth_basic "Please input password";
  auth_basic_user_file /etc/nginx/passwd;

  location / {
    ...
  }
}
```

```
Response Header
  status: 401
  www-authenticate: Basic realm="Please input password"

# 之后的所有请求都会带上这个header
Request Header
  authorization: Basic yourpasswordxxxbase64xxstring
```

## digest
basic的缺点就是会传输base64编码过的密码，相当于明文传输了；有https的话就不是太大的问题，除非别人看了你电脑上的抓包信息；如果在意这个问题可以考虑使用auth_digest，这样传输时会使用一个摘要字符串，比如md5+salt.realm处理之后的字符串；【[参考资料](https://www.nginx.com/resources/wiki/modules/auth_digest/)】；

除此之外，相比auth_basic多了一些配置项
```nginx
auth_digest_timeout 60s; # 允许用户输入的时间
auth_digest_expires 1d; # 过期时间 1h, 1w, 1M, 1y
auth_digest_replays 100; # 请求100次资源后失效
```

## nginx-auth-request-module
单点登录？【[参考资料1](http://nginx.org/en/docs/http/ngx_http_auth_request_module.html)】【[参考资料2](https://www.cnblogs.com/vipzhou/p/8420808.html)】
```nginx
location /private/ {
    auth_request /auth;
    ...
}

location = /auth {
    proxy_pass ...
    proxy_pass_request_body off;
    proxy_set_header Content-Length "";
    proxy_set_header X-Original-URI $request_uri;
}
```
