---
title: router
toc: true
date: 2020-03-07 00:00:07
---


[官方文档](https://reacttraining.com/react-router)

# Router
* HashRouter: 通过`hashchange event`实现，一般用这个，最简单，旧版浏览器支持，也不需要后端配置
* BrowserRouter: 通过`pushState,replaceState,popstate event`实现，但是需要后端或nginx支持不同的路径返回前端的html【[参考资料](https://github.com/LoeiFy/Recordum/issues/15)】
* MemoryRouter: React Native 和 node测试等非浏览器环境下，没有url，只能记在内存中
* StaticRouter: SSR

```html
import {
  HashRouter as Router,
  Switch,
  Route,
  Link
} from "react-router-dom";


<Router>
  <!-- Switch只会渲染匹配中的第一个符合要求的Route -->
  <Switch>
    <Route exact path="/">
      <Home />
    </Route>
    <Route path="/about">
      <About />
    </Route>
    <Route path="/:user">
      <User />
    </Route>
  </Switch>
</Router>

<Link to="/about">about</Link>
```

```js
// BrowserRouter
app.get('/*', (req, res) => {
  res.sendfile(path.join(__dirname, 'index.html'))
})
```


# 鉴权
* [使用react-router-config](https://segmentfault.com/a/1190000015282620?utm_source=channel-hottest)
* [自行封装RouteGuard组件代替需要鉴权的Router: 支持路由嵌套](https://www.cnblogs.com/muamaker/p/11531954.html)

```html
<Route>
  <Home />
</Route>
<RouteGuard>
  <User />
</RouteGuard>
<RouteGuard path="/xxx">
  <!-- 嵌套路由/子路由 -->
  <HaveRoute>
</RouteGuard>


function HaveRoute ({ match }) {
  return <Route path={`${match.path}/member`} component={AboutMember} />
}
```


# 代码拆分
```html
import { BrowserRouter as Router, Route, Switch } from 'react-router-dom';
import React, { Suspense, lazy } from 'react';

const Home = lazy(() => import('./routes/Home'));
const About = lazy(() => import('./routes/About'));

const App = () => (
  <Router>
    <Suspense fallback={<div>Loading...</div>}>
      <Switch>
        <Route exact path="/" component={Home}/>
        <Route path="/about" component={About}/>
      </Switch>
    </Suspense>
  </Router>
);
```

```js
// 旧版react: https://my.oschina.net/u/3330521/blog/1821063

function AsyncComponent ({ loadComponent }) {
  return class extends Component {
    ...

    async conponentDidMount() {
      const { default: Child } await loadComponent();
      this.setState({ Child });
    }

    render () {
      const { Child } = this.state;
      return Child ? <Child {...this.props} />  : 'loading';
    }
  }
}

<Route component={AsyncComponent(() => import('./containers/home'))}>
```
