---
title: Git
toc: true
date: 2020-03-02 00:00:02
tags:
---


## git config
三种级别 【[参考资料](https://zhuanlan.zhihu.com/p/62148578
)】
* 项目级别：`git config -e`
* 用户级别：`git config --global -e`
* 系统级别：`git config --system -e`


## git走代理
git config增加配置
```toml
[http "https://github.com"]
  proxy = socks5://127.0.0.1:1086
[https "https://github.com"]
  proxy = socks5://127.0.0.1:1086
```

## commit规范
* feat：新功能（feature）
* fix：修补bug
* docs：文档（documentation）
* refactor：重构（即不是新增功能，也不是修改bug的代码变动）
* test：增加测试


## 命令
```sh
# 丢弃变更
git checkout .
git reset --hard HASH
```

## Gitlab