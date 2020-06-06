---
title: Sentry 报错监控
toc: true
date: 2020-03-02 00:00:03
tags:
---

# 在线免费版
* sentry在线免费版每月10k报错量
  * 开源版本可自行搭建
* fundebug在线免费版每月3k报错量


# 安装
[参考资料1](https://github.com/getsentry/onpremise), [参考资料2](https://zhuanlan.zhihu.com/p/51446011)
* at least 2.4GB RAM
```sh
git clone https://github.com/getsentry/onpremise.git

cd onpremise

# 生成密钥 ，生成的结果复制到./sentry/config.yml
docker-compose run --build --rm web config generate-secret-key

# 会自动docker pull image 和 create volume
# 假如重装时这些image已经下载过了，可以注释里面的pull逻辑，因为sentry几分钟就更新一次，导致每次都得pull新的image，很慢；
./install.sh

docker-compose up -d

# 关闭重装
docker-compose down -v
# 根据上面执行后的提示
docker volume remove 所有external volume

```
* 访问http://127.0.0.1:9000
* 设置邮箱
```yml
mail.backend: 'smtp'
mail.host: 'smtp.qq.com'
mail.port: 587
mail.username: '547652008@qq.com'
# 不是qq密码，需要在邮箱设置里生成
mail.password: 'ikdgfdndpizcdddd'
mail.use-tls: true
mail.from: '547652008@qq.com'
```
* [测试邮件](https://www.cnblogs.com/duanxz/p/11837182.html)
* 测试客户端报错


# 插件
* `sentry-webpack-plugin`: webpack打包后自动上传sourcemap到sentry
* `sentry-cli`: 更灵活定制sourcemap上传
* 小程序SDK
  * https://github.com/lizhiyao/sentry-miniapp
  * https://github.com/youzan/raven-weapp


# 录制回放
* https://github.com/rrweb-io/rrweb/blob/master/README.zh_CN.md
* https://logrocket.com/


# 一些细节处理
[参考资料](https://www.bugs.cc/p/javascript-integration-sentry/)
## 自动上报注意跨域问题
window.onerror采集错误时，跨域会导致错误信息不足`Script Error`
* Access-Control-Allow-Origin
* `<script src="xxx.com/path/to/x.js" crossorigin></script>`

## 手动上报
一些三方库会内部处理错误且不对外throw，此时需要借助`captureException(error, { extra: errorInfo })`和三方库的`errorHandler`手动上报
* vue: config.errorHandler
* react: componentDidCatch
* jquery
* defind
* 异步代码: 拦截代理
  * setTimeout, setInterval
  * promise: unhandledrejection
* 函数: webpack-plugin处理，使用`try,catch`包裹

## 延时上报处理
防止同时触发多次接口
