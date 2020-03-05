---
title: 环境变量
toc: true
date: 2020-03-05 00:00:04
tags:
---


* 显示所有环境变量: env
	* 查询： env | grep -i proxy
	```sh
	LANG=zh_CN.UTF-8
	USER=root
	LOGNAME=root
	HOME=/root
	PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin
	MAIL=/var/spool/mail/root
	SHELL=/bin/zsh
	...
	```
* 输出: echo $PATH
* 定义新变量: export HELLO="hello"
* 设置: set
* 删除: unset


## 常用环境变量
* HOME
* OLDPWD, PWD
* PATH
* SHELL: 当前用户用的是哪种Shell



## 添加环境变量
【[参考资料](https://www.jianshu.com/p/ac2bc0ad3d74)】
* 对所有用户有效: /etc/profile
* 对当前用户有效: 
	* ~/.bashrc
	* ~/.zshrc
	* ~/.bash_profile
	* 修改完毕后需要执行"source ~/.bashrc"更新配置

```sh
vim ~/.bashrc

'''
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles
'''

# 重开bash 或者 source 使其生效
source ~/.bashrc
```

### bash_profile 于 bash_rc
* .bash_profile只在会话开始时被读取一次，而.bashrc则每次打开新的终端时都会被读取；
* .bashrc还可以设置alias
