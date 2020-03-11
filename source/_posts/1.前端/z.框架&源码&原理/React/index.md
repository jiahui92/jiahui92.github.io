---
title: React
toc: true
date: 2020-03-07 00:00:00
---




## 脏值检查
起源于anglar1，框架定时对比state的所有值，检查出变更值，然后更新UI。而Vue和React则将该部分的工作移到了domDiff去，脏值检查变成了，脏dom检查。【[参考资料](https://www.cnblogs.com/eret9616/p/9155675.html)】


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


## Fiber调度算法
https://zhuanlan.zhihu.com/p/26027085

