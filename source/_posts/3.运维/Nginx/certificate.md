---
title: 证书
toc: true
date: 2020-03-02 00:00:04
tags:
---


* 使用[acme.sh](https://github.com/acmesh-official/acme.sh)安装证书，支持泛域名、自动续签；【[参考资料](https://jszbug.com/zxaiacja34.html)】
* 登录域名管理后台（比如[腾讯域名管理 > 用户中心 > 密钥管理](https://console.dnspod.cn/account/token)）创建密钥
* [其它域名管理商的密钥环境设置](https://github.com/acmesh-official/acme.sh/wiki/dnsapi)
```sh
# 腾讯域名操作密钥
export DP_Id="160830"
export DP_Key="a000eeacb7a7fbf41ae53afaa04bd9a9"

# 泛域名 注意要用双引号圈住，不然可能会报错
# 每60天acme.sh会自动更新证书
# 设置--renew-hook来更新完毕后自动重载nginx证书缓存
# dnssleep 减少dns check的检查时间(超时则默认成功，避免使用google dns导致的失败) https://www.xinac.net/9206.html
acme.sh --issue --dns dns_dp -d guangjun.club -d "*.guangjun.club" --renew-hook "nginx -t && nginx -s reload" --dnssleep 30

# 查看下次更新时间
acme.sh --list
# 查看定时检查过期的任务是否已经添加成功
acme.sh --cron
# 强行执行一次定时任务
acme.sh --cron -f


# 手动更新证书
acme.sh --renew-all --force
nginx -t && nginx -s reload
```

证书生成完毕后，会在目录下看到这几个文件
* ca.cer: 中间证书 (ca是中间证书颁发机构)
* guangjun.club.cer: 域名证书
* fullchain.cer: 包含中间证书和域名证书
* guangjun.club.key: 证书私钥
* guangjun.club.csr: [证书签名申请](https://www.trustasia.com/news-201801-what-is-the-role-and-generation-of-csr-and-csr)
* guangjun.club.conf
* guangjun.club.csr.conf


```nginx
listen       443 ssl http2;

ssl_certificate "/xxx/fullchain.cer";
ssl_certificate_key "/xxx/xxxx.key";
ssl_session_cache shared:SSL:1m;
ssl_session_timeout 10m;
ssl_ciphers HIGH:!aNULL:!MD5;
ssl_prefer_server_ciphers on;
```

配置完毕后，使用[sslabs](https://www.ssllabs.com/ssltest)测试SSL健康情况


## nodejs中间证书的报错
在不提供中间证书的情况下，浏览器会自行下载，但是某些情况下不支持自动下载的话，会报错，比如nodejs [Error: unable to verify the first certificate](https://stackoverflow.com/questions/31673587/error-unable-to-verify-the-first-certificate-in-nodejs)  【[参考资料](https://blog.vimge.com/archives/other/ssl-fullchain.html)】
* 将`nginx.ssl_certificate`改成`fullchain.cer`即可
* 或者 `require('https').globalAgent.options.ca = require('ssl-root-cas/latest').create();
`这个代码运行后，需要等待下载证书，下载完毕后可以在命令行看到提示；
