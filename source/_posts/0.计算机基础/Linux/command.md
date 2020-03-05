---
title: 常用命令
toc: true
date: 2020-03-05 00:00:10
tags:
---


## vim
【[参考资料](https://www.cnblogs.com/jikey/archive/2011/12/28/2304341.html)】
* dd 删除一行
* v
  * y 复制
  * p 粘贴
* 0 跳到第一行
* $ 跳到最后一行
* ctrl+b 下一页
* ctrl+f 上一页
* /keyword 搜索
  * n 下一个
  * N 上一个
* :%s/keyword/replaceWord/g 替换
  * / 下一个
  * ? 上一个


## yum
* yum install -y epel-release
* yum install nginx
* yum erase nginx
* yum list installed
* yum list search nginx

其它下载相关命令
* apt, apt-get, brew, npm, mvn, pip
* wget, tar, rpm -i


## tmux
【[参考资料](https://www.cnblogs.com/kaiye/p/6275207.html)】
```sh
yum install -y tmux
touch ~/.tmux.conf
vim ~/.tmux.conf
```
```sh
# 开启鼠标模式
set -g mode-mouse on
​
# 允许鼠标选择窗格
set -g mouse-select-pane on
​
# 如果喜欢给窗口自定义命名，那么需要关闭窗口的自动命名
set-option -g allow-rename off
​
# 如果对 vim 比较熟悉，可以将 copy mode 的快捷键换成 vi 模式
set-window-option -g mode-keys vi
```

所有快捷键都要先按`conrol+b`再使用
* % 左右平分两个窗格
* '' 上下平分两个窗格
* x 关闭当前窗格
* 方向键 切换窗格
* z 最小化／最大化窗格
* ? 快捷键说明
* 翻页 fn+方向键



## ssh
```sh
ssh root@yourdomain.com

# 免密登录（github ssh key也是一个道理）
# 生成~/.ssh/id_rsa.pub和id_rsa
ssh-keygen -t rsa 'xxxx'

# 将本地用ssh-keygen生成的的`~/.ssh/id_rsa.pub`复制或追加到服务器的`~/.ssh/authorized_keys`
scp -r ~/.ssh/id_rsa.pub root@yourdomain.com:~/.ssh/authorized_keys
```

### 原理
ssh登录服务器的安全保证流程和https差不多，都是非对称加密的过程；唯一不同的是，浏览器会对服务器证书进行验证，防止中间人攻击（像charles一样替换服务器证书）；ssh首次登录时则需要自己验证`RSA key fingerprint`（由RSA公钥生成的摘要/签名），确保是这是服务器的证书；【[参考资料](https://www.jianshu.com/p/33461b619d53)】
```sh
# 第一次尝试登录服务器时，需要自己根据fingerprint确认这是否为服务器的证书，防止中间证书攻击
The authenticity of host 'yourdomain.com (39.109.113.78)' can't be established.
RSA key fingerprint is 98:2e:d7:e0:de:9f:ac:67:28:c2:42:2d:37:16:58:4d.
Are you sure you want to continue connecting (yes/no)? 
```


```sh
# 未在known_hosts中找到该服务器的公钥记录，是否继续连接并记录下来？
# 感觉这步可以和上面那步连起来？验证过证书直接记录就可以了吧？
Host key not found from the list of known hosts.
Are you sure you want to continue connecting (yes/no)?

# 接着会在~/.ssh/known_hosts中记录服务器的公钥/etc/ssh/*.pub
yourdomain.com ecdsa-sha2-nistp256 AAAAE2VjAAAAE2VjAAAAE2Vj...==
```






## shutdown
关机正确流程
1. who: 查看谁在线
2. sync: 将内存数据同步到文件
3. shutdown || reboot
```sh
shutdown now # 立即关机
shutdown 13:00 # 13点关机
shutdown +30 # 30min后关机
shutdown -r +30 '升级系统，30分钟后重启' # 附加通知信息
shutdown -c '取消关机'  # 取消关机
```
