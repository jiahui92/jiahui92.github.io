---
title: complier
toc: true
date: 2020-03-12 00:00:01
tags:
---

[参考资料](https://www.npmjs.com/package/vue-template-compiler)

[源码](https://github.com/vuejs/vue/blob/dev/packages/vue-template-compiler/build.js)

createCompilerCreator
* parse: (template) => ast
  * parseHTML
    * processIf
    * processFor
* genNode
  * genElement
    * genStatic
      * v-pre
    * genFor
    * genIf
    * genChildren
    * genSlot
  * genComment
  * genText


## AST
```js
const compiler = require('vue-template-compiler')

compiler.compile(template, [options])

{
  ast: ?ASTElement, // parsed template elements to AST
  render: string, // main render function code
  staticRenderFns: Array<string>, // render code for static sub trees, if any
  errors: Array<string> // template syntax errors, if any
}


compiler.compile('<div v-test></div>', {
  directives: {
    test (node, directiveMeta) {
      // transform node based on directiveMeta
    }
  }
})
```




### parseHTML
```js

// 实现
function parseHtml (html, options) {
  // 具体实现都是用正则去做匹配
  while (html) {
    if (tagStartRegExp.test(html)) {
      // 处理开始标签 '<div xxxx>'
      options.start(...);
    } else if (tagEndRegExp.test(html)) {
      // 处理结束标签 '</div>'
      options.end(...);
    } else {
      // 处理标签中间的文案
      options.chars(...);
    }

    // len是上面已经处理的字符串长度
    html = html.substring(index + len);
  }
}



// 模拟栈，用于处理嵌套的标签
const stack = [];

// 使用
parseHTML(html, {
  start (tag, attrs) {
    var element = {
      type: 1,
      tag,
      attrsList: attrs,
      parent: currentParent,
      children: []
    };

    processFor(element);
    processIf(element);

    currentParent = element;
    stack.push(element);
  },

  end () {
    stack.pop();
    currentParent = stack[stack.length - 1];
  },

  // 夹在标签中间的text内容
  chars (text) {
    var children = currentParent.children;

    const expression = parseText(text, ); // 处理text中包含变量的情况{{text}} => _s("text")
    children.push({
      type: 2,
      expression,
      text
    });
  }
})


functin processFor (el) {
  // <div v-for="(item, index) in arr"></div>
  extend(el, {
    for: 'arr',
    alias: '(item, index)',
    iterator1: 'item',
    iterator2: 'index',
  })
}
```


## createElement
[参考资料](https://github.com/jin5354/mini-vue/blob/master/src/Compile.ts)
```html
<div class="filter-line">
  <label>订阅新小组</label>
  <ElSelect v-bind="selectProps" :value="tabs" @change="onFilterChange('tabs', $event)" placeholder="请输入小组id" />
</div>
```

```js
n("div", {staticClass: "filter-line"},  [
  n("label", [t._v("订阅新小组")]), n("ElSelect", t._b({
    attrs: {
      value: t.tabs,
      placeholder: "请输入小组id"
    },
    on: {
      change: function(e) {
        return t.onFilterChange("tabs", e)
      }
    }
  }, "ElSelect", t.selectProps, !1)), t._m(0)], 1)
```

### props
### data
### event

### directive(parse)

#### v-if
```js
function genIf(el: ASTElement): string {
  el.ifProcessed = true
  return `(${el.data.directives.if}) ? ${genElement(el)} : _e()`
}

// 最终生成代码
t.tabs.length > 1 ? n("div", {
  on: {
    "tab-click": t.tabClick
  }
}), 1) : t._e()
```

#### v-for
```js
function genFor(el: ASTElement): string {
  el.forProcessed = true
  let result = el.data.directives.for.match(/(\w+)\sin\s(\w+)/)
  let iterator = result[1]
  let data = result[2]
  return `...(() => {
    return ${data}.map(${iterator} => {
      return ${genElement(el)}
    })
  })()`
}

// 最终生成代码
t._l(t.tabs, function(t) {
  return n("ElTabPane", {
    key: t,
    attrs: {
      label: t
    }
  })
})
```

#### v-bind
```js
export default function bind (el: ASTElement, dir: ASTDirective) {
  el.wrapData = (code: string) => {
    return `_b(${code},'${el.tag}',${dir.value},${
      dir.modifiers && dir.modifiers.prop ? 'true' : 'false'
    }${
      dir.modifiers && dir.modifiers.sync ? ',true' : ''
    })`
  }
}
```
