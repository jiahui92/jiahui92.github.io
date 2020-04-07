---
title: index
toc: true
date: 2020-03-07 00:00:00
---




# 脏值检查
起源于anglar1，框架定时对比state的所有值，检查出变更值，然后更新UI。而Vue和React则将该部分的工作移到了domDiff去，脏值检查变成了，脏dom检查。【[参考资料](https://www.cnblogs.com/eret9616/p/9155675.html)】


# setState
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

function renderComponent () {
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


# redux的依赖收集
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


# Fiber调度算法
https://zhuanlan.zhihu.com/p/26027085


# 合成事件 SyntheticEvent
【[官方文档](http://react.html.cn/docs/events.html)】【[参考资料](https://juejin.im/post/59db6e7af265da431f4a02ef)】
* 在document上委托代理全局dom事件
* 配合`event.target`和`event.type`找到真正的触发源和触发事件类型
* 将真正的事件映射为合成事件，比如dom的onchange映射为onChange
* event.stopPropagation只能阻止react的事件冒泡，不能阻止真正dom事件冒泡（可以使用ReactDOM.findDOM获取真正的dom，然后addEventListener来阻止dom事件冒泡）
* event.nativeEvent.stopImmediatePropagation 常用于阻止document的事件执行


