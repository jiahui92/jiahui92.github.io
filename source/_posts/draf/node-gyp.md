---
title: node-gyp
toc: true
hidden: true
date: 2020-04-07 00:00:07
tags:
---

# node-gyp
跨平台的打包工具，在win下会使用`visual studio c++ build tool`来打包代码，而在mac下使用`xcode`打包代码;

## 记一次window下 npm install 的node-gyp报错
![](/img/Snip20210509_01.png)

* 可能因为win环境已经乱成一麻了，重装了很多遍vs2017，2015都没好，发现是rush在 `npm i oniguruma@7.2.1`时报错，于是从这个包开始找问题（图里其实也有Log出来，但一开始没留意）；
* 去github clone对应的onigurum仓库，执行 npm i 报一样的 node-gyp rebuild 错误（npm i 完成后，npm会自动使用内置的node-gyp读取binding.gyp配置进行编译）；
* `npm ls -g node-gyp` 获取内置node-gyp的版本，然后 `npm i node-gyp@x.x.x --save` ， `../node_modules/.bin/node-gyp rebuild` 可以获得一样的报错；
* 然后问题就变成了，只要在这个项目内rebuild通过，那么rush就不会有问题
* 最后是通过`npm config set msvs_version 2017 -g`成功编译，如果还不行可以参考[这个链接](https://github.com/iliuyt/blog/issues/17)确认是否缺少某些部件
  * Windows10 SDK
  * Visual Studio C++ core features
  * VC++ 2017 v141 toolset (x86,x64)
* 或者试一下[强制升级npm内部的node-gyp](https://toyobayashi.github.io/2019/04/04/NodeGypAndVS2019/)
  * 3.8.0 开始默认使用vs2017

