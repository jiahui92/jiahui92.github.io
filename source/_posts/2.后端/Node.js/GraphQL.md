---
title: GraphQL
toc: true
date: 2020-03-02 00:00:03
tags:
---

【[参考资料](https://juejin.im/post/5d9eef9151882520233f5b8c)】

## query
用于获取信息
```js
query {
  getBox {
    width
    height
    color
  }
}

{
  "data": {
    "getBox": {
      "width": 100,
      "height": 200,
      "color": "white"
    }
  }
}
```

## mutation
用于修改信息
```js
mutation {
  setWidth(width: 108) {
    width
    height
    color
  }
}

{
  "data": {
    "setWidth": {
      "width": 108,
      "height": 200,
      "color": "white"
    }
  }
}
```


## apollo-client
https://github.com/apollographql/apollo-client

核心是内置了cache逻辑
