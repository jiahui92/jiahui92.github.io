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

## Reducer
可以和contxt搭配起来使用，也可以单独作为一个简单的store管理

三种程度的store
* 激进：直接修改 this.$store.xxx
* 中间：通过dispatch修改
* 保守：dispatch再套一层再提供给App使用，会有更好的调试体验，但是写起来麻烦


`const [state, dispatch] = useReducer(reducer, initialState)`
* state: 用于读取store
* dispatch: 用于派发事件并传值来修改store

```jsx
import React, { useReducer, useEffect } from "react";

function Example () {
  const [state, dispatch] = useReducer(reducer, initialState);

  const search = () => {
    dispatch({
      type: "SEARCH_MOVIES_REQUEST"
    });

    axios(`xxxx`).then(res => {
      if (res.data.Response === "True") {
        dispatch({
          type: "SEARCH_MOVIES_SUCCESS",
          payload: res.data.Search
        });
      } else {
        dispatch({
          type: "SEARCH_MOVIES_FAILURE",
          error: res.data.Error
        });
      }
    });
  }

  const { movies, errorMessage, loading } = state;

  return ...;
}


// ------------------ store/reducer.js
export const initialState = {
  loading: true,
  movies: [],
  errorMessage: null
};

export const reducer = (state, action) => {
  switch (action.type) {
    case "SEARCH_MOVIES_REQUEST":
      return {
        ...state,
        loading: true,
        errorMessage: null
      };
    case "SEARCH_MOVIES_SUCCESS":
      return {
        ...state,
        loading: false,
        movies: action.payload
      };
    case "SEARCH_MOVIES_FAILURE":
      return {
        ...state,
        loading: false,
        errorMessage: action.error
      };
    default:
      return state;
  }
};

```


##  项目例子
[hooks-movie-app](https://github.com/jiahui92/hooks-movie-app)
