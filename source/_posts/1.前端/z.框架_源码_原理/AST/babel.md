---
title: babel
toc: true
date: 2020-03-12 00:00:01
tags:
---

* 常用插件
* 原理
* 插件开发 & loader

## 常用插件
【[参考资料](https://www.jianshu.com/p/0dc3bddb6da8)】
### babel-preset-env
* `modules`：将import转为umd等模式，通常为false，交给webpack做，否则编译成require后，会影响webpack的tree-shaking
* `useBuiltIns`：类似之前的babel-polyfill，但会按需引入
  * entry: 表示在入口引入这些库；按照`.browserslist`来引入；
  * usage: 表示在使用的地方引入对应要兼容的api库；按照`.browserslist`来引入，且只引入使用过的api兼容库；
  * false: 表示不引入兼容库；
* `targets.browserslist`：浏览器兼容性，最好是写在`.browserslist`文件，这样可以和postcss共用（详细看[browserslist](/wiki/1.前端/JavaScript/Webpack/browerslist)）

```json
{
  "presets": [
      ["@babel/preset-env", {
        "modules": false,
        "useBuiltIns": "usage"
      }], "@babel/preset-typescript"
  ]
}
```


### babel-preset-stage
* Stage 0 - 稻草人: 只是一个想法，经过 TC39 成员提出即可。
* Stage 1 - 提案: 初步尝试。
* Stage 2 - 初稿: 完成初步规范。
* Stage 3 - 候选: 完成规范和浏览器初步实现。
* Stage 4 - 完成: 将被添加到下一年度发布。

### 其他
babel-preset-react


## 原理
【[参考资料](https://github.com/jamiebuilds/babel-handbook/blob/master/translations/zh-Hans/plugin-handbook.md)】
* 解析
	* 词法分析 --> tokens流
	* 语法分析 --> AST
* 转换
* 生成

### 词法分析 tokens流
```js
if (1 > 0) {
  alert('if 1 > 0');
}


[
  {type: "whitespace", value: "\n"},
  {type: "identifier", value: "if"},
  {type: "whitespace", value: " "},
  {type: "parens", value: "("},
  {type: "number", value: "1"},
  {type: "whitespace", value: " "},
  {type: "operator", value: ">"},
  {type: "whitespace", value: " "},
  {type: "number", value: "0"},
  {type: "parens", value: ")"},
  {type: "whitespace", value: " "},
  {type: "brace", value: "{"},
  {type: "whitespace", value: "\n"},
  {type: "identifier", value: "alert"},
  {type: "parens", value: "("},
  {type: "string", value: "'aa'"},
  {type: "parens", value: ")"},
  {type: "sep", value: ";"},
  {type: "whitespace", value: "\n"},
  {type: "brace", value: "}"},
  {type: "whitespace", value: "\n"}
]
```

### 语法分析 AST
#### baseNodeProp
```js
// ast Node 节点基本都会有的字段， 基础字段
{
  type: ...,
  start: 0,
  end: 38,
  loc: {
    start: {
      line: 1,
      column: 0
    },
    end: {
      line: 3,
      column: 1
    }
  },
  ...
}
```

#### NodeType
* FunctionDeclaration: 函数定义
* Identifier: 变量名称
* BinaryExpression: 二元表达式
```js
function square(n) {
  return n * n;
}


{
  type: "FunctionDeclaration",
  id: {
    type: "Identifier",
    name: "square"
  },
  params: [{
    type: "Identifier",
    name: "n"
  }],
  body: {
    type: "BlockStatement",
    body: [{
      type: "ReturnStatement",
      argument: {
        type: "BinaryExpression",
        operator: "*",
        left: {
          type: "Identifier",
          name: "n"
        },
        right: {
          type: "Identifier",
          name: "n"
        }
      }
    }]
  }
}
```

### 转换
转换步骤接收 AST 并对其进行遍历，在此过程中对节点进行添加、更新及移除等操作。 这是 Babel 或是其他编译器中最复杂的过程，同时也是插件将要介入工作的部分。

#### 遍历
* 添加修改节点
* 提前退出节点
* enter, exit
* 操作path而非node本身

```js
// 将变量名n转成x

const updateParamNameVisitor = {
  Identifier(path) {
    if (path.node.name === this.paramName) {
      path.node.name = "x";
    }
  }
};

const MyVisitor = {
  FunctionDeclaration(path) {
    const param = path.node.params[0];
    const paramName = param.name;
    param.name = "x";

    path.traverse(updateParamNameVisitor, { paramName });
  }
};

path.traverse(MyVisitor);
```


### 生成
代码生成步骤把最终（经过一系列转换之后）的 AST 转换成字符串形式的代码，同时还会创建源码映射（sourcemaps）。



## babel依赖库
![](/img/Snip20200312_14.png)

### babylon
根据code生成ast, forked from acorn
```js
babylon.parse(code, {
  sourceType: "module",
  plugin: ["jsx"]
})
```

### babel-traverse
遍历
```js
const ast = babylon.parse(code);

traverse(ast, {
  enter(path) {
    if (
      path.node.type === "Identifier" &&
      path.node.name === "n"
    ) {
      path.node.name = "x";
    }
  }
});
```

### babel-types
提供各种封装好的NodeType，以及判断工具
```js
traverse(ast, {
  enter(path) {
    if (t.isIdentifier(path.node, { name: "n" })) {
      path.node.name = "x";
    }
  }
});
```


### babel-generator
根据ast生成代码和sourcemap
```js
const ast = babylon.parse(code);
generate(ast, {}, code);
// {
//   code: "...", // 编译后的代码
//   map: "..." // sourcemap
// }
```


### babel-template
使用代码字符串模版生成ast
```js
import template from "babel-template";
import generate from "babel-generator";
import * as t from "babel-types";

const buildRequire = template(`
  var IMPORT_NAME = require(SOURCE);
`);

const ast = buildRequire({
  IMPORT_NAME: t.identifier("myModule"),
  SOURCE: t.stringLiteral("my-module")
});

console.log(generate(ast).code);
```



## 插件开发
![](/img/Snip20200312_15.png)
```js
export default function(babel, state) {
  const t = babel.types // babel-types
  const opts = state.opts // 插件选项
  return {
    
    pre() { this.cache = new Map() }
	
    visitor: {
      BinaryExpression(path) {
        if (path.node.operator !== "===") {
            return;
        }
        path.node.left = t.identifier("sebmck");
        path.node.right = t.identifier("dork");
      }
    }
    
    post() { console.log(this.cache) }	

  };
};
```

### 钩子函数
* pre 可以在这里建立cache Map
* visitor
* post
* inherits 引入babel依赖／拓展

### path
* 类型判断 isXXX
* 遍历 traverse
* 查找父节点 find, findParent
* 查找同级节点 inList, getSibling
* 停止遍历 skip, stop
* 替换节点 replaceWith, replaceWithMultiple
* 插入节点 insertAfter
* 插入到容器 pushContainer
* 删除节点  remove
* 作用域  scope.hasBinding

### 插件实例
https://github.com/liangklfangl/astexample

