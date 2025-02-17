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


### GFW
【[参考资料]()】
* 访问的ip是无法加密的，能通过ip大致推导访问过什么网站
* 全局代理访问国内网站容易被封





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

#### proxifier
win10下没有`proxychains`，但可以用`proxifier`软件，可以代理任何程序

#### proxychains
* [安装](https://www.harker.cn/archives/proxychains.html)
* [在mac下无效的解决办法](https://zhuanlan.zhihu.com/p/21281236)： 关闭SIP（System Intergrity Protection）系统完整性保护
```sh
brew install proxychains-ng
# apt install proxychains4


vim /etc/proxychains4.conf
	# 最后面增加这行，并删除socks4
	socks5 127.0.0.1 1080


## 只要在需要代理的命令前加上proxychain4即可
proxychains4 curl cip.cc # 此时会输出config文件的路径，通过vim来添加代理端口
```

##### wsl&容器中查找代理主机的ip
```sh
cat /etc/resolv.conf
# nameserver xx.xx.xx.xx
```

## shadowsock
### PAC rule
修改pac.txt文件里的rules数组变量，实时生效
```
||.proxy.com^
@@unproxy.com^
```

## clash
### 开多个代理后超过tcp最大数量
https://blog.csdn.net/xinfeixiang2019/article/details/103474065
```sh
netsh int ipv4 show dynamicport tcp

netsh interface ipv4 show tcpstats
netsh int ipv4 set dynamicport tcp start=20000 num=40000
```

修改注册表
https://blog.csdn.net/weixin_43866043/article/details/111152111
https://learn.microsoft.com/en-US/troubleshoot/windows-client/networking/connect-tcp-greater-than-5000-error-wsaenobufs-10055

### 自定义配置
```yaml
parsers: # array
  - url: https://ss-subs.paofusub2.com/sub?target=clash&interval=259200&url=https%3A%2F%2Fwww.paofusub2.com%2Flink%2FZiDgimyxSY8P6NwD%3Fsub%3D1&insert=false&config=https%3A%2F%2Fcdn.jsdelivr.net%2Fgh%2FPaofu-cloud%2Fclashrules%40main%2Fclash.ini&filename=PaofuCloud&emoji=true&list=false&udp=false&tfo=false&scv=false&fdn=false&sort=false&new_name=true
    yaml:
      commands:
        - dns.enhanced-mode=fake-ip
      prepend-rules:
        - DOMAIN-SUFFIX,amazonaws.com,🇸🇬 新加坡节点
        - DOMAIN-SUFFIX,google-analytics.com,DIRECT
        - DOMAIN-SUFFIX,paofu.cloud,📲 Telegram
        - DOMAIN-SUFFIX,gstatic.com,📲 Telegram
        - DOMAIN-SUFFIX,sentry.io,📲 Telegram
        - DOMAIN-SUFFIX,googlesyndication.com,📲 Telegram
        - DOMAIN-SUFFIX,netflix.com,📲 Telegram
        - DOMAIN-SUFFIX,similarweb.com,📲 Telegram
        - DOMAIN-SUFFIX,microsoft.com,📲 Telegram
        - DOMAIN-SUFFIX,jsdelivr.net,📲 Telegram
        - DOMAIN-SUFFIX,ahrefs.com,📲 Telegram
        - DOMAIN-SUFFIX,pndsn.com,📲 Telegram
        - DOMAIN-SUFFIX,cursor.sh,📲 Telegram
        - DOMAIN-SUFFIX,githubassets.com,📲 Telegram
        - DOMAIN-SUFFIX,visualstudio.com,📲 Telegram
        - DOMAIN-SUFFIX,azure.cn,📲 Telegram
        - DOMAIN-SUFFIX,ko-fi.com,📲 Telegram
        - DOMAIN-SUFFIX,steampowered.com,📲 Telegram
        - DOMAIN-SUFFIX,lemonsqueezy.com,📲 Telegram
        - DOMAIN-SUFFIX,stripe.com,📲 Telegram
        - DOMAIN-SUFFIX,stripecdn.com,📲 Telegram
        - DOMAIN-SUFFIX,vercel.com,📲 Telegram
        - DOMAIN-SUFFIX,jwt.io,📲 Telegram
        - DOMAIN-SUFFIX,canva.com,📲 Telegram
        - DOMAIN-SUFFIX,tailwindcss.com,📲 Telegram
        - DOMAIN-SUFFIX,x.com,📲 Telegram
        - DOMAIN-SUFFIX,youtube.com,📲 Telegram
        - DOMAIN-SUFFIX,pmnd.rs,📲 Telegram
        - DOMAIN-SUFFIX,chatgptextension.ai,📲 Telegram
        - DOMAIN-SUFFIX,investing.com,📲 Telegram
        - DOMAIN-SUFFIX,bsky.app,📲 Telegram
        - DOMAIN-SUFFIX,bsky.social,📲 Telegram
        - DOMAIN-SUFFIX,bsky.network,📲 Telegram
        - DOMAIN-SUFFIX,chrome-stats.com,📲 Telegram
        - DOMAIN-SUFFIX,githubusercontent.com,📲 Telegram
        - DOMAIN-SUFFIX,github.com,📲 Telegram
        - DOMAIN-SUFFIX,1337x.to,📲 Telegram
        - DOMAIN-SUFFIX,bing.com,DIRECT
        - DOMAIN-SUFFIX,google.com,📲 Telegram
        - DOMAIN-SUFFIX,googleapis.com,📲 Telegram
        - DOMAIN-SUFFIX,googleusercontent.com,📲 Telegram
        - DOMAIN-SUFFIX,gstatic.com,📲 Telegram
        - DOMAIN-SUFFIX,cloudflare.com,📲 Telegram
        - DOMAIN-SUFFIX,cloudflarestorage.com,📲 Telegram
        - DOMAIN-SUFFIX,cloudflareinsights.com,📲 Telegram
        - DOMAIN-SUFFIX,reddit.com,📲 Telegram
        - DOMAIN-SUFFIX,redditspace.com,📲 Telegram
        - DOMAIN-SUFFIX,facebook.com,📲 Telegram
        - DOMAIN-SUFFIX,vercel.app,📲 Telegram
        - DOMAIN-SUFFIX,npmjs.com,📲 Telegram
        - DOMAIN-SUFFIX,perplexity.ai,📲 Telegram
        - DOMAIN-SUFFIX,lumalabs.ai,📲 Telegram
        - DOMAIN-SUFFIX,chatgpt.com,📲 Telegram
        - DOMAIN-SUFFIX,oaistatic.com,📲 Telegram
        - DOMAIN-SUFFIX,oaiusercontent.com,📲 Telegram
        - DOMAIN-SUFFIX,openai.com,📲 Telegram
        - DOMAIN-SUFFIX,claude.ai,📲 Telegram
        - DOMAIN-SUFFIX,anthropic.com,📲 Telegram
        - DOMAIN-SUFFIX,crawlee.dev,📲 Telegram
        - DOMAIN,tubi.tv,📲 Telegram
        - DOMAIN,tubi.io,📲 Telegram
        - DOMAIN,nextui.org,📲 Telegram
        - DOMAIN,tubitv.com,📲 Telegram
        - DOMAIN-SUFFIX,mypikpak.com,🇸🇬 新加坡节点
        - DOMAIN-SUFFIX,hexo.io,📲 Telegram
        - DOMAIN-SUFFIX,staticfile.org,📲 Telegram
        - DOMAIN-SUFFIX,jetbrains.com,📲 Telegram
        - DOMAIN-SUFFIX,steamcommunity.com,📲 Telegram
        - DOMAIN-SUFFIX,rockstartgames.com,📲 Telegram
        - DOMAIN-SUFFIX,wmzhe.com,📲 Telegram
        - DOMAIN,yarnpkg.com,📲 Telegram
        - PROCESS-NAME,Rockstart*,📲 Telegram
        - PROCESS-NAME,node.exe,Crawlee
        - DST-PORT,22,DIRECT
      append-proxy-groups:
        - name: Crawlee
          type: load-balance
          strategy: round-robin
          url: http://www.gstatic.com/generate_204
          interval: 3 # 30s测试一次，然后切换服务器
          lazy: true
          # tolerance: 2000
          # include-all: true # 引用所有 proxies
          # filter: 'HK|香港' # 筛选含有 HK 或香港关键字的代理
          proxies:
            - 🇭🇰 [v1] 香港・01
            - 🇭🇰 [v1] 香港・02
            - 🇭🇰 [v1] 香港・03
            - 🇭🇰 [v1] 香港・04
            - 🇭🇰 [v1] 香港・05
            - 🇭🇰 [v1] 香港・06
            - 🇭🇰 [v1] 香港・07
            - 🇭🇰 [v1] 香港・08
            - 🇭🇰 [v1] 香港・09
            - 🇭🇰 [v1] 香港・10
            - 🇭🇰 [v3] 香港・01
            - 🇭🇰 [v3] 香港・02
            - 🇭🇰 [v3] 香港・03
            - 🇭🇰 [v3] 香港・04
            - 🇭🇰 [v3] 香港・05
            - 🇭🇰 [v3] 香港・06
            - 🇭🇰 [v3] 香港・07
            - 🇭🇰 [v3] 香港・08
            - 🇭🇰 [v3] 香港・09
            - 🇭🇰 [v3] 香港・10
            - 🇨🇳 [v1] 台湾・01
            - 🇨🇳 [v1] 台湾・02
            - 🇨🇳 [v1] 台湾・03
            - 🇨🇳 [v1] 台湾・04
            - 🇨🇳 [v1] 台湾・05
            - 🇨🇳 [v3] 台湾・01
            - 🇨🇳 [v3] 台湾・02
            - 🇨🇳 [v3] 台湾・03
            - 🇨🇳 [v3] 台湾・04
            - 🇸🇬 [v1] 新加坡・01
            - 🇸🇬 [v1] 新加坡・02
            - 🇸🇬 [v1] 新加坡・03
            - 🇸🇬 [v1] 新加坡・04
            - 🇸🇬 [v1] 新加坡・05
            - 🇸🇬 [v3] 新加坡・01
            - 🇸🇬 [v3] 新加坡・02
            - 🇸🇬 [v3] 新加坡・03
            - 🇸🇬 [v3] 新加坡・04
            - 🇺🇸 [v1] 美国・01
            - 🇺🇸 [v1] 美国・02
            - 🇺🇸 [v1] 美国・03
            - 🇺🇸 [v1] 美国・04
            - 🇺🇸 [v1] 美国・05
            - 🇺🇸 [v3] 美国・01
            - 🇺🇸 [v3] 美国・02
            - 🇺🇸 [v3] 美国・03
            - 🇺🇸 [v3] 美国・04
            - 🇯🇵 [v1] 日本・01
            - 🇯🇵 [v1] 日本・02
            - 🇯🇵 [v1] 日本・03
            - 🇯🇵 [v1] 日本・04
            - 🇯🇵 [v1] 日本・05
            - 🇯🇵 [v3] 日本・01
            - 🇯🇵 [v3] 日本・02
            - 🇯🇵 [v3] 日本・03
            - 🇯🇵 [v3] 日本・04
        - name: Crawlee.hk
          type: load-balance
          strategy: round-robin
          url: http://www.gstatic.com/generate_204
          interval: 3 # 30s测试一次，然后切换服务器
          lazy: true
          # tolerance: 2000
          # include-all: true # 引用所有 proxies
          # filter: 'HK|香港' # 筛选含有 HK 或香港关键字的代理
          proxies:
            - 🇭🇰 [v1] 香港・01
            - 🇭🇰 [v1] 香港・02
            - 🇭🇰 [v1] 香港・03
            - 🇭🇰 [v1] 香港・04
            - 🇭🇰 [v1] 香港・05
            - 🇭🇰 [v1] 香港・06
            - 🇭🇰 [v1] 香港・07
            - 🇭🇰 [v1] 香港・08
            - 🇭🇰 [v1] 香港・09
            - 🇭🇰 [v1] 香港・10
            - 🇭🇰 [v3] 香港・01
            - 🇭🇰 [v3] 香港・02
            - 🇭🇰 [v3] 香港・03
            - 🇭🇰 [v3] 香港・04
            - 🇭🇰 [v3] 香港・05
            - 🇭🇰 [v3] 香港・06
            - 🇭🇰 [v3] 香港・07
            - 🇭🇰 [v3] 香港・08
            - 🇭🇰 [v3] 香港・09

```
