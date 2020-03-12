---
title: sourcemap
toc: true
date: 2020-03-12 00:00:04
tags:
---


sourcemap是在编译代码期间产生的
```js
import generate from 'babel-generator'
// 生成编译后代码和sourcemap
generate(ast, {}, code);
// {
//   code: "...", // 编译后的代码
//   map: "..." // sourcemap
// }
```


## 原理
【[参考资料](https://github.com/wayou/wayou.github.io/issues/9)】
```js
// log.js
function sayHello(name) {
  if (name.length > 2) {
    name = name.substr(0, 1) + '...'
  }
  console.log('hello,', name)
}

// main.js
sayHello('1')
sayHello('2')
```
```js
// 生成的sourcemap
{
  "version":3,
  "sources":["log.js", "main.js"], // 被压缩的文件
  "names":["sayHello","name","length","substr","console","log"], // 代码片段里所有出现过的单词（除了字面量外的词，因为字面量不会被压缩/修改的）
  "mappings":"AAAA,SAASA,SAASC,MACd,GAAIA,KAAKC,OAAS,EAAG,CACjBD,KAAOA,KAAKE,OAAO,EAAG,GAAK,MAE/BC,QAAQC,IAAI,SAAUJ,MCJ1BD,SAAS,MACTA,SAAS"
}
```

### mappings
* ";"对应分割转换后代码的一行
* ","对应分割转换后代码的一个位置／单词

#### VLQ编码位置对应
* 第一位，表示这个位置在（转换后的代码的）的第几列。
* 第二位，表示这个位置属于sources属性中的哪一个文件。
* 第三位，表示这个位置属于转换前代码的第几行。
* 第四位，表示这个位置属于转换前代码的第几列。
* 第五位，表示这个位置属于names属性中的哪一个变量。
