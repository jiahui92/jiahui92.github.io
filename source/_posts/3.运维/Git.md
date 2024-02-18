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
* 如果clash开启了`TUN Mode`，并且使用git ssh来验证权限，则需新增`clash rules`不代理22端口的请求(`- DST-PORT,22,DIRECT`)，否则可能会报以下错误
```sh
kex_exchange_identification: Connection closed by remote host
Connection closed by 198.18.0.251 port 22
fatal: Could not read from remote repository.
```

* 如果使用小飞机等工具的系统代理，则需手动给git config增加配置
```toml
[http "https://github.com"]
  proxy = socks5://127.0.0.1:7890
[https "https://github.com"]
  proxy = socks5://127.0.0.1:7890
```

## commit规范
* feat：新功能（feature）
* fix：修补bug
* docs：文档（documentation）
* refactor：重构（即不是新增功能，也不是修改bug的代码变动）
* test：增加测试


## 命令

### rebase
```sh
# 简单的一句话执行完
git pull --rebase origin master --autostash
# 冲突解决完毕后
git rebase --continue
```
```sh
# 暂存dev的代码
git stash

# 更新master代码
git checkout master
git pull

git checkout dev
git rebase master

git push
```

### merge
```sh
git fetch
git merge xxx
```


### 切远程分支
```sh
git branch -a # 查看所有分支
git checkout -b newDev origin/newDev
```


### 回滚
```sh
# 丢弃变更
git checkout .
git reset --hard 86312f5 # 回退到某个commit，之后的commit将会丢失
git reset --soft 86312f5 # 回退到某个commit并将回退的代码放在暂存区

git revert 86312f5 # 回退到某个commit，相比reset会产生一个新的commit
```

### stash
```sh
git stash push -u -m "some msg"
git stash pop


git stash list
git stash apply 1
git stash pop 1
git stash drop 1

git show stash@{0}
```

#### 恢复误删的commit
```sh
# 查看已删除的commit（包括git stash drop, git reset --hard）
# git fsck --unreachable | grep commit
# git fsck --lost-found | grep commit
git reflog
# 查看commit1, commit2, commit3的详细内容
git show -q commit1 commit2 commit3
# 恢复commit
git merge commit1
```

### 其他
```sh
# 删除分支
git branch -D xxx

# 设置git config
git config --local -e  # 对应文件~/myproject/.git/config
git config --global -e  # 对应文件~/.gitconfig
```

```sh
git work add  ../new-branch-projecy
git worktree remove ../new-branch-projecy

```

## Gitlab
