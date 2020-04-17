---
title: sourcemap:devtool
toc: true
date: 2020-03-20 00:00:02
tags:
---

## webpack配置
【[参考资料](https://segmentfault.com/a/1190000008315937)】
* devtool
	* cheap: 映射不到源码对应列
	* module: 包含loader的sourcemap
	* eval: 构建会快一些，但不能用在生产环境
	* source-map: 产生.map文件

开发环境: cheap-module-eval-source-map
生产环境: cheap-module-source-map
```js
const isProduction = process.env.NODE_ENV === 'production';
const devtool = isProduction ? 'cheap-module-source-map' : 'cheap-module-eval-source-map';

module.exports = {
  mode: isProduction ? 'production' : 'development',
  devtool,
  ...
}
```
```json
// package.json
{
  ...
  "scripts": {
    "build": "export NODE_ENV=production && webpack",
  }
}
```


## soucemap
[sourcemap的原理](/wiki/1.前端/z.框架_源码_原理/AST/sourcemap)

[报错监控结合sourcemap](https://www.npmjs.com/package/source-map)
```js
import { SourceMapConsumer } from 'source-map';

// rawSourceMap是sourcemap文件对象
SourceMapConsumer.with(rawSourceMap, null, consumer => {

  console.log(
    consumer.generatedPositionFor({
      // two.js的第2行，第10列报错
      source: 'http://example.com/www/js/two.js',
      line: 2,
      column: 10
    })
  );
  // 输出对应源码的：{ line: 2, column: 28 }

})
```
