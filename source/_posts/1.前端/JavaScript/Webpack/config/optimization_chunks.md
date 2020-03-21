---
title: optimization:chunks
toc: true
date: 2020-03-20 00:00:04
tags:
---


* minimize: 是否开启Terser压缩js
* minimizer: 使用更复杂的Terser配置

```js
module.exports = {
  optimization: {
    minimizer: [
      new TerserPlugin({
        parallel: true, // 并行压缩
      }),
    ],
  },
};
```


## chunks
为什么要做chunk抽离？【[参考资料](https://imweb.io/topic/5b66dd601402769b60847149)】
* 将各page之间公共部分抽离，这样page.js会更小，项目整体打包出来的体积也更小
* entry的vendor抽离主要是考虑将npm包的部分抽离，除了降低整体项目打包体积外，还考虑到npm包是很少改动／升级的，所以vendor.js经常都会走用户浏览器的本地缓存。


### runtimeChunk
webpack runtime 抽成一个单独文件，比如webpack_require函数【[参考资料](https://webpack.js.org/configuration/optimization/#optimizationruntimechunk)】
```js
optimization: {
  runtimeChunk: 'single',
}
```

### splitChunks
【[参考资料](https://webpack.js.org/plugins/split-chunks-plugin/)】
```js
optimization: {
  splitChunks: {
    chunks: 'async', 
    minSize: 30000,
    maxSize: 0,
    minChunks: 1, // 至少被引用多少次才抽离
    maxAsyncRequests: 5,
    maxInitialRequests: 3,
    automaticNameDelimiter: '~',
    name: true,
    cacheGroups: { // cacheGroup里的配置可以覆盖外面的
      vendors: { // 将node_modules的包抽取为vendor.js
        test: /[\\/]node_modules[\\/]/,
        priority: -10
      },
      default: {
        minChunks: 2,
        priority: -20, // priority权重，冲突时优先被抽离到哪里
        reuseExistingChunk: true
      }
    }
}
```

使用priority调高权重，优先抽离css；不然可能有部分css会出现在其它chunk中
```js
optimization: {
  splitChunks: {
    cacheGroups: {
      styles: {
        name: 'styles', // name配合entry.chunkFilename使用；除'[name].js'外，还支持hash，默认是id
        test: /\.css$/,
        chunks: 'all',
        enforce: true,
        priority: 20, 
      }
    }
  }
}
```
