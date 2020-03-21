---
title: devServer
toc: true
date: 2020-03-20 00:00:08
tags:
---

打包完毕后，自动起一个本地服务器用来预览;【[参考资料](https://webpack.docschina.org/configuration/dev-server/)】

## 基础
```js
module.exports = {
  //...
  devServer: {
    contentBase: path.join(__dirname, 'dist'),
    compress: true,
    port: 9000,

    openPage: '/some/url', // 打包完毕后自动打开页面

  }
};
```

## proxy
跨域时可以使用proxy来转发接口
```js
// 基础使用
devServer: {
  proxy: {
    '/api': 'http://localhost:3000'
  }
}


// 代理多个路径
devServer: {
  proxy: [{
    context: ['/auth', '/api'],
    target: 'http://localhost:3000',
  }]
}


// 通过函数判断是否代理
devServer: {
  proxy: {
    context: (pathname, req) => {
      return /get|post/i.test(req.method) && /^\/api/.test(pathname);
    },
    target: 'http://localhost:1234'
  }
}

```
