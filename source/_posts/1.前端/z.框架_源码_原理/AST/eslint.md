---
title: eslint
toc: true
date: 2020-03-12 00:00:02
tags:
---

[参考资料](https://www.cnblogs.com/wheatCatcher/p/11218924.html)


# 使用
## 初始化
```s
# 初始化eslint
./node_modules/.bin/eslint --init
# 全局安装的esint
eslint --init
```

```js
// .eslintrc.js
module.exports = {
  env: {
    browser: true,
    es6: true,
    node: true
  },
  globals: {
    Atomics: "readonly",
    SharedArrayBuffer: "readonly",
  },
  // 指定传给 parser 的信息，eslint使用的默认是Espree
  parserOptions: {
    ecmaVersion: 2018,
    sourceType: "module",
  },
  
  extends: [
    "eslint:recommended",
    // "plugin:vue/recommended"
    // "plugin:react/recommended"
  ],
  rules: {
    indent: ["error", 2],
  },
};
```

## 常用插件
* [eslint-plugin-vue](https://github.com/vuejs/eslint-plugin-vue)
* [eslint-plugin-react](https://github.com/yannickcr/eslint-plugin-react)
* [eslint-config-airbnb](https://www.npmjs.com/package/eslint-config-airbnb)
* [eslint-config-airbnb-base](https://www.npmjs.com/package/eslint-config-airbnb-base)
* [eslint-plugin-compat](https://github.com/amilajack/eslint-plugin-compat)
* [rule规则查询](https://eslint.org/docs/rules/indent)

## 部分关闭eslint检测
* 使用.eslintignore文件
* 在代码中用注释“圈住”不需要检查的部分
```js
/* eslint-disable */
  alert('foo');
/* eslint-enable */
```

## autofix
* eslint --fix ./
* eslint --ext .js,.vue --fix ./
* [保存代码时自动修复](http://obkoro1.com/web_accumulate/accumulate/tool/Eslint%E8%87%AA%E5%8A%A8%E4%BF%AE%E5%A4%8D%E6%A0%BC%E5%BC%8F%E9%94%99%E8%AF%AF.html)

## 配合git commit
* 必要时，可以使用`git commit --no-verify`绕过验证直接提交 【[参考资料](https://www.npmjs.com/package/pre-commit)】
* 假如不生效，可以排查一下`.git/hooks/`目录里是否有`pre-commit`文件 【[参考资料](https://stackoverflow.com/questions/42864386/npm-pre-commit-not-working)】
```json
// npm i -D pre-commit

// package.json
{
  ...,
  "pre-commit": ["lint"],
  "script": {
    "lint": "eslint ./"
  }
}
```



## 其它问题
* [vscode不生效](http://www.jeepxie.net/article/1288801.html)
  * 安装vscode eslint 插件
  * 在全局或者项目中安装eslint
* [vue检测不生效](https://www.jianshu.com/p/0d21a1bcd92e)


# 原理
* 使用esprima生成ast
* 开发rule插件来拓展各种检查规则



## 插件开发
【[参考资料](https://juejin.im/post/5d91be23f265da5ba532a07e)】 【[官方文档](https://eslint.org/docs/developer-guide/working-with-rules)】
* 和babel一样，利用ast钩子函数
* docs是出错提示相关配置
* 另外可以留意下autofix的实现（应该也是类似babel吧，修改ast树，然后再generate）
```js
module.exports = {
  meta: {
    docs: {
      description: "no console.time()",
      category: "Fill me in",
      recommended: false
    },
    // 是否支持autofix；如果可以的话，需要补充fix函数
    fixable: null,
    // console报错信息描述
    messages: {
      avoidMethod: "console method '{{name}}' is forbidden."
    }
  },

  create: function(context) {
    return {
      // 键名为ast中选择器名
      "CallExpression MemberExpression": node => {
        // 如果在ast中满足以下条件，就用 context.report() 进行对外警告
        if (node.property.name === "time" && node.object.name === "console") {
          context.report({
            node,
            messageId: "avoidMethod",
            data: {
              name: "time"
            }
          });
        }
      }
    };
  }
};

// autofix
context.report({
  node: node,
  message: "Missing semicolon",
  fix (fixer) {
    return fixer.insertTextAfter(node, ";");
  }
});
```

