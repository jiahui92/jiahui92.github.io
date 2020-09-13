---
title: 跨域
toc: true
date: 2020-09-13 00:00:01
tags:
---

* 一个url完整组成：协议、域名【主域名、子域名】、端口、路径
* 除了路径之外，必须都相同，否则跨域


## CORS
### 兼容库
* XHR2
* IE7的XDR(XDomainRequest)


### 跨域原理
* 浏览器遇到跨域请求时，会自动往Request Header加上Origin字段
* 后端需要在Response Header加上Access-Control-Allow-Origin字段，值为允许的域名
* 浏览器判断Access-Control-Allow-Origin的值来确定是否可以跨域

### options请求
只有非简单请求才会先触发options请求，简单请求即为不包含cookie等，详细【[参考资料](http://www.ruanyifeng.com/blog/2016/04/cors.html)】


### 跨域带cookie
跨域情况下，默认不会带cookie，首先检查cookie的生效域是否正确设置了（主域or二级域）。如果正确设置了则需要执行一下操作
* 浏览器：xhr.withCredentials = true
* 服务器添加header：Access-Control-Allow-Credentials: true（注意此时Access-Control-Allow-Origin值不能为“*”）

### nodejs处理options请求例子
直接用cors中间件库@koa/cors
```js
// https://cnodejs.org/topic/51dccb43d44cbfa3042752c8
app.all('*',function (req, res, next) {
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Headers', 'Content-Type, Content-Length, Authorization, Accept, X-Requested-With , yourHeaderFeild');
  res.header('Access-Control-Allow-Methods', 'PUT, POST, GET, DELETE, OPTIONS');

  // 这里处理options请求
  if (req.method == 'OPTIONS') {
    res.send(200); /让options请求快速返回/
  }
  else {
    next();
  }
});
```


## img
常用于log打点

### img跨域打点
[参考资料](https://blog.csdn.net/FuDesign2008/article/details/6772108)
```js
// 打点
export default function log(_event = '', data = {}) {
  const obj = {
    _event,
    _userId,
    _appName,
    ...data,
  };

  const arr = [];

  for (const k in obj) {
    let v = obj[k];
    if (typeof v === 'undefined') v = '';
    if (typeof v === 'object') v = JSON.stringify(v);
    v = encodeURIComponent(v);
    arr.push(k + '=' + v);
  }

  const url = 'https://api.guangjun.club/logger/log?' + arr.join('&');
  imgLog(url);
}


let i = 0;
const time = `${(new Date()).getTime()}-`;

function imgLog(url) {
  // 全局变量防止Image被回收导致请求失败
  const data = window.imgLogData || (window.imgLogData = {}); 
  let img = new Image();
  const uid = time + i++; // 生成唯一id用于阻止缓存请求
  img.onload = img.onerror = () => {
    img.onload = img.onerror = null;
    img = null;
    delete data[uid];
  };
  img.src = url + '&_nocache=' + uid; // 及时存在临时变量，某些浏览器也会立即回收
}

```

### beacon
[参考资料](https://www.barretlee.com/blog/2016/02/20/navigator-beacon-api/)
* 未来可以切换到[beacon](https://zhuanlan.zhihu.com/p/41759633)，但网上说有bug；
* 相比img打点，beacon可以在后台进程里打点，意味着切换页面不会丢失打点请求；


## other
* jsonp
* nginx代理
* websocket


### 页面间跨域
两个页面的跨域（比如iframe或者两个Tab页面）
* postMessage (pc99%, mobile90%)
* document.domain (只能用于主域相同的页面)

[跨域取localStorage](https://blog.csdn.net/weixin_30458043/article/details/97155251
)
```js
// 读取和写入的页面的document.domain都必须设置为主域
document.domain = "xxx.com";
```
