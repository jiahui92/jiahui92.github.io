
## img跨域打点
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
  