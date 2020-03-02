---
title: Auth_basic
toc: true
date: 2020-03-02 00:00:02
tags:
---

为网站添加一道简单的登录认证【[参考资料](https://blog.csdn.net/bbwangj/article/details/82817874)】

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
