---
title: 高阶组件
toc: true
date: 2020-03-07 00:00:01
---


* Mixin: ES6 class 版的 React 不支持mixin API，如果要使用类似功能可以用ES6 extend或者下面的HOC或者后续介绍的react hooks；最终的目的都是为了复用代码；

* high-order component, HOC, 高阶组件: 一种复用组件间逻辑的组件（其实不是组件，而是函数）【[参考资料](https://reactjs.org/docs/higher-order-components.html)】
```jsx
const EnhancedComponent = higherOrderComponent(WrappedComponent)



function higherOrderComponent (WrappedComponent) {

  return class extends React.Component {
    constructor (props) {
      super(props);
      this.state = {
        data: selectData(DataSource, props)
      };
    }

    onChange = () => {
      ...
    }
    ...
    render () {
      return <WrappedComponent enhanceData={this.state.data} enchancedMethod={this.onChange} {...this.props} />
    }
  }

}
```
