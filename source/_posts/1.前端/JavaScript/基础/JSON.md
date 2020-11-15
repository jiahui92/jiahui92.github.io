---
title: JSON
toc: true
date: 2020-09-13 00:00:05
tags:
---

# JSON & emoji
注意JSON不能操作带有emoji字符，在低版本浏览器中不支持，会报错【[参考资料](https://stackoverflow.com/questions/14488503/ios-cannot-decode-emoji-unicode-in-json-format-correctly-and-emoji-icons-are-di)】；对于`fetch`自动做的json处理也是会有这个问题；
* Convert Emoji characters to base64 and send to server using Json.
* On server side save base64 in database without decode.
