---
title: 优化
toc: true
date: 2020-03-07 00:00:05
---

[TODO]
* https://reactjs.org/docs/optimizing-performance.html
* https://github.com/fi3ework/blog/issues/15


所有的优化都是针对多次render的问题，都是为了减少render次数；但是手动去优化，都是有成本的，会把代码变得更复杂；所以大部分情况下，如果浏览器的性能足够，就不需要去手动优化；【[参考资料](https://www.jianshu.com/p/c41bbbc20e65)】


# shouldComponentUpdate
父组件更新之后触发render导致子组件render（即Reconciler的过程），所以引入shouldComponentUpdate来减少这种情况；而在vue中会通过依赖收集来避免这种情况；【[参考资料](https://segmentfault.com/a/1190000016494335)】
> 对于对象和数组这种引用数据来说，通常需要使用[Immutable](/wiki/1.前端/z.框架_源码_原理/React/immutable.md)来创建一个新的对象或数组

```js
shouldComponentUpdate(nextProps, nextState, nextContext) {
  // 注意对象和数组不能直接用引用地址判断
  return nextState.someVal !== this.state.someVal;
}
```

# PureComponent
自带shouldComponentUpdate props,state `浅比较`的组件

# React.memo
类似PureComponent，只不过时给functional component使用的，只会对prop进行浅比较

```js
function MyComponent(props) {
  /* render using props */
}

function isEqual(prevProps, nextProps) {
  // 默认浅比较prop，也可以覆盖这个函数来自定义比较
}

export default React.memo(MyComponent, isEqual);
```


# useCallback, useMemo
【[参考资料](https://jancat.github.io/post/2019/translation-usememo-and-usecallback/)】
* useCallback缓存函数
* useMemo可以缓存任何类型的值
```js
// 仅仅使用React.memo无法避免点击之后触发siblings按钮rerender，还需要搭配下面的useCallback一起使用，避免每次都传入一个新的onClick函数给CountButton
const CountButton = React.memo(function CountButton({onClick, count}) {
  return <button onClick={onClick}>{count}</button>
})

function DualCounter() {
  const [count1, setCount1] = React.useState(0)
  const increment1 = React.useCallback(() => setCount1(c => c + 1), [])

  const [count2, setCount2] = React.useState(0)
  const increment2 = React.useCallback(() => setCount2(c => c + 1), [])

  return (
    <>
      <CountButton count={count1} onClick={increment1} />
      <CountButton count={count2} onClick={increment2} />
    </>
  )
}

// 缓存函数的引用
const increment = useMemo(() => () => setCount1(c => c + 1), []);
// 通常用来缓存计算量比较大值
const someArr = useMemo(() => [1, 2, 3], []);
```

* render函数中减少类似`onClick={()=>{doSomething()}}`的写法，每次调用render函数时均会创建一个新的函数，即使内容没有发生任何变化，也会导致节点没必要的重渲染
* 参考上例，在hooks中更容易踩中这种坑，因为除了useCallback处理过的函数，每次都是重新生成的；


# React.lazy
* 使用`Suspense`来处理加载中的情况
* `import()`用于code spliting和动态加载
* 使用`ErrorBoundary.componentDidCatch`处理异常
```js
// 普通用法
import React, { Suspense } from 'react';
const OtherComponent = React.lazy(() => import('./OtherComponent'));

function MyComponent() {
  return (
    <ErrorBoundary>
      <Suspense fallback={<div>Loading...</div>}>
        <OtherComponent />
      </Suspense>
    </ErrorBoundary>
  );
}
```

```js
// react-router用法
import React, { Suspense, lazy } from 'react';
import { BrowserRouter as Router, Route, Switch } from 'react-router-dom';

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


# 调试工具
* [react-perf-devtool](https://github.com/nitin42/react-perf-devtool): 可以知道哪些组件渲染了多少次
* [react-profiler](https://zh-hans.reactjs.org/blog/2018/09/10/introducing-the-react-profiler.html): 官方工具
