---
title: Service Worker
toc: true
date: 2020-03-01 00:00:02
tags:
---

注册SW后，浏览器在请求资源前会先执行SW代码，决定取缓存还是重新请求，从而达到`缓存管理/离线使用`的目的；【[参考资料](https://mrluo.life/article/detail/140/pwa-primer)】
* 安装离线使用的资源：assets和fetch资源
* 底层依赖CacheStorage


### sw的生命周期管理
register -> install -> waiting -> activate 【[参考资料](https://segmentfault.com/a/1190000007487049
)】
* sw默认24小时重新下载一遍，如有改动则会立即重新下载
* 默认情况下，sw刚进来install是不会生效的，第二次打开才会生效；
  * 可以在activate阶段执行`client.claim`让其立即生效（其他窗口也会生效）
* 同个`register.scope`下的多个页面也只会由一个sw来管理
* 默认情况下，第一个加载的sw会掌管后面所有的页面，直到所有页面关闭，第一个sw才会退出掌管
  * 可以在新的sw.install时通过`self.skipWaiting`来强制使其生效<!--（管理所有已经打开的窗口）-->，跳过waiting状态


#### sw调试工具
[Chrome > Application](https://juejin.im/post/5b06a7b3f265da0dd8567513)



### 注册 register
```js
// index.js
if ('serviceWorker' in navigator) {
	
	// 启动线程比较耗时，放在load里
	window.addEventListener('load',  () => {

		// scope 指定所有api生效
        navigator.serviceWorker.register('/sw.js', {scope: '/'}).then(xxx)
	})
}
```


### 安装 install
```js
// sw.js
// html也可以缓存下来
self.addEventListener('install', (event) => {

	event.waitUntil(
    		caches.open('version_1.0.0')                  
    		.then(cache => cache.addAll([ // 如果所有的文件都成功缓存了，便会安装完成。如果任何文件下载失败了，那么安装过程也会随之失败。
			    './index.html',        
      		'/js/script.js',
      		'/images/hello.png'
    		]))
  	);

})
```

[缓存文件可以用插件自动匹配生成](https://www.npmjs.com/package/sw-precache-webpack-plugin)



### fetch缓存
```js

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)                  
    .then(function (response) {
      if (response) {                            
        return response;                         
      }

			/*
				为什么用request.clone()和response.	clone() ?
				需要这么做是因为request和response是一个流，它只能消耗一次。因为我们已经通过缓存消耗了一次，然后发起 HTTP 请求还要再消耗一次，所以我们需要在此时克隆请求
			*/
      var requestToCache = event.request.clone(); 
      return fetch(requestToCache)
		.then((response) => {
          if (!response || response.status !== 200) {      
            return response;
          }
          var responseToCache = response.clone();          
          caches.open(cacheName)                           
            .then(function (cache) {
              cache.put(requestToCache, responseToCache); 
            });
          return response;             
    		})
  );
});
```


### fetch拦截
```js
// 拦截图片请求，支持webp则追加webp参数
self.addEventListener('fetch', (e) => {
    // accept: image/webp,image/apng,image/*,*/*;q=0.8
    const headers = e.request.headers;
    const supportsWebP = headers.has('accept') && headers.get('accept').includes('webp');

    const url = new URL(e.request.url);

    if (supportsWebP && url.host.includes('qiniu')) {
        url.search = '?imageMogr2/format/webp';
        e.respondWith(
            fetch(url.toString(), { mode: 'no-cors' })
        );
    }
});
```


### activate 更新缓存
```js
// 要删掉旧的不用的缓存
var cacheName = 'version_1.0.1'
self.addEventListener('activate', function (e) {
    var cachePromise = caches.keys().then(function (keys) {
        return Promise.all(keys.map(function (key) {
            if (key !== cacheName) {
                return caches.delete(key);
            }
        }));
    })
    e.waitUntil(cachePromise);
    return self.clients.claim();
});

// 或者 

var version = 'version_1.0.1';//每次更新改这个版本号即可
navigator.serviceWorker.register('/sw.js').then((registration) => {
    if (localStorage.getItem('sw_version') !== version) {
        registration.update().then(() => {
            localStorage.setItem('sw_version', version)
        });
    }
});
```



