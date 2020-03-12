---
title: index
toc: true
date: 2020-03-12 00:00:00
tags:
---

生成AST之后就可以为所欲为了？不管是转换代码还是生成机器码。。。
* babel
* eslint
* 转换成小程序
* 代码格式化
* 压缩
* V8

[ast在线转换](https://astexplorer.net/)

```js
var globalA = 2;

function myFn() {
  var a = 1;
}

```

```json
// 生成的AST
{
  "type": "Program",
  "start": 0,
  "end": 51,
  "body": [
    {
      "type": "VariableDeclaration",
      "start": 0,
      "end": 16,
      "declarations": [
        {
          "type": "VariableDeclarator",
          "start": 4,
          "end": 15,
          "id": {
            "type": "Identifier",
            "start": 4,
            "end": 11,
            "name": "globalA"
          },
          "init": {
            "type": "Literal",
            "start": 14,
            "end": 15,
            "value": 2,
            "raw": "2"
          }
        }
      ],
      "kind": "var"
    },
    {
      "type": "FunctionDeclaration",
      "start": 18,
      "end": 50,
      "id": {
        "type": "Identifier",
        "start": 27,
        "end": 31,
        "name": "myFn"
      },
      "expression": false,
      "generator": false,
      "async": false,
      "params": [],
      "body": {
        "type": "BlockStatement",
        "start": 34,
        "end": 50,
        "body": [
          {
            "type": "VariableDeclaration",
            "start": 38,
            "end": 48,
            "declarations": [
              {
                "type": "VariableDeclarator",
                "start": 42,
                "end": 47,
                "id": {
                  "type": "Identifier",
                  "start": 42,
                  "end": 43,
                  "name": "a"
                },
                "init": {
                  "type": "Literal",
                  "start": 46,
                  "end": 47,
                  "value": 1,
                  "raw": "1"
                }
              }
            ],
            "kind": "var"
          }
        ]
      }
    }
  ],
  "sourceType": "module"
}
```