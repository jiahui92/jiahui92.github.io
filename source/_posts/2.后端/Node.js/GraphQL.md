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
增删改
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

## apollo server
* typeDefs
* resolvers
  * query
  * mutation
* context
* dataSources
```js
const server = new ApolloServer({
  typeDefs, // gql schema 的 type
  resolvers, // 增删改查操作resolver
  dataSources, // 自定义数据源(给resolver使用)
});
```

### nexus
用ts代码的方式替代传统的SDL，然后再生成gql schema，并且额外支持`pub/sub`的resolver
```js
const { makeSchema } = require('@nexus/schema');
const { ApolloServer } = require('apollo-server');

// 使用 Nexus 定义类型等相关配置
const schema = makeSchema({
  // 定义了一个User和其增删改查resolver
  types: [User, UserInput, UserRole, getUserQuery, getUsersQuery, addUserMutation, updateUserMutation, deleteUserMutation],
  outputs: {
    schema: __dirname + '/schema.graphql',
    typegen: __dirname + '/generated/nexus.ts'
  }
});

const server = new ApolloServer({ schema });
```
```js
import { makeSchema, objectType, stringArg, intArg, idArg, enumType, inputObjectType, arg, mutationField, queryField } from '@nexus/schema';

// 定义用户角色枚举
const UserRole = enumType({
  name: 'UserRole',
  members: ['ADMIN', 'USER']
});

// 定义用户输入类型
const UserInput = inputObjectType({
  name: 'UserInput',
  definition(t) {
    t.string('name');
    t.int('age');
    t.field('role', { type: UserRole });
  }
});

// 定义用户类型
const User = objectType({
  name: 'User',
  definition(t) {
    t.int('id');
    t.string('name');
    t.int('age');
    t.field('role', { type: UserRole });
  }
});

// 模拟用户数据存储
let users = [];
let currentId = 1;

// 查询单个用户
const getUserQuery = queryField('getUser', {
  type: User,
  args: { id: idArg() },
  resolve: (parent, { id }) => {
    return users.find(user => user.id === id);
  }
});

// 查询所有用户
const getUsersQuery = queryField('getUsers', {
  type: [User],
  resolve: () => {
    return users;
  }
});

// 添加用户
const addUserMutation = mutationField('addUser', {
  type: User,
  args: { user: arg({ type: UserInput }) },
  resolve: (parent, { user }) => {
    const newUser = {
      id: currentId++,
      name: user.name,
      age: user.age,
      role: user.role
    };
    users.push(newUser);
    return newUser;
  }
});

// 更新用户
const updateUserMutation = mutationField('updateUser', {
  type: User,
  args: {
    id: idArg(),
    user: arg({ type: UserInput })
  },
  resolve: (parent, { id, user }) => {
    const index = users.findIndex(u => u.id === id);
    if (index!== -1) {
      users[index] = {...users[index],...user };
      return users[index];
    }
    throw new Error('User not found');
  }
});

// 删除用户
const deleteUserMutation = mutationField('deleteUser', {
  type: User,
  args: { id: idArg() },
  resolve: (parent, { id }) => {
    const index = users.findIndex(u => u.id === id);
    if (index!== -1) {
      const removedUser = users[index];
      users.splice(index, 1);
      return removedUser;
    }
    throw new Error('User not found');
  }
});

const schema = makeSchema({
  types: [User, UserInput, UserRole, getUserQuery, getUsersQuery, addUserMutation, updateUserMutation, deleteUserMutation],
  outputs: {
    schema: __dirname + '/schema.graphql',
    typegen: __dirname + '/generated/nexus.ts'
  }
});

export default schema;
```


## apollo-client
https://github.com/apollographql/apollo-client
前端使用的gql库
