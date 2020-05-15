---
title: 优化
toc: true
date: 2020-03-07 00:00:05
---

[TODO]

componentWillMount
componentDidMount
shouldComponentUpdate
componentWillUpdate
componentDidUpdate
componentWillUnmount



https://github.com/fi3ework/blog/issues/15



React15
删除react-id
所有的优化都是针对多次render的问题，都是为了减少render次数；但dom的更新还是依据domDiff来的
* React15 componentWillReceiveProps多次触发（在render时会被触发,setState）


React16.3
https://juejin.im/post/5aca20c96fb9a028d700e1ce
* 丢弃: componentWillReceiveProps, componentWillUpdate, componentWillMount
* 新增: static getDerivedStateFromProps, getSnapshotBeforeUpdate
```js
class Example extends React.Component {
  static getDerivedStateFromProps(nextProps, prevState) {
    // ...
  }

  getSnapshotBeforeUpdate(prevProps, prevState) {
    // ...
  }
}
```


http://www.ayqy.net/blog/%E4%BB%8Ecomponentwillreceiveprops%E8%AF%B4%E8%B5%B7/
componentWillReceiveProps
getDerivedStateFromProps
memoize


https://www.jianshu.com/p/c41bbbc20e65
shouldComponentUpdate
PureComponent --> for stateless component 展示类/无状态组件




https://juejin.im/post/5dd64ae6f265da478b00e639
hooks: useMemo缓存组件和useCallback值



render函数中减少类似 onClick={()=>{doSomething()}}的写法，每次调用 render函数时均会创建一个新的函数，即使内容没有发生任何变化，也会导致节点没必要的重渲染



