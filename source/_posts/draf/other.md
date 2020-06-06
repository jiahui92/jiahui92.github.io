---
title: other
toc: true
hidden: true
date: 2020-04-27 00:00:10
tags:
---

# img跨域打点
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

## beacon
[参考资料](https://www.barretlee.com/blog/2016/02/20/navigator-beacon-api/)
* 未来可以切换到[beacon](https://zhuanlan.zhihu.com/p/41759633)，但网上说有bug；
* 相比img打点，beacon可以在后台进程里打点，意味着切换页面不会丢失打点请求；


# seo
* 百度、谷歌 SEO工具
* http://mtool.chinaz.com/



# serverless
[serverless](https://github.com/serverless/components/blob/master/README.cn.md)与docker相似，只不过针对特定的模版隐藏了特定的部署逻辑（Jenkinksfile,Dockerfile），这就意味着不需要自己去维护一台服务器，并安装jenkins和docker；FaaS是一种极致理想的应用情况；
* template.yml配置环境
  * runtime[nodejs/python]、框架[express/koa/eggjs]
  * 网关配置：域名等（替代nginx）
* 直接使用云服务函数：数据库、对象存储、AI
* 监控
* 费用低：相比dokcer能做到按需使用、自动扩容（k8s也能做到）


## 劣势
* 不能登录主机操作
* 假如使用了云函数，各厂商API不相同，应用迁移成本大


## 应用
* BFF
* 轻量级API
* 日志收集
* [SSR](https://github.com/ykfe/egg-react-ssr)

