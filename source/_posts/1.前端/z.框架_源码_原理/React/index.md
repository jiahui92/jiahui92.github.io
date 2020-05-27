---
title: index
toc: true
date: 2020-03-07 00:00:00
---


# React 0.14
## 脏值检查
起源于anglar1，框架定时对比state的所有值，检查出变更值，然后更新UI。而Vue和React则将该部分的工作移到了domDiff去，脏值检查变成了，脏dom检查。【[参考资料](https://www.cnblogs.com/eret9616/p/9155675.html)】


## setState
注意里面利用的`Promise`来优化renderComponent的渲染次数，本来还以为用的是throttle；【[参考资料](https://zhuanlan.zhihu.com/p/44537887)】

```js
const queue = []; // setState的队列
const renderQueue = [];

function setState (stateChange, component) {
  if (queue.length === 0) {
    // 异步执行
    Promise.resolve().then(flush);
  }

  queue.push({ stateChange, component });

  if (!renderQueue.some(item => item === component)) {
    renderQueue.push( component );
  }
}

function flush () {
  let item;
  while(item = queue.shift()) {
    const { stateChange, component } = item;
    // 更新组件的state
    Object.assign(component.state, stateChange);
  }

  // 遍历渲染组件
  while( component = renderQueue.shift() ) {
    renderComponent(component);
  }
}
```

```js
class App extends Component {
  constructor() {
    super();
    this.state = { num: 0 }
  }

  componentDidMount () {
    this.setState({ num: this.state.num + 1 });
    this.setState({ num: this.state.num + 2 });
    this.setState({ num: this.state.num + 3 });
  }

  render () {
    console.log(this.state.num);
    return (
      ...
    );
  }
}

// 0
// 3
```


## 合成事件 SyntheticEvent
【[官方文档](http://react.html.cn/docs/events.html)】【[参考资料](https://juejin.im/post/59db6e7af265da431f4a02ef)】
* 在document上委托代理全局dom事件
* 配合`event.target`和`event.type`找到真正的触发源和触发事件类型
* 将真正的事件映射为合成事件，比如dom的onchange映射为onChange
* event.stopPropagation只能阻止react的事件冒泡，不能阻止真正dom事件冒泡（可以使用ReactDOM.findDOM获取真正的dom，然后addEventListener来阻止dom事件冒泡）
* event.nativeEvent.stopImmediatePropagation 常用于阻止document的事件执行




# 不/受控组件
[参考资料](http://www.ayqy.net/blog/%E4%BB%8Ecomponentwillreceiveprops%E8%AF%B4%E8%B5%B7/)
* 受控组件：input值是被value和onChange控制的
* 不受控组件：input值是dom自己管理的，需要通过ref来获取当前值
* 全不受控组件：例如MyInput组件只提供defaultVal而不提供val；初始化后，内部的state就不可改了，可以使用key来刷新全不受控组件【[参考资料](https://reactjs.org/blog/2018/06/07/you-probably-dont-need-derived-state.html#recommendation-fully-uncontrolled-component-with-a-key)】



## redux的依赖收集
通过connect来注入store，同时收集需要更新的组件；vue和mbox则是通过store.state.getter来收集需要更新的组件；
```js
import { connect } from 'react-redux'

const VisibleTodoList = connect(
    [mapStateToProps], //参数1将 store 中的数据作为 props 绑定到组件上 

    [mapDispatchToProps], //参数2将 action 作为 props 绑定到组件上。

    [mergeProps], //参数3用于自定义merge流程，将stateProps 和 dispatchProps merge 到parentProps之后赋给组件。通常情况下，你可以不传这个参数，connect会使用 Object.assign。

    [options] //如果指定这个参数，可以定制 connector 的行为。一般不用。
)(TodoList)

export default VisibleTodoList
```



# React 15
* 将react-dom抽离出react库：从多平台考虑，可以减少react-native的依赖，因为native端不会用到dom的逻辑
* 移除data-reactid：避免了使用自动生成的id来缓存导致的出错，但同时需要使用`shouldComponentUpdate`减少组件的更新频率
  * [更多优化技巧](/wiki/1.前端/z.框架_源码_原理/React/optimize.md)
```js
shouldComponentUpdate(nextProps, nextState) {
  // 注意对象和数组不能直接用引用地址判断
  return nextState.someVal !== this.state.someVal;
}
```



# React 16
* import PropTypes from 'prop-types';
* React Fragment
* Fiber
* v16.3 生命周期调整
* v16.8 中引入 hooks

## Fiber调度算法
[源码](https://zhuanlan.zhihu.com/p/98295862)

React分三层
* `Virtual DOM`
* Reconciler: 负责调用组件生命周期方法，进行`DomDiff`等
* Renderer: 根据不同的平台，渲染出(`DomPatch`)相应的页面，比较常见的是 ReactDOM 和 ReactNative


在React16中推出，主要解决React15中`Stack Reconciler`占用时间过长导致掉帧的问题；结合`window.requestIdleCallback`和每一个节点的domDiff后会检查并执行其它优先级更高的任务，确保不阻塞动画和用户交互事件；【[参考资料](https://segmentfault.com/a/1190000018250127?utm_source=tag-newest)】
* synchronous: 与之前的Stack Reconciler操作一样，同步执行
* task: 在nexttick之前执行
* [animation](https://react-cn.github.io/react/docs/animation.html): 下一帧之前执行
* high: 在不久的将来立即执行
* low: 稍微延迟执行也没关系
* offscreen: 下一次render时或scroll时才执行

```js
const fiber = { // 类似vue的组件树
  stateNode, // 节点实例
  child, // 子节点
  sibling, // 兄弟节点
  return, // 父节点
}
```


## 生命周期调整
为了react17的`Fiber Async Rendering` 可打断的生命周期铺路，一旦被打断，这些被废弃的生命周期都会被多次重新执行；一般情况下，尽量少使用新的api【[参考资料1](https://juejin.im/post/5aca20c96fb9a028d700e1ce)】【[参考资料2](https://www.html.cn/qa/react/14367.html)】
* 丢弃: componentWillMount, componentWillReceiveProps, componentWillUpdate
* 新增: static getDerivedStateFromProps, getSnapshotBeforeUpdate
```js
class Example extends React.Component {

  state: {
    filterText: '',
  }

  static getDerivedStateFromProps(nextProps, prevState) {
    // static中不能使用this，避免了this.setState的副作用
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


### 生命周期执行顺序
init
* constructor
* componentWillMount
* render
* componentDidMount
* componentWillUnmount

rerender
* componentWillReceiveProps, getDerivedStateFromProps
* shouldComponentUpdate
* componentWillUpdate
* render
* getSnapshotBeforeUpdate
* componentDidUpdate
* componentWillUnmount



## hooks
理解hooks的原理

### 不能在if内使用useState
```js
let ref = {};
let index = 0;
const stateArr = [];

function useState (val) {
  stateArr[index] = val;
  return [ stateArr[index], setState.bind(this, index++) ];
}

function setState (index, val) {
  stateArr[index] = val;
  render();
}

function useRef () {
  return ref;
}
```


### useCallback的闭包坑
[参考资料](https://zhuanlan.zhihu.com/p/56975681)
```js
function Form() {
  const [text, updateText] = useState('');

  const handleSubmit = useCallback(() => {
    console.log(text);
  // }, []); // 坑一：这样的话，由于闭包的原因，text读取的是旧值
  }, [text]); // 坑二：每次text变化时handleSubmit的值都会变，导致重新渲染ExpensiveTree组件

  return (
    <>
      <input value={text} onChange={(e) => updateText(e.target.value)} />
      <!-- 很重的组件，不优化会死的那种 -->
      <ExpensiveTree onSubmit={handleSubmit} />
    </>
  );
}
```
```js
// 使用useRef和useLayoutEffect解决"坑二"
// 或者把值丢在Form外面也是可以的吧？
// 或者把state和handleSubmit抽离到reducer
function Form() {
  const [text, updateText] = useState('');
  const textRef = useRef();

  useLayoutEffect(() => {
    textRef.current = text; // 将 text 写入到 ref
  });

  const handleSubmit = useCallback(() => {
    const currentText = textRef.current; // 从 ref 中读取 text
    alert(currentText);
  }, []); // handleSubmit 只会依赖 textRef 的变化。不会在 text 改变时更新

  return (
    <>
      <input value={text} onChange={e => updateText(e.target.value)} />
      <ExpensiveTree onSubmit={handleSubmit} />
    </>
  );
}
```

## ErrorBoundary
```html
<ErrorBoundary>
  <MyWidget />
</ErrorBoundary>
```
```js
class ErrorBoundary extends React.Component {
  constructor(props) {
    super(props);
    this.state = { hasError: false };
  }

  componentDidCatch(error, info) {
    // Display fallback UI
    this.setState({ hasError: true });
    // You can also log the error to an error reporting service
    logErrorToMyService(error, info);
  }

  render() {
    if (this.state.hasError) {
      // You can render any custom fallback UI
      return <h1>Something went wrong.</h1>;
    }
    return this.props.children;
  }
}
```
