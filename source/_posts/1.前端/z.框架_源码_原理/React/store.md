---
title: Store
toc: true
date: 2020-03-07 00:00:03
---

# React
## useContext
可以用作一个简单版的redux来负责管理全局store；但相比`react-redux`这个库来说少了很多细节，比如内置的`thunk`,`immer.js`和很多helper函数
* [参考资料: 配合useState](https://stackoverflow.com/questions/54738681/how-to-change-context-value-while-using-react-hook-of-usecontext)
* [参考资料: 配合useReducer](https://medium.com/@seantheurgel/react-hooks-as-state-management-usecontext-useeffect-usereducer-a75472a862fe)
```js
const initialState = {
  ...,
  foreground: "#000000",
};

const reducer = (state, action) => {

  switch (action.type) {

    case 'SET_FOREGROUND': {
      return {
        ...state,
        foreground: action.foreground
      };
    }

    default:
      throw new Error();
    }
}

const GlobalContext = React.createContext(initialState);

export default { initialState, reducer, GlobalContext }
```
```html
function App() {
  const [ state, dispatch ] = useReducer(initialState, reducer);
  return (
    <GlobalContext.Provider value={{state, dispatch}}>
      <Toolbar />
    </GlobalContext.Provider>
  );
}

function Toolbar(props) {
  return (
    <div>
      <ThemedButton />
    </div>
  );
}

function ThemedButton() {
  // 使用useContext替代<Consumer>的写法
  const { state, dispatch } = useContext(GlobalContext);

  function onClick () {
    dispatch({
      type: 'SET_FOREGROUND',
      foreground: 'black'
    })
  }

  return (
    <button style={{ color: state.foreground }} onClick={onClick}>
      I am styled by theme context!
    </button>
  );
}
```


## Redux
* [redux](https://github.com/reduxjs/redux#the-gist)
* [react-redux](https://redux-toolkit.js.org/tutorials/basic-tutorial): 对redux的一层封装
  * [configureStore自带react-thunk,logger](https://redux-toolkit.js.org/api/getDefaultMiddleware)
  * [createSlice自带immer.js](https://redux-toolkit.js.org/tutorials/intermediate-tutorial)
  * [使用immer.produce包裹reducer.switch](https://dev.to/mercatante/simplify-your-redux-reducers-with-immer-3e51)

```js
import React, { useState } from 'react'
import { connect } from 'react-redux'
import { addTodo } from 'features/todos/todosSlice'

const mapDispatchToProps = { addTodo }

const AddTodo = ({ addTodo }) => {
  const [todoText, setTodoText] = useState('')

  const onChange = e => setTodoText(e.target.value)

  return (
    <div>
      <form
        onSubmit={e => {
          e.preventDefault()
          if (!todoText.trim()) return;
          addTodo(todoText)
          setTodoText('')
        }}
      >
        <input value={todoText} onChange={onChange} />
        <button type="submit">Add Todo</button>
      </form>
    </div>
  )
}

// connect是个高阶组件
export default connect(mapStateToProps, mapDispatchToProps)(AddTodo)
```

```js
// features/todos/todosSlice
import { createSlice } from '@reduxjs/toolkit'

let nextTodoId = 0

const todosSlice = createSlice({
  name: 'todos',
  initialState: [],
  reducers: {
    addTodo: {
      reducer(state, action) {
        const { id, text } = action.payload
        state.push({ id, text, completed: false })
      },
      prepare(text) {
        return { payload: { text, id: nextTodoId++ } }
      }
    },
    toggleTodo(state, action) {
      const todo = state.find(todo => todo.id === action.payload)
      if (todo) {
        todo.completed = !todo.completed
      }
    }
  }
})


// slice是语法糖，内部自动生成reducer和action
export const { addTodo, toggleTodo } = todosSlice.actions

export default todosSlice.reducer
```

```js
// createSlice返回以下对象
{
  name: "todos",
  reducer: (state, action) => newState,
  actions: {
    addTodo: (payload) => ({type: "todos/addTodo", payload}),
    toggleTodo: (payload) => ({type: "todos/toggleTodo", payload})
  },
  caseReducers: {
    addTodo: (state, action) => newState,
    toggleTodo: (state, action) => newState,
  }
}
```

### createStore
* `Provider`用于注入`this.context`，从而将`store`一层层往下传
* `connect`是一个高阶组件，内部会通过`context`获取`store`上的`state`和`dispatch`，并使用`subscribe`订阅更新【[参考资料](https://imweb.io/topic/5a1969b2a192c3b460fce226)】

```js
// 数据更新流程： dispatch --> reducer --> listener/connect --> setState
function createStore (reducer, initialState, enhancer) {
  let state = initialState
  const listeners = []
  const store = {
    getState () {
      return state
    },
    dispatch (action) {
      state = reducer(state, action) // dispatch触发执行reducer
      listeners.forEach(listener => listener()) // 触发各订阅组件更新
    },
    // connect通过subscribe订阅更新
    subscribe (listener) {
      listeners.push(listener)
    }
  }

  // 通常是applyMiddleware
  enhancer(store)

  return store;
}

// 内部会通过subscribe来订阅更新
connect(mapStateToProps, mapDispatchToProps, mergeProps)(MyComponent)
```


### middleware
【[参考资料1](https://redux.js.org/advanced/middleware)】
【[参考资料2](https://cn.redux.js.org/docs/advanced/Middleware.html)】
【[参考资料3](https://juejin.im/post/5b34acee6fb9a00e60442473)】
```js

function applyMiddleware (...middlewares) {
  return (store) => {
    const chains = middlewares.map(middleware => middleware(store))
    store.dispatch = compose(...chains)(store.dispatch)
  }
}


const store = createStore(
  todoApp,
  initialState,
  applyMiddleware(
    rafScheduler,
    timeoutScheduler,
    thunk,
    vanillaPromise,
    readyStatePromise,
    logger,
    crashReporter
  )
)
```

```js
const thunk = store => next => action =>
  typeof action === 'function'
    ? action(store.dispatch, store.getState)
    : next(action)


// this is a thunkAction
function incrementAsync () {
  return dispatch => {
    setTimeout(() => {
      dispatch(increment())
    }, 1000)
  }
}

dispatch(incrementAsync())
```

### hook
不需要再使用`connect`高阶组件来订阅更新了，无法带来小范围render的优化；
```js
import React from 'react';
import * as actions from '../actions';
import {useSelector, useDispatch} from 'react-redux';

const App = () => {
  const dispatch = useDispatch();
  const count = useSelector(store => store.count);

  return (
    <div>
      <h1>The count is {count}</h1>
      <button onClick={() => dispatch(actions.increment(count))}>+</button>
      <button onClick={() => dispatch(actions.decrement(count))}>-</button>
    </div>
  );
}

export default App;
```

### 优化
【[参考资料](https://juejin.im/post/596db2f9f265da6c4602ffc3)】
```js
connect(
  mapStateToProps: (state, ownProps?) => Object, // 只注入必要的state
  mapDispatchToProps, // 只注入必要的dispatch
  mergeProps, // 默认是Object.assign({}, ownProps, stateProps, dispatchProps)
  {
    pure = true, // 默认值，这时候connector将执行shouldComponentUpdate 并且浅对比 mergeProps 的结果，避免不必要的更新
    areStatesEqual = strictEqual,
    areOwnPropsEqual = shallowEqual,
    areStatePropsEqual = shallowEqual,
    areMergedPropsEqual = shallowEqual,
    ...extraOptions
  } = {}
)
```


## Mobx
[TODO]
通过Proxy.getter订阅组件更新，setter来触发更新



# Vue
## Vuex
### Vuex中的概念
* commit用来触发mutation
* dispatch用来触发action
* mutation只能是同步函数（比如不能使用fetch），action没限制
* 因为redux依靠reducer返回的新state来修改store.state，所以对于异步操作依赖react-thunk；而vuex是直接赋值来修改store.state的，不会有异步的问题；对于mbox来说也是一样；

#### Mutation必须是同步函数
devtool在调用每个Mutation时都会生成快照，要是Mutation里包含了异步函数，则可能会生成失败；【[参考资料](https://vuex.vuejs.org/zh/guide/mutations.html#mutation-%E5%BF%85%E9%A1%BB%E6%98%AF%E5%90%8C%E6%AD%A5%E5%87%BD%E6%95%B0)】

![](/img/Snip20200310_1.png)

```js
actions: {
  async login({ commit, state }, userId) {
    try {
      commit('setError', '');
      commit('setLoading', true);
      ...
    } catch (error) {
      commit('setError', error.message)
    } finally {
      commit('setLoading', false);
    }
  }
},
mutations: {
  setError(state, error) {
    state.error = error;
  },
  setLoading(state, loading) {
    state.loading = loading;
  }
}
```


### 三种修改store的办法
三种程度的store，灵活取舍；简单项目可以用第二种，当变得复杂时用第三种；但在创建store时设置了`{strict:true}`则只能通过mutation修改store，否则报错；
1. 激进：直接修改 `this.$store.xxx = 'xxx'`；虽然操作起来最快捷，但是这样store的修改逻辑会散落在项目各个角落，不好维护；
2. 一般：在不经过action而直接通过mutation修改store；比较简便，同时将store的修改逻辑都集中在store.js中，但是不能使用vueDevTool的[Time Travel](https://juejin.im/post/5e0cbdd6e51d4541162c9493)功能（依赖commit）；
3. 保守：同步操作直接使用mutation，异步操作在action里通过commit来触发mutation修改store；调试体验最好（Time Travel 以及 能知道都触发了哪些Mutaction），但是代码有点绕；可能有时候代码复杂了，刚好需要抽mutation这一层来作代码复用；【[参考项目](https://github.com/sitepoint-editors/vue-chatkit/blob/master/src/store/actions.js)】

```js

// 写法1：简单粗暴的修改store
this.$store.count++;


// 写法2：通过action修改
ations: {
  async increment ({state}) {
    fetch(() => {
      state.count++
    })
  }
}


// 写法3：action --> mutations
ations: {
  increment ({commit}) {
    fetch(() => {
      commit('increment')
    })
  }
}，
mutations: {
  increment (state) {
    fetch(() => {
      state.count++
    })
  }
}
```
