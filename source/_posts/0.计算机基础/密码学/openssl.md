---
title: openssl
toc: true
date: 2020-03-05 00:00:01
tags:
---

## 生成非对称密钥／对称加密
```sh
# 生成1024位的RSA私钥，并使用DES加密
openssl genrsa -des -passout pass:"1234546" -out prikey.key 1024

# 使用私钥提取公钥
openssl rsa -in prikey.key -out pubkey.pem -pubout
```


## 加密文件
```sh
# 加密文件
openssl enc -d -aes256 -in test.png -out test2.png
# 输入密码
# 解密文件
enc -d -aes256 -in test.png -out test2.png
```


## 查询支持的加密算法
```sh
openssl ciphers -v

ECDHE-RSA-AES256-GCM-SHA384 TLSv1.2 Kx=ECDH     Au=RSA  Enc=AESGCM(256) Mac=AEAD
ECDHE-ECDSA-AES256-GCM-SHA384 TLSv1.2 Kx=ECDH     Au=ECDSA Enc=AESGCM(256) Mac=AEAD
ECDHE-RSA-AES256-SHA384 TLSv1.2 Kx=ECDH     Au=RSA  Enc=AES(256)  Mac=SHA384
ECDHE-ECDSA-AES256-SHA384 TLSv1.2 Kx=ECDH     Au=ECDSA Enc=AES(256)  Mac=SHA384
ECDHE-RSA-AES256-SHA    SSLv3 Kx=ECDH     Au=RSA  Enc=AES(256)  Mac=SHA1
ECDHE-ECDSA-AES256-SHA  SSLv3 Kx=ECDH     Au=ECDSA Enc=AES(256)  Mac=SHA1
DHE-RSA-AES256-GCM-SHA384 TLSv1.2 Kx=DH       Au=RSA  Enc=AESGCM(256) Mac=AEAD
DHE-RSA-AES256-SHA256   TLSv1.2 Kx=DH       Au=RSA  Enc=AES(256)  Mac=SHA256
...
```

## digest摘要算法
通常用于验证文件的完整性，md5, sha256
```sh
openssl dgst -md5 myfile.txt
```

## PGP实现
【[参考资料](https://www.cnblogs.com/gordon0918/p/5382541.html)】

![](/img/Snip20200305_25.png)
GPG: The GNU Privacy Guard，PGP的免费版本


## RSA与ECC椭圆曲线算法
[TODO] 【[参考资料](https://www.zhihu.com/question/26662683
)】

![](/img/Snip20200305_26.png)


## 漏洞: openssl heartbleed
[TODO] 当黑客访问服务器时，漏洞会给其随机返回内存中的一些内容，其中就可能包括密码信息【[参考资料1](https://www.zhihu.com/question/23328658/answer/24241031)】
【[参考资料2](https://zhuanlan.zhihu.com/p/19722474)】
