---
title: docker-compose
toc: true
date: 2020-03-02 00:00:03
tags:
---

docker-compose.yml里写的就是`docker run`的参数；把配置都写在yml中方便阅读，也方便批量启动；

* [安装docker-compose](https://docs.docker.com/compose/install/)
* [例子1 mysql+wordpress](https://docs.docker.com/compose/wordpress/)
* [环境变量](https://zhuanlan.zhihu.com/p/55486428)
  
* [network](https://docs.docker.com/compose/networking/)
  * [nginx-and-multiple-docker-compose
](https://stackoverflow.com/questions/48076605/)


```yml
version: '3.3'

services:
   db:
     image: mysql:5.7
     volumes:
       - db_data:/var/lib/mysql
     restart: always
     environment:
       MYSQL_ROOT_PASSWORD: somewordpress
       MYSQL_DATABASE: wordpress
       MYSQL_USER: wordpress
       MYSQL_PASSWORD: wordpress

   wordpress:
     depends_on:
       - db
     image: wordpress:latest
     ports:
       - "8000:80"
     restart: always
     environment:
       WORDPRESS_DB_HOST: db:3306
       WORDPRESS_DB_USER: wordpress
       WORDPRESS_DB_PASSWORD: wordpress
       WORDPRESS_DB_NAME: wordpress
volumes:
    db_data: {}
```

```sh
docker-compose up -d
docker-compose down
docker-compose down --volumes # 关闭并删除volume的数据
docker-compose build # docker-compose up 默认不会重新build image，导致一直都是用的旧image
```
