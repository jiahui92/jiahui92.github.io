---
title: loader
toc: true
date: 2020-03-20 00:00:01
tags:
---

## 常用loader
* 编译：babel-loader、vue-loader 、ts-loader等
* 样式：style-loader、css-loader、less-loader、postcss-loader(autoprefix)等
* 文件：raw-loader、file-loader 、url-loader等
* 校验测试：mocha-loader、jshint-loader 、eslint-loader等


一种特殊的plugin，专门用于转换代码格式，比如将less转为css，ts转为js，或者babel转换成es5


## loader开发
### 基本操作
【[官方文档](https://webpack.js.org/contribute/writing-a-loader/)】【[参考资料](https://imweb.io/topic/5d4a94a08db073cf44ca8cd0)】
```js
// loader插件的结构一般为
module.exports = (source) => {
  // TODO需要执行的逻辑
  this.callback(null,newContent, sourceMaps, meta);
  // callback和return只要选择其一即可
  return transform(source);
}


module.exports = (source) => {

  // 再编译时，如果依赖和代码不变，则直接读缓存
  this.cacheable();

  // cacheable的loader需要显式指定不能缓存/会发生改变的资源
  this.addDependency(headerPath);
  fs.readFile(headerPath, 'utf-8', (err, header) => {
    if (err) {
      this.callback(err)
    } else {
      this.callback(null, header + '\n' + source);
    }
  });

}
```

### recast复杂操作
代码操作比较复杂时，可以使用`recast`：webpack的ast是用recast生成的，而recast则依赖babel一系列的库【[参考资料](https://juejin.im/post/5d50d1d9f265da03aa25607b)】
```js
const recast = require('recast')
const t = recast.types.namedTypes

module.exports = function (source) {

  const ast = recast.parse(source, {
    parser: require('recast/parsers/babel')
  })

  recast.visit(ast, {
    visitCallExpression (path) {
      const { node } = path
      const arguments = node.arguments

      let firstExp

      arguments.forEach(item => {
        if (t.ArrowFunctionExpression.check(item)) {
          ...
        }
      })

      return false
    }
  })

  return recast.print(ast).code
}
```

### loader间数据共享
```js
module.exports = (source) => {
  
  console.log(this.data.value);
  
  return '{};' + source;
}

module.exports.pitch = (remaining, preceding, data) => {
  data.value = 'test';
}
```


## loader原理
【[参考资料](https://juejin.im/post/5bdc1c1651882516f5784c34)】
```js
let source = fs.readFileSync(modulePath, "utf8");

//获取webpack.config.js中的rules
let rules = that.options.module.rules;

//遍历rules调用loader
for (let i = 0; i < rules.length; i++) {
  let rule = rules[i];
  // 用rule的test中正则匹配文件的类型是否需要使用laoder
  if (rule.test.test(modulePath)) {
    //获取rule中的loaders，例如['style-laoder','css-loader']
    let loaders = rule.use;
    let length = loaders.length; //loader的数量
    let loaderIndex = length - 1; // 往右向左执行

    // loader遍历器
    function iterateLoader() {
      let loaderName = loaders[loaderIndex--];
      //loader只是一个包名，需要用require引入
      let loader = require(join(that.root, "node_modules", loaderName));
      //使用loader，可以看出loader的本质是一个函数
      source = loader(source);
      if (loaderIndex >= 0) {
        iterateLoader();
      }
    }
    //遍历执行loader
    iterateLoader();
    break;
  }
}
return source;

```