title: immutable
toc: true
date: 2020-03-07 00:00:06
---


PureComponent浅比较在判断Object和Array等引用类型时会出错
* 在state结构不复杂的项目中：使用`Object.assign`或`deepClone`生成一个新的Object
* 在state结构很复杂的项目中
  * [immutable.js](https://github.com/immutable-js/immutable-js)；【[原理](https://github.com/camsong/blog/issues/3)】【[大型复杂项目中的使用：redux,ajax等](https://juejin.im/post/5948985ea0bb9f006bed7472)】
  * [immer.js](https://immerjs.github.io/immer/docs/example-setstate): 侵入最小，并且可以freeze对象，避免直接修改【[参考资料](https://juejin.im/post/5e83e532f265da47e02a6d5a)】


# immutable.js
```js
import { fromJS } from 'immutable';

const data = {
  val: 1,
  desc: {
    text: 'a',
  },
  content: {
    title: 'ha'
  }
}

// 将js对象转化为immutable对象
const a = fromJS(data);

// 每次赋值操作都会返回一个新的对象
const b = a.set('val', 2);
console.log(a.get('val')); // 1
console.log(b.get('val')); // 2

// 使用setIn修改a.desc.text
const c = a.setIn(['desc', 'text'], 'b');
console.log(a.get('desc') === c.get('desc')); // false
console.log(a.get('content') === c.get('content')); // true


// 转回js对象
const aa = toJS(a); 
const cc = toJS(c);
console.log(aa.content === cc.content); // false

```

```js
import { Map } from 'immutable';
import { cloneDeep } from 'lodash';


getInitialState() {
  return {
    // data: { times: 0 }
    data: Map({ times: 0 }),
  }
},
handleAdd() {
  // const data = cloneDeep(this.state.data);
  // data.times++;
  // this.setState({ data });

  this.setState({
    data: this.state.data.update('times', v => v + 1)
  });

  // 简写
  this.setState(({data}) => ({
    data: data.update('times', v => v + 1)
  }));
}
```

```js
import {is} from 'immutable';

shouldComponentUpdate(nextProps, nextState) {
  const thisProps = this.props || {};
  const thisState = this.state || {};
  nextState = nextState || {};
  nextProps = nextProps || {};

  if (Object.keys(thisProps).length !== Object.keys(nextProps).length ||
    Object.keys(thisState).length !== Object.keys(nextState).length) {
    return true;
  }

  for (const key in nextProps) {
    if (!is(thisProps[key], nextProps[key])) {
      return true;
    }
  }

  for (const key in nextState) {
    if (!is(thisState[key], nextState[key])) {
      return true;
    }
  }
  return false;
}
```


# immer.js
[TODO]原理

```js
import produce from 'immer';


// this.setState({
//   user: {
//     ...this.state.user,
//     age: this.state.user.age + 1
//   }
// })
// this.setState(prevState => ({
//   user: {
//     ...prevState.user,
//     age: prevState.user.age + 1
//   }
// }))


this.setState(
  produce(draft => {
    draft.user.age += 1
  })
)

this.state.draft.user.age++; // error Object.freeze
```
