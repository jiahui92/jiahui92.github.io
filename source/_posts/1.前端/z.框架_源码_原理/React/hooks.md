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
用于替代原来的`componentDidMount`, `componentDidUpdate`, `componentWillUnMount`生命周期钩子函数，但是像`componentWillMount`等其它生命周期就不存在了（可以尝试写在useEffect外面，再搭配计数器）；

```jsx
function Example () {

  // 相当于 componentDidMount
  useEffect(() => {
    console.log(`You clicked ${count} times`);
  }, []);

  // 相当于 componentDidMount + 监听count
  useEffect(() => {
    console.log(`You clicked ${count} times`);
  }, [count]);

  // 相当于 componentDidMount + componentDidUpdate/监听所有state
  useEffect(() => {
    console.log(`You clicked ${count} times`);
  });


  //相当于 componentWillUnMount
  useEffect(() => {
    return () => {
      console.log('componentWillUnMount');
    }
  }, []);

}
```


## useReducer
* userReducer用在setState逻辑比较复杂的情况，特别是context+useReducer的结合用作全局store【[参考资料](https://css-tricks.com/getting-to-know-the-usereducer-react-hook/)】
* 注意下面的三个文件`reducer.js, action.js, types.js`
```jsx
// ------------------ app.js
import React, { useReducer, useEffect } from "react";

function Example () {
  const [state, dispatch] = useReducer(reducer, initialState);
  // const [state, setXXX] = useState({
  //   loading: true,
  //   movies: [],
  //   errorMessage: null
  // });
  

  const search = () => {
    // dispatch: 用于派发action事件并传值来修改store
    dispatch({
      type: "SEARCH_MOVIES_REQUEST"
    });
    // setXXX({
    //   loading: true,
    //   movies: [],
    //   errorMessage: null
    // });

    axios(`xxxx`).then(res => {
      if (res.data.Response === "True") {
        dispatch({
          type: "SEARCH_MOVIES_SUCCESS",
          movies: res.data.Search
        });
        // setXXX({
        //   loading: false,
        //   movies: res.data.Search,
        //   errorMessage: null
        // });
      } else {
        dispatch({
          type: "SEARCH_MOVIES_FAILURE",
          error: res.data.Error
        });
        // setXXX({
        //   loading: false,
        //   movies: [],
        //   errorMessage: res.data.Error
        // });
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

// reducer负责返回一个新的state
export const reducer = (state, action) => {
  switch (action.type) {
    case "SEARCH_MOVIES_REQUEST":
      return {
        ...state, // immutable
        loading: true,
        errorMessage: null
      };
    case "SEARCH_MOVIES_SUCCESS":
      return {
        ...state,
        loading: false, // 通常对应action的state默认值都写在reducer中，而不是通过dispatch传过来
        movies: action.movies // state.movies必须从接口获取，所以只能依靠dispatch传来
      };
    case "SEARCH_MOVIES_FAILURE":
      return {
        ...state,
        loading: false,
        errorMessage: action.error
      };
    default:
      throw new Error();
  }
};


// ------------------ store/action.js
// 当action太多时，通常会抽一个文件来管理
export const searchMoviesSuccess = (movies) => {
  return {
    movies,
    type: 'SEARCH_MOVIES_SUCCESS',
  }
}
// app.js中调用更改为 ==>  
//    dispatch(searchMoviesSuccess(data))



// ------------------ store/types.js
// 当项目复杂时 app.js 、 action.js 、 reducer.js 中可能会出现较多重复的action事件名称，这时候也可以抽出来
export const SEARCH_MOVIES_SUCCESS = 'SEARCH_MOVIES_SUCCESS'
// 调用更改为
import * as Types from 'store/types.js'
Types.SEARCH_MOVIES_SUCCESS
```

### immutable
reducer.js为什么要用 `"{...state}"`而不是直接在state上修改
* `{...state}`每次都会返回一个新的state对象；在一些复杂的情况下，一直使用同一个state对象，可能会因为引用的问题，不小心修改state值而不知道，所以这里每次都会返回一个新的state对象； 【[参考资料](https://blog.logrocket.com/immutability-in-react-ebe55253a1cc/)】
* 当项目比较复杂时，最好是使用[immutable.js](https://juejin.im/post/5ac437436fb9a028c97a437c)；里面包含了一些特别优化：
  * 比如避免了类似`{...state}`的浅层拷贝，要是state里包含对象的话，其实也可能会出现上述所说的引用问题；
  * 同时也避免了用`deepClone`的拷贝性能浪费和深拷贝导致的全组件树都重新render的情况；


### 异步action
为什么不将ajax.search放在reducer.js里？这样还少几个action
* 首先官方建议reducer是一个纯函数（简单的处理state，然后输出一个新的state）
* 另外reducer不支持异步，异步返回的state值会取不到
* 最后为了有良好的调试体验；【[参考资料](https://cuyu.github.io/javascript/2017/04/25/Time-travel-in-Redux)】
* 对于异步的action，可以使用redux-thunk来写，本质是改写了redux的dispatch，让其支持async；【[参考资料1](https://github.com/riskers/blog/issues/32)】【[参考资料2](https://github.com/sunyongjian/blog/issues/36)】
* [TODO]: redux-saga, rxjs, mbox
```js
function actionCreator() {
  return async (dispatch) => {
    dispatch({
      type: 'LOADING'
    })

    try{
      const response = await fetch(`https://example.com/`)
      let data = await response.json()

      dispatch({
        type: 'SUCCESS',
        payload: data
      })
    }catch(error) {
      dispatch({
        type: 'FAILURE',
        error: error
      })
    }
  };
}
```


##  项目例子
[hooks-movie-app](https://github.com/samie820/hooks-movie-app)
