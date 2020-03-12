---
title: eslint
toc: true
date: 2020-03-12 00:00:02
tags:
---

[TODO]

* 常用配置: extend
* [常用插件](https://github.com/amilajack/eslint-plugin-compat)
* 规则列表
* 自动修复代码错误: `eslint --fix ./`




## 原理
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
    fixable: null, // 是否支持autofix；如果可以的话，需要补充fix函数
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

