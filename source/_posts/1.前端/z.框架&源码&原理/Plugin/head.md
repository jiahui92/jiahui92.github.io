---
title: 嵌入前端资源
toc: true
date: 2020-03-07 00:00:01
---

## nextjs
这种方式支持任意页面自定义【[参考资料](https://nextjs.org/docs/api-reference/next/head)】
```js
// import Head from "next/head"
import Document, { Html, Head, Main, NextScript } from 'next/document'


const Index = () => {
  return (
    <div>
      <Head>
        <title>My page title</title>
        <meta name="viewport" content="initial-scale=1.0, width=device-width" />
        <link rel="icon" href="/static/favicon.ico" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.2/jquery.min.js"></script>
        <link href="https://cdn.snipcart.com/themes/2.0/base/snipcart.min.css" rel="stylesheet" type="text/css" />
      </Head>
    </div>
  )
}
```

## nuxt.js
看起来是全部页面的统一配置【[参考资料](https://github.com/storyblok/nuxtjs-multilanguage-website/blob/master/nuxt.config.js)】
```js
// ~/nuxt.config.js
module.exports = {
  ...
  head: {
    title: 'mywebsite',
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: 'Nuxt.js project' }
    ],
    link: [
      { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' },
      { rel: 'stylesheet', href: 'https://fonts.googleapis.com/css?family=Zilla+Slab:400,700' }
    ]
  },
  ...
}
```

## html-webpack-plugin
在做框架时，要是不能够让用户自己写html模版，则可以用这种方式暴露出来【[参考资料1](https://juejin.im/post/5c8c6212e51d4522fa2965ad)】【[参考资料2](https://github.com/jaketrent/html-webpack-template)】
```js
// webpack.config.js
{
  plugins: [
    new HtmlWebpackPlugin({({
      title: 'Custom template',
      template: 'index.html',
      files: {
        css: [
          'inex.css'
        ],
        js: [
          'https://ajax.googleapis.com/ajax/libs/jquery/2.2.2/jquery.min.js',
          'common.js',
          'index.js'
        ],
      }
    })
  ]
}
```
```html
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title><%= htmlWebpackPlugin.options.title %></title>
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no">
    <% for (var css in htmlWebpackPlugin.files.css) { %>
  <link href="<%=htmlWebpackPlugin.files.css[css] %>" rel="stylesheet">
  <% } %>
</head>
<body>
<div id="app"></div>

<% for (var n in htmlWebpackPlugin.files.js) { %>
<script type="text/javascript" src="<%=htmlWebpackPlugin.files.js[n].entry %>"></script>
<% } %>

</body>
</html>
```
