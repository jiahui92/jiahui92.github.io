---
title: 正则表达式
toc: true
date: 2020-03-01 00:00:01
tags:
---


[基础](https://docs.microsoft.com/zh-cn/previous-versions/visualstudio/visual-studio-2008/ae5bf541(v=vs.90)?redirectedfrom=MSDN)

[常用正则](https://tool.oschina.net/regex/#)

[参考资料](https://juejin.im/post/5965943ff265da6c30653879)

[正则可视化工具](https://jex.im/regulex/#!flags=&re=(%5Cd%7B4%7D)(%3F%3D%5Cd))


`.`匹配除`\n`换行符外的自负，若要匹配任意字符，可以使用`[\s\S]`


贪心、非贪心 `{n,m}?` `{n,}?` `??` `o+?` `o+` `o*?`


# 先行搜索
继续匹配但不捕捉为结果，只是判断一下
`(pattern)` 对匹配结果进行分组
`(?=pattern)` 继续匹配看是否符合pattern
`(?!pattern)` 继续匹配看是否不符合pattern
`(?:pattern)` 继续匹配并丢弃匹配到的结果

![](/img/Snip20200330_1.png)

```js
"123456789".replace(/(\d{4})(?=\d)/g,'$1 '); // 1234 5678 9

"123456789".replace(/(\d{4})(?!\d)/g,'$1 '); // 123456789
"12345678s".replace(/(\d{4})(?!\d)/g,'$1 '); // 12345678 s

"123456789".replace(/(\d{4})(?:\d)/g,'$1 '); // 1234 6789


// "123456" ==> "123,456"
// "1234567" ==> "1,234,567"
"1234567".replace(/(?!^)(?=(\d{3})+$)/g, ",$&");
```







# API
* regexp.test
* [regexp.exec](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/RegExp/exec)
* string.split
* string.replace
* string.match

```js
const reg = /foo*/g;
const str1 = 'table football foosball';
let arr;

while ((arr = reg.exec(str1)) !== null) {
  console.log(`Found ${arr[0]} , Next starts at ${reg.lastIndex}.`);
  // output1: "Found foo , Next starts at 9."
  // output2: "Found foo , Next starts at 18."
}
```