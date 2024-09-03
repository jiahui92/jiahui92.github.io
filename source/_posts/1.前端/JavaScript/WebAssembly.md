---
title: WebAssembly
toc: true
date: 2020-03-01 00:00:04
tags:
---

兼容性96%  IE全军覆没

* 开发语言：AssemblyScript/TypeScript, c/c++等
* 性能：弥补js计算慢的缺点，但通常wasm还会与js交互，实际还是慢于原生
	* 音视频处理: FFmpeg.wasm, flv.js
	* 视觉相关: OpenCV.js
	* TensorFlow.js with WASM Backend
	* 数据库: SQLite-wasm
	* 解压缩Zstd.js
	* 图片裁剪


```js
// 斐波那契f(40) 70s vs 108s
WebAssembly.instantiate(bytes).then(mod=>{
  mod.instance.f(50);
})
```


* [WebAssembly Roadmap](http://webassembly.org.cn/roadmap/)
* [WebAssembly的发展史](https://magicly.me/fe-hpc/asmjs-and-webassembly/)
* [OCR: tesseract](https://github.com/jiahui92/playground/tree/master/ocr)


### GPU并行运算
大计算量（1000维矩阵）也可以考虑一下[gpu.js](https://github.com/gpujs/gpu.js)并行运算，GPU可以有几千个线程

[使用JS的进行GPU计算](https://www.xjp.in/2017/10/22/%E4%BD%BF%E7%94%A8JS%E7%9A%84%E8%BF%9B%E8%A1%8CGPU%E8%AE%A1%E7%AE%97/)

