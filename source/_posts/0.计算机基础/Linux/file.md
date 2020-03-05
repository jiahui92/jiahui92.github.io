---
title: 文件目录
toc: true
date: 2020-03-05 00:00:06
tags:
---

## 一切皆文件
硬件之类的被抽象成file，放在/dev目录下，可以直接读取"cat /dev/networks"，且与file通用读、写、权限之类的概念；【[参考资料1](https://www.zhihu.com/question/25696682)】【[参考资料2](https://virtual.51cto.com/art/201906/597916.htm)】

![](/img/Snip20200305_33.png)


## 目录
![](https://www.runoob.com/wp-content/uploads/2014/06/003vPl7Rty6E8kZRlAEdc690.jpg)

【[参考资料](https://www.runoob.com/linux/linux-system-contents.html)】

* /
  * boot 系统内核
  * dev 设备
    * vda1 硬盘
    * null 丢弃一切写入的空设备，可输出null流
    * zero 输出"NULL, 0x00 ..."流
    * [tcp|udp]/host/port
    * networks
  * var 程序安装目录
    * jenkins_home/
  * etc 配置文件
    * nginx/
    * centos-release
  * root 即 "~" 目录
  * bin
  * lib: bin相关的软件目录或其它依赖库
  * usr 用户相关
    * bin

### dev目录
```sh
# console没有任何输出
cat 1.txt > /dev/null

# 创建一个2GB的swap文件
touch /root/swapfile
dd if=/dev/zero of=/root/swapfile bs=1M count=2048

# tcp设备必须要在bash中使用，shell和zsh都不存在；可用于发起tcp请求
bash
echo < /dev/tcp/127.0.0.1/33

cat /etc/networks
  default 0.0.0.0
  loopback 127.0.0.0
  link-local 169.254.0.0
```

### bin目录 - 全局命令
* /bin: 供所有用户使用
* /sbin: 供root使用
* usr/local/bin: 自行安装的软件
* /home/guangjun/bin: 只有guangjun用户才能使用
* node_module/.bin: npm run 优先使用
* alias
```sh
# ~/.bashrc | ~/.bash_profile | /etc/profile
vim ~/.bashrc

'''
alias proxy='export socks5_proxy=socks5://127.0.0.1:1086;export http_proxy=http://127.0.0.1:1087;export https_proxy=http://127.0.0.1:1087;'
alias unproxy='unset socks5_proxy http_proxy https_proxy'
'''

# 重开bash 或者 source 使其生效
source ~/.bashrc
```

### config文件
和全局命令的bin目录一样，各种程序的config文件也区分`系统级`、`用户级`、`项目级`

#### bash
* ~/.bash_rc
* ~/.bash_profile
* /etc/profile

#### git
* myproject/.git/config
* ~/.gitconfig
* /etc/gitconfig

#### npm
npmrc
* myproject/.npmrc
* ~/.npmrc
* /etc/npm/npmrc

node_modules
* myproject/node_modules
* /usr/lib/node_modules


## 文件操作

### 常用命令

```sh
pwd
cd -  # 回到上一个目录

mv
cp
ln -s myfile.txt mylink

touch new.txt
mkdir -p /var/www/html/myproject

cat 1.txt | grep haha
tail -f web.log
find ~ -iname '*.jpg'

# sed批量更改文件
# https://shanyue.tech/op/linux-sed.html
# 打印文件第三行到第五行
# -n: 选项，代表打印
# 3-5: 匹配，代表第三行到第五行
# p: 操作，代表打印
$ sed -n '3,5p' file

# 删除文件第二行
# -i: 选项，代表直接替换文件
# 2: 匹配，代表第二行
# d: 操作，代表删除
$ sed -i '2d' file
```

### I/O重定向
```sh
# ">"为"1>"的简写，下面这行命令表示将find的正常结果输出到list文件，错误结果重定向到1去，也就是都输出到list文件（其实可以简写为"&>"）；>> 是追加的意思；
find /home -name .bashrc > list.txt 2>&1
find /home -name .bashrc &> list.txt

# 有时候不想看到输出结果，可以将内容重定向到null设备
rm -rf xxx &> /dev/null

# 将1.txt的输出值和前面的cat拼接成一条命令执行
cat < 1.txt
cat < 'a.sh' # 相当于 cat a.sh
```



### 管道指令
【[参考资料](https://github.com/CyC2018/CS-Notes/blob/master/notes/Linux.md#%E5%85%AB%E7%AE%A1%E9%81%93%E6%8C%87%E4%BB%A4)】
```sh
last

  root     pts/22       116.115.5.5    Thu Mar  5 19:35   still logged in
  root     pts/0        116.115.5.5    Thu Mar  5 18:04   still logged in
  reboot   pts/0        116.115.5.5    Thu Mar  5 17:46 - 17:50  (00:03)
  ...

# 按照' '裁剪并取数组第一个值，进行排序，去重，输出到console和a.txt
last | cut -d ' ' -f 1 | sort | uniq | tee a.txt

  reboot
  root
  wtmp


# 输出1.txt中包含'enabled'的行
cat 1.txt | grep 'enabled'

```

### 权限管理
![](/img/Snip20200305_34.png)
```sh
ls -lh

总用量 8.0K
drwxr-xr-x 16 root root 4.0K 2月  26 22:29 playground
drwxr-xr-x 11 root root 4.0K 2月  27 14:13 server
```
* 链接数（新目录自带 .和.. 两个软链接）
* 所有者的用户名
* 该用户所属组
* 文件大小
* 修改时间

新创建的文件默认权限为`-rw-rw-r--`，不可执行【[参考资料](https://blog.csdn.net/zyqblog/article/details/79226826)】
```sh
chown -R guangjun . # 修改所有者
chgrp -R staff . # 修改所属组
chmod -777 .  # 777表示rwxrwxrwx
chmod +x a.sh # 增加可执行权限
```

## 拓展：目录本质也是文件
```sh
vim ~/code/myprocjet

"============================================================================
" Netrw Directory Listing                                        (netrw v149)
"   /root/code/myprocjet
"   Sorted by      name
"   Sort sequence: [\/]$,\<core\%(\.\d\+\)\=\>,\.h$,\.c$,\.cpp$,\~\=\*$,*,\.o$,\.obj$,\.info$,\.swp$,\.bak$,\~$
"   Quick Help: <F1>:help  -:go up dir  D:delete  R:rename  s:sort-by  x:exec
" ============================================================================
../
./
.git/
app/
.gitignore
.yarnrc
Jenkinsfile
README.md
```
目录的文件相关信息都存在`block`中，可以看到`block`里记录了包含的文件以及".."和"."这两个特殊文件；当尝试去`vim myproject/..`时，会看到输出的信息为上一级目录的`block`；其本质为软链接（window的快捷方式）；


### 关于目录的权限
* 因为文件名是记录在目录的`block`中的，所以必须要拥有该目录的`write`权限，才能修改其子文件名；
* 同样的，需要有改目录的`x`执行权限，才能读取读取文件列表；

> 目录除了拥有`block`外，也会拥有一个`inode`用于记录权限等信息；详细见下面的`inode`；


## 拓展: 记录文件的inode和block
### inode
每个文件都对应有一个或多个inode，用于记录文件属性和block编号；具体包含以下信息【[参考资料](https://github.com/CyC2018/CS-Notes/blob/master/notes/Linux.md#%E5%9B%9B%E6%96%87%E4%BB%B6%E7%B3%BB%E7%BB%9F)】
* 权限 (read/write/excute)；
* 拥有者与群组 (owner/group)；
* 容量；
* 建立或状态改变的时间 (ctime)；
* 最近读取时间 (atime)；
* 最近修改时间 (mtime)；
* 定义文件特性的旗标 (flag)，如 SetUID...；
* 该文件真正内容的指向 (pointer)；

### block
block则简单得多，用于存储文件的内容

### superblock
记录文件系统的整体信息，包括 inode 和 block 的总量、使用量、剩余量，以及文件系统的格式与相关信息等；

### block bitmap
用于记录该block是否被使用过的位图

![](/img/Snip20200305_36.png)

### 磁盘碎片
指一个文件内容所在的 block 过于分散，导致磁盘磁头移动距离过大，从而降低磁盘读写性能。碎片整理会将相关block尽量挨在一起，提高读写性能；





