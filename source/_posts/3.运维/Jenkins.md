---
title: Jenkins CI
toc: true
date: 2020-03-02 00:00:03
tags:
---

## 安装jenkins.blueocean
```sh
# 使用宿主机的docker（docker.sock），这样就不会在jenkins的docker里面再嵌套docker
docker run -d --name jenkins-blueocean --env TZ=Asia/Shanghai -p 8081:8080 -v /var/run/docker.sock:/var/run/docker.sock -v jenkins_home:/var/jenkins_home -u 0 jenkinsci/blueocean
```
进去`插件管理 > 高级`替代更新源再安装插件: https://mirrors.tuna.tsinghua.edu.cn/jenkins/updates/update-center.json

## pipeline
[参考资料](https://www.w3cschool.cn/jenkins/jenkins-173a28n4.html)
```sh
pipeline {
  agent any
  stages {
    stage('update submodule') {
      steps {
        sh 'git submodule update --init'
      }
    }

    stage('build') {
      steps {
        sh 'docker build . -t blog'
      }
    }

    stage('run') {
      steps {
        sh '''
# when the container not exist, "|| true" can avoid the error 
docker rm -f blog || true 
docker run -d --name blog -p 4000:4000 -v ~/logs:/root/logs --restart always --rm blog
sleep 1
docker logs blog
sleep 5
'''
      }
    }

  }
}
```

## 竞品
* GItlab CI
* Travis CI for Github
* [Drone](https://github.com/drone/drone)

