---
title: entry&output
toc: true
date: 2020-03-20 00:00:01
tags:
---

【[参考资料](https://webpack.js.org/configuration/entry-context/)】
* context: 配置了基础目录的话entry可以用相对路径
* entry: 各个文件入口
* output: 打包后的路径、命名规则

```js
{
  context: path.resolve(__dirname, 'app'),
  entry: {
    main: path.resolve(__dirname, '/app/main.js'),
    other: path.resolve(__dirname, '/app/other.js'),
  },
  output: {
    path: path.resolve(__dirname, '/public'), // 打包后的文件放在哪个目录
    filename: '[name].js', // 打包后的文件名
    chunkFilename: '[name].js',
  }
}
```

## 从entry抽离npm包
```js
{
  entry: {
    vendor: ['react', 'react-dom', 'redux'],
    ...
  }
}
```