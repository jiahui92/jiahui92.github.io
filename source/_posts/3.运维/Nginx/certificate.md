---
title: 证书
toc: true
date: 2020-03-02 00:00:04
tags:
---


使用[acme.sh](https://github.com/acmesh-official/acme.sh)安装证书，支持泛域名、自动续签；【[参考资料](https://jszbug.com/zxaiacja34.html)】


```sh
# 泛域名 注意要用双引号圈住，不然可能会报错
acme.sh --issue --dns dns_cx -d example.com -d "*.example.com"
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
listen       [::]:443 ssl http2;

ssl_certificate "/xxx/fullchain.cer";
ssl_certificate_key "/xxx/xxxx.key";
ssl_session_cache shared:SSL:1m;
ssl_session_timeout 10m;
ssl_ciphers HIGH:!aNULL:!MD5;
ssl_prefer_server_ciphers on;
```


## nodejs中间证书的报错
在不提供中间证书的情况下，浏览器会自行下载，但是某些情况下不支持自动下载的话，会报错，比如nodejs [Error: unable to verify the first certificate](https://stackoverflow.com/questions/31673587/error-unable-to-verify-the-first-certificate-in-nodejs)  【[参考资料](https://blog.vimge.com/archives/other/ssl-fullchain.html)】
* 将`nginx.ssl_certificate`改成`fullchain.cer`即可
* 或者 `require('https').globalAgent.options.ca = require('ssl-root-cas/latest').create();
`这个代码运行后，需要等待下载证书，下载完毕后可以在命令行看到提示；
