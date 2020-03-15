---
title: Nginx
toc: true
date: 2020-03-02 00:00:00
tags:
---

[官方文档](http://nginx.org/en/docs/)


## 目录
* `nginx.conf` 入口配置文件
* `nginx/conf.d/*` 会被nginx.conf自动include的插件配置
* `snippets/*` 可复用的代码片段，比如ssl, auth_basic
* `mime.types` http默认处理的文件格式，特殊格式需要在之类配置


## 语法
```nginx
... # 全局

events { ... }

http {

  # access_log, autoindex, index
  # include, header, auth_basic
  # limit_zone, valid_referers

  server {
    location / {
      ...
    }
  }
}


location / {
  # 代理
  root /var/www/html/blog;

  # 反向代理
  proxy_pass http://127.0.0.1:4000;

  # 重定向:302
  rewrite (.*) https://$server_name$1;

  # 重定向:301
  return 301 https://www.guangjun.club$request_uri;
}
```

## 命令
```sh
nginx -t # 检测nginx语法
nginx # 开启
nginx -s reload # 重启
```


## 其它
### 403
nginx没有权限访问该目录
* 修改nginx.conf里user为有权限访问该目录的用户，比如root
* 或者使用chmod修改目录文件的访问权限

### 防渗透测试blocker
服务器经常会被各种灰产渗透测试，可以安装这个插件
https://github.com/mitchellkrogza/nginx-ultimate-bad-bot-blocker

### FastCGI
【[参考资料](https://www.cnblogs.com/tssc/p/10255590.html
)】
* nginx为了支持动态资源，引入CGI协议作为解析层；比如解析php，同时也使用文件缓存来加速；
* FastCGI在CGI基础上动态创建多线程来并行处理多请求；
* php-fpm：php的FastCGI、解析器
![](https://img2018.cnblogs.com/blog/1211667/201901/1211667-20190114112158766-480550737.png)
