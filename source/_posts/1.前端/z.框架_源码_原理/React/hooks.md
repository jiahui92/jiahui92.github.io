---
title: Hooks
toc: true
date: 2020-03-07 00:00:02
---

## Hooks
【[参考资料](https://reactjs.org/docs/hooks-overview.html)】
* Functional Programming
* [State Hooks](https://reactjs.org/docs/hooks-state.html)
* [Effect Hooks](https://reactjs.org/docs/hooks-effect.html)
* Your Own Hooks
  * higer-order component
* Other Hooks
* [Rules of Hooks](https://reactjs.org/docs/hooks-rules.html): eslint-plugin-react-hooks
* API
  * useState
  * useEffect
  * useContext
  * useReducer
  * useCallback
  * userMemo
  * useRef
  * useImperativeHandle
  * useLayoutEffect
  * useDebugValue

## State Hooks
```jsx
class Example extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      count: 0
    };
  }

  render () {
    const {count} = this.state;
    return (
      <button value={count} onClick={() => this.setState({ count: count++ })} />
    )
  }
}
```

```jsx
import React, { useState } from 'react';

function Example() {
  const [count, setCount] = useState(0);

  return (
    <button value={count} onClick={() => setCount(count + 1)} />
  );
}

// 关联较大的多state写法，避免调用一堆setWidth, setHeight...
const [state, setState] = useState({
  width: 100,
  height: 100,
  left: 0,
  top: 0
});

```





## Effect Hooks
用于替代原来的生命周期钩子函数

```jsx
function Example () {

  // 相当于 componentDidMount, componentDidUpdate
  useEffect(() => {
    document.title = `You clicked ${count} times`;
  });

  // 监听 count
  useEffect(() => {
    document.title = `You clicked ${count} times`;
  }, [count]);

  // 相当于 componentWillMount, componentWillUnMount
  useEffect(() => {
    document.title = `You clicked ${count} times`;
  }, []);

}
```


##  项目例子
[hooks-movie-app](https://github.com/samie820/hooks-movie-app)
