---
title: Traefik
toc: true
date: 2020-03-02 00:00:02
tags:
---

![](https://traefik.cn/frontend/images/web.frontend.png)
![](https://traefik.cn/frontend/images/traefik-health.png)

Traefik: Nginx可视化的一个可选方案
* 自动续https证书
* 可结合docker.label省掉nginx.conf

![](https://traefik.cn/frontend_doc/images/architecture.png)


## 安装
8080 是UI管理界面，80是一个whoami服务【[参考资料](https://www.jianshu.com/p/0fc6df85d00d)】
```yml
version: '3'
services:
  traefik:
    image: traefik:2.0
    # 启用webUI并让Traefik去监听docker的容器实例
    command: --api.insecure=true --providers.docker
    ports:
      # traefik暴露的http端口
      - "80:80"
      # webUI必须设置--api.insecure=true才可以访问
      - "8080:8080"
    volumes:
      # 将docker暴露给traefik
      - /var/run/docker.sock:/var/run/docker.sock
```
