---
title: Netlify 前端应用部署
toc: true
date: 2020-03-02 00:00:07
tags:
---

【[参考资料](https://docs.netlify.com/configure-builds/file-based-configuration/#sample-file)】
* [Netlify](https://www.netlify.com/)将CI和nginx的功能揉合到了一份配置文件中；
* 感觉是一套能适应所有前端应用部署的方案了；
* 对于企业来说可能`build`配置可以放在部署平台的默认配置中，而不是必须在这个配置文件中；

```yml
build:
  command: npm run build
  publish: dist/

redirects:
  from: /old-path
  to: /new-path
  status: 302
  headers:
    X-From: Netlify

# Response Header
headers:
  values:
    X-Frame-Options: DENY
    Cache-Control: '''
      max-age=0,
      no-cache,
      no-store,
      must-revalidate
    '''
    Basic-Auth: someuser:somepassword anotheruser:anotherpassword
```
