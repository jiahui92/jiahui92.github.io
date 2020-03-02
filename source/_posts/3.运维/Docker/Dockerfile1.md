---
title: Dockerfile
toc: true
date: 2020-03-02 00:00:02
tags:
---

Dockerfile里定义了
* 怎么build一个image
* 如何使用image

![](https://images2017.cnblogs.com/blog/911490/201712/911490-20171208222222062-849020400.png)

```Dockerfile
FROM node:8.4
COPY . /app # 将当前目录的所有文件都复制进容器的/app目录
WORKDIR /app
RUN npm install
EXPOSE 3000 # 通过3000端口对外服务
```

```sh
docker image build -t test:0.0.1 .
docker container run -p 7001:7001 -it test bash
```

## 问题
Dockerfile有些配置是用来说明的，除非显式指定，否则并不会在`docker run`时生效，比如`VOLUME`和`EXPOSE`；但是有些又会生效，比如`ENV`；具体是否能够默认生效，需要查看【[官方文档](https://docs.docker.com/engine/reference/builder/#expose)】



## 优化
* `使用alpine包` image build出来太大了，一个eggjs应用竟然1.3GB
* `按层优化` 打包太慢每次都需要重新npm i 【[参考资料](https://juejin.im/post/5a9626abf265da4e9d225f4f)】


```Dockerfile
# https://hanhan.pro/2018/06/06/deploy-eggjs-app-with-docker/
# eggjs 一定要将package.json里的scrpits.start的daemon删掉

FROM node:13.4.0-alpine

RUN node -v
RUN npm -v

# 设置时区
ENV TZ=Asia/Shanghai

# 创建app目录
RUN mkdir -p /app
# WORKDIR是在container里创建的工作目录
WORKDIR /app

# 复制当前目录到container的app目录
# 拷贝package.json文件到工作目录
# !!重要：package.json需要单独添加。
# Docker在构建镜像的时候，是一层一层构建的，仅当这一层有变化时，重新构建对应的层。
# 如果package.json和源代码一起添加到镜像，则每次修改源码都需要重新安装npm模块，这样木有必要。
# 所以，正确的顺序是: 添加package.json；安装npm模块；添加源代码。
COPY package*.json /app/
RUN npm i --registry=https://registry.npm.taobao.org  --production
# 拷贝所有源代码到工作目录，不需要拷贝的文件可以在.dockerignore文件忽略
COPY . /app

EXPOSE 7001
VOLUME [ "/root/logs" ]

# RUN npm run test
CMD npm run start

# docker run -d --name api -p 7001:7001 -v ~/logs:/root/logs --restart always api

```