---
title: Store
toc: true
date: 2020-03-07 00:00:05
---

## useReducer
可以和contxt搭配起来使用，也可以单独作为一个简单的store管理；

注意下面的三个文件`reducer.js, action.js, types.js`
```jsx
// ------------------ app.js
import React, { useReducer, useEffect } from "react";

function Example () {
  const [state, dispatch] = useReducer(reducer, initialState);

  const search = () => {
    // dispatch: 用于派发action事件并传值来修改store
    dispatch({
      type: "SEARCH_MOVIES_REQUEST"
    });

    axios(`xxxx`).then(res => {
      if (res.data.Response === "True") {
        dispatch({
          type: "SEARCH_MOVIES_SUCCESS",
          movies: res.data.Search
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
      return state;
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



### 与useContext的区别
useContext一般用在全局和深层嵌套，useReducer用在局部组件中，要是项目比较简单，直接用useReducer也可以；
> TODO: 复杂的我直接用useReducer当作全局state为啥不行？只要名字区分就好了吧？


### 异步action
为什么不将ajax.search放在reducer.js里？这样还少几个action

TODO: 感觉也可以吧？貌似又和良好的调试体验有关【[参考资料](https://cuyu.github.io/javascript/2017/04/25/Time-travel-in-Redux)】




## Vuex
### Vuex中的概念
* commit用来触发mutation
* dispatch用来触发action
* mutation只能是同步函数（比如不能使用fetch），action没限制

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
2. 一般：在action里修改store；比较简便，同时将store的修改逻辑都集中在store.js中，但是调试体验不好，不能使用vueDevTool的[Time Travel](https://juejin.im/post/5e0cbdd6e51d4541162c9493)功能；
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
