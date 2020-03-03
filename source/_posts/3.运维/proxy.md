---
title: proxy
toc: true
date: 2020-03-02 00:01:00
tags:
---

<script>
	document.getElementById('main').innerHTML = '不可见';
</script>


## 梯子
* [googlehosts](https://github.com/googlehosts/hosts)
* [Chrome插件:快速安全通道](https://chrome.google.com/webstore/detail/faststunnel-vpn/bblcccknbdbplgmdjnnikffefhdlobhp)
* [Lantern (p2p)](https://github.com/getlantern/download)
* [付费机场](http://387099.blogspot.com/2018/03/ssssr.html)



## VPS
### 免费vps可褥
* google cloud
* amazon cloud
* [virmach 优惠码](https://blog.csdn.net/qq_42237101/article/details/80364032#comments)

### v2ray
【[参考资料](https://github.com/233boy/v2ray/wiki/V2Ray%E6%90%AD%E5%BB%BA%E8%AF%A6%E7%BB%86%E5%9B%BE%E6%96%87%E6%95%99%E7%A8%8B)】
```sh
## debian9
apt-get update -y && apt-get install curl -y
bash <(curl -s -L https://git.io/v2ray.sh)

## mac安装 https://www.latoooo.com/ke_xue_shang_wang/363.htm
brew cast install v2rayx
```

### Shadowsocks 一键脚本+BBR
【[参考资料1](https://my.oschina.net/bluefrankey/blog/2994825)】
【[参考资料2](https://github.com/teddysun/shadowsocks_install/tree/master)】
```sh
## cenos 7
curl https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-all.sh > shadowsocks-all.sh

#修改里面的libsodium
libsodium_file="libsodium-1.0.18"
libsodium_url="https://github.com/jedisct1/libsodium/releases/download/1.0.18-RELEASE/libsodium-1.0.18.tar.gz"


chmod +x shadowsocks-all.sh

./shadowsocks-all.sh 2>&1 | tee shadowsocks-all.log



## bbr 装上之后可能无法代理。。
wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh

chmod +x bbr.sh

./bbr.sh

reboot # 重启生效

lsmod | grep bbr


#装上bbr之后无法代理，则取消 https://www.moerats.com/archives/101/
vim /etc/sysctl.conf
sysctl -p
reboot


## ss相关命令
/bin/python /usr/bin/ssserver -c /etc/shadowsocks-python/config.json -d start
```


### 测速
* 香港 50ms    带宽最小
* 日本 80ms     
* 美国 200ms  6Mbps
```sh
yum install -y speedtest
speedtest-cli
```


### 调试
【[参考资料](https://tlanyan.me/recovery-blocked-ip/amp/)】
* 流量用尽、没有续费
* ip被封: 无法ping通
* 端口被封: 换一个端口
* 域名被封


### 优化
【[参考资料](https://tlanyan.me/recovery-blocked-ip/amp/)】
* [国内服务器代理转发](https://www.hijk.pw/forward-traffic-via-internal-vps/)
* iptables
* 建站
	* 免费域名
		* https://www.freenom.com/
		* https://sspai.com/post/40615
* cdn转发






## 软件走代理
* [服务端linux: 安装ssr客户端](https://www.flyzy2005.com/fan-qiang/shadowsocks/install-shadowsocks-in-one-command/)
* [Git](../_posts/3.运维/Git.md)

### 终端代理
```sh
vim ~/.bash_profile

# 输入
alias proxy='export socks5_proxy=socks5://127.0.0.1:1086;export http_proxy=http://127.0.0.1:1087;export https_proxy=http://127.0.0.1:1087;'
alias unproxy='unset socks5_proxy http_proxy https_proxy'


# 关闭终端重新打开
proxy
# 测试是否连上代理
curl cip.cc
```







## GFW
【[参考资料]()】
* 访问的ip是无法加密的，能通过ip大致推导访问过什么网站
* 全局代理访问国内网站容易被封
