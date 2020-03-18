---
title: Docker
toc: true
date: 2020-03-02 00:00:01
tags:
---


## 一些概念
* daemon 守护进程
* 镜像 image
* 容器 container
  * docker run imageName
  * 容器是镜像的实例化，就像win10.iso是镜像，跑起来的虚拟机就是容器
  * docker下的每个容器都是一个单独的系统环境，通过network的方式与宿主机通信
* volume 容器在宿主机的持久化存储空间（删除容器后，数据还在）
* dockerHub 镜像仓库

## 安装
### 安装docker新版本
* https://docs.docker.com/install/linux/docker-ce/centos/
* https://www.cnblogs.com/liyongsan/p/9121578.html


### 修改仓库下载源
```sh
vi /etc/docker/daemon.json
```
```json
{
  "registry-mirrors": ["http://hub-mirror.c.163.com"]
}
```
```sh
# 重启docker
systemctl restart docker
```

### 开机启动
* systemctl start docker
* systemctl enable docker



## 调试
* docker logs containerId
* docker logs mynginx
* docker exec -it mynginx sh
* docker inspect mynginx  --> mounts
* docker container ls -a
* docker ps -a
* [ctop](https://github.com/bcicen/ctop)


## docker安装nginx
【[参考资料](https://www.ruanyifeng.com/blog/2018/02/nginx-docker.html)】
* `docker pull nginx`
* 从镜像里复制文件 `docker cp nginx:/etc/nginx /nginx`
* docker run -d -p 80:80 --name mynginx --volume /nginx/:/etc/nginx/ --volumn /var/www/html/:/var/www/html/ nginx
* docker restart mynginx


### 问题
不建议用docker安装nginx：一般来说，只有那些只要对外暴露端口的服务用docker部署会比较方便，但是像nginx这种是需要访问其它服务的端口的，一旦被装进容器隔绝了网络，那么就需要另外找办法去访问其它容器的端口；

#### 办法一
试一下增加`--network host`来使用宿主机的网络【[参考资料1](https://note.youdao.com/ynoteshare1/index.html?id=0d12819002db9df5127aa43b209f6f06&type=note)】【[参考资料2](https://docs.docker.com/network/network-tutorial-host/)】


#### 办法二
【[参考资料1](https://stackoverflow.com/questions/42720618/docker-nginx-stopped-emerg-11-host-not-found-in-upstream/52319161#52319161)】
【[参考资料2](https://stackoverflow.com/questions/35744650/docker-network-nginx-resolver)】
【[127.0.0.11不会在用户docker network create的网络里生效](https://github.com/moby/moby/issues/22652)】
```nginx
server {
  listen 80;
  server_name test.com;

  location / {
    resolver 127.0.0.11; # docker DNS
    set $backend yourcontainername:5016;
    proxy_pass http://$backend;
  }
}
```
