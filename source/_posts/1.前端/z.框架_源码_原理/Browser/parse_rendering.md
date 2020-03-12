---
title: 解析渲染
toc: true
date: 2020-03-12 00:00:01
tags:
---

<style>
  .opacity8 { opacity: 0.8; }
</style>

* https://developers.google.com/web/fundamentals/performance/rendering?hl=zh-CN
* https://www.cnblogs.com/163yun/p/9882724.html


## 解析渲染流程
![](/img/Snip20200312_1.png)

* parse html --> DOM Tree
* preload scanner 扫描需提前加载img等资源
* script download && execute
* CSS样式计算：CSS OM 和 CSS Rule Tree
* 生成Render Tree：比DOM Tree多了伪元素
	* Layout Tree：根据Render Tree计算元素位置和尺寸
* Paint
	* 根据Layout Tree绘制每层Layer图像，包括颜色，阴影、文本、图片等
	* Raster: 将图像栅格化后上传到GPU显存
* Composite: 将栅格化后的图像合成为一帧图像并输出到屏幕；这里也可以利用Raster上传过的图像缓存直接处理css3动画；

![](/img/Snip20200312_2.png)



## js阻塞GUI
js引擎与GUI线程是互斥的，只能执行其中一个【[参考资料](https://www.jianshu.com/p/202ec7e5bf74)】
* 实际上并不存在GUI线程，这里应该是泛指Dom Tree、合成帧等与UI渲染相关的线程吧；
* 互斥是为了防止js操作dom的过程中，GUI同时发生变更，可能会导致数据混乱；比如执行parseHtml到一半，然后突然并行执行js里的document.write，导致前面解析得到的Dom Tree与现在不符了；【[参考资料](https://www.zhihu.com/question/29797252)】
* js与渲染的关系详细可看[EventLoop](./JSCore/EventLoop)

```js
$('body').css('background', 'red')
while(true) {} // 卡死／阻塞GUI渲染；背景不会变红色；

// 因为chrome的多进程架构，执行该脚本时，只会卡死当前页面，并且浏览器上方的关闭等按钮和其它页面都还是可以操作的；
```



### 优化
#### script阻塞
script放在html尾部，避免阻塞；
* script.defer在IE89中有bug，导致乱序执行；如果非得要用，可以搭配条件注释；【[参考资料](https://github.com/h5bp/lazyweb-requests/issues/42)】
* script.defer的执行时机在htmlParse和DOMContentLoaded之间~~，但某些bug浏览器会在DOMContentLoaded之后执行；【[参考资料](https://bugzilla.mozilla.org/show_bug.cgi?id=688580)】~~
* script.async是乱序执行的，下载完立即执行，所以不保证顺序，所以有可能会阻塞parse html；网上有些推荐在“百度统计”类的script使用，但这样不是会阻塞parseHtml嘛？下载期间不阻塞，执行期间阻塞；
![](/img/Snip20200312_3.png)

#### addEventListener.passive
声明该事件不会阻止浏览器默认事件，比如滚动页面，让Compositor thread跳过main thread不用等待事件执行完毕，直接进行合成并渲染UI；

