---
title: 优化
toc: true
date: 2020-03-07 00:00:05
---

[TODO]
https://reactjs.org/docs/optimizing-performance.html


# 不同版本的生命周期变化
componentWillMount
componentDidMount
shouldComponentUpdate
componentWillUpdate
componentDidUpdate
componentWillUnmount



https://github.com/fi3ework/blog/issues/15


# 不同版本下的优化方法
手动去优化，都是有成本的，把代码变得更复杂；大部分情况下，浏览器的性能都足够，不需要去手动优化；

React15
删除react-id
* 所有的优化都是针对多次render的问题，都是为了减少render次数；
* React15 componentWillReceiveProps多次触发（在render时会被触发,setState）


React16.3
https://juejin.im/post/5aca20c96fb9a028d700e1ce
* 丢弃: componentWillReceiveProps, componentWillUpdate, componentWillMount
* 新增: static getDerivedStateFromProps, getSnapshotBeforeUpdate
```js
class Example extends React.Component {

  state: {
    filterText: '',
  }

  static getDerivedStateFromProps(nextProps, prevState) {
    // 代替componentWillReceiveProps
    if (prevState.filterText != state.filterText)
    return {
      filterText: state.filterText
    }
  }

  getSnapshotBeforeUpdate(prevProps, prevState) {
    // 代替componentWillUpdate
  }
}
```


http://www.ayqy.net/blog/%E4%BB%8Ecomponentwillreceiveprops%E8%AF%B4%E8%B5%B7/
* componentWillReceiveProps
* getDerivedStateFromProps
* import memoize from "memoize-one";


https://www.jianshu.com/p/c41bbbc20e65
### shouldComponentUpdate
### PureComponent
自带shouldComponentUpdate props,state浅比较的组件
* immutable object
### React.memo
--> for functional component，只会对prop进行浅比较

```js
function MyComponent(props) {
  /* render using props */
}

function isEqual(prevProps, nextProps) {
  // 默认浅比较prop，也可以覆盖这个函数来自定义比较
}

export default React.memo(MyComponent, isEqual);
```


### useCallback, useMemo
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



# 工具
router, redux


# 受控组件和不受控组件
https://reactjs.org/blog/2018/06/07/you-probably-dont-need-derived-state.html#recommendation-fully-uncontrolled-component-with-a-key
* 使用key来刷新不受控组件


# 完整看一遍官方文档
