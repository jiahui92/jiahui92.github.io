---
title: mainfest
toc: true
date: 2020-03-01 00:00:01
tags:
---

```js
// mainfest.json
{
	name, // 安装横幅名
	short_name, // 应用名
	icons[], // 应用图标
	start_url, // 启动url


	display,
	// * fullscreen 全屏
	// * standlone 显示系统状态栏
	// * brower 显示浏览器状态栏

	background_color, // 启动页背景色
	theme_color, // 状态栏颜色

	orientation,
	scope, // manifest作用范围，默认为当前所在文件夹

	prefer_related_applications, // 安装原生应用
}
```

```css
/* 响应式：自定义各种状态下的样式 */
@media all and (display-mode: fullscreen) {
    body {
        margin: 0;
    }
}
```


### 应用安装横幅
如果一进入页面就提示用户安装应用，一般是不安装的，所以需要延后执行；通过点击按钮或者引导用户操作浏览器菜单栏进行”添加到桌面“操作
```js
window.addEventListener('beforeinstallprompt', function (ev) {
	
	// 点击按钮才安装
	installBtn.addEventListener("click", () => {
			ev.prompt();
	});

	ev.userChoice.then(function (choiceResult) {
			alert(choiceResult.outcome); // 是否安装应用
	});
});
```

#### 应用安装横幅展示的前提条件
* 部署了manifest.json
* https
* 注册了Service Worker
* 访问了两次且间隔少于5分钟

