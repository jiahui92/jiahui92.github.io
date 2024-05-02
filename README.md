
[传送门](https://jiahui92.github.io/blog)

## why this
* 将零散知识逐步结构化整理
* 将xmind迁移到wiki上来
* 分享、交流


## todo
* [x] Jenkinsfile
* [x] footbar备案信息
* [x] 将主题的依赖替换为cdn
* [ ] 主题部分资源未打包压缩
* [ ] 优化UI
  * [ ] h5
  * [ ] 目录转xmind
  * [ ] 增加order字段

## xmind待整理
* [x] HTML
* [x] CSS
* [ ] JavaScript.xmind
* [x] 性能优化
* [x] Webpack.xmind
* [ ] 框架&源码
  * [x] 浏览器
  * [x] React
  * [ ] Vue
  * [x] AST
  * [ ] Lib小库
  * [x] 插件
* [x] 自动化测试
* [x] 跨平台
* [ ] three.js.xmind
* [ ] 编写可维护的js.xmind
* [ ] 深入浅出Node.xmind
* [ ] 算法.xmind
* [ ] AI.xmind
* [ ] draf/*.md



## dev
本项目依赖的hexo版本比较低，`npm run build`时依赖nodev12，否则会导致build出来的文件全是空白，因此`./github/workflows/*`中会限定为v12的node（开发时的`npm start`暂不影响）
```sh
npm i
npm start
```

## github actions
* `.github/workflows/node.js.yml`文件中定义了自定义部署，每当master代码更新后会自动触发打包，发布到github pages
* 第一次`npm run build`配置需调整`./_config.yml`里的url和root，否则会影响前端资源的相对路径，导致部分css 404

## tech
* [hexo](https://hexo.io/)
* [hexo-theme-Wikitten](https://github.com/zthxxx/hexo-theme-Wikitten)
