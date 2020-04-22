---
title: Store
toc: true
date: 2020-03-07 00:00:03
---


## useContext
可以用作一个简单版的redux来负责管理全局store；
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
