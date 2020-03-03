# https://hanhan.pro/2018/06/06/deploy-eggjs-app-with-docker/
# eggjs 一定要将package.json里的scrpits.start的daemon删掉

FROM node:13.4.0-alpine

RUN node -v
RUN npm -v

# 设置时区
ENV TZ=Asia/Shanghai

# 创建app目录
RUN mkdir -p /app
# WORKDIR是在container里创建的工作目录
WORKDIR /app

# 复制当前目录到container的app目录
# 拷贝package.json文件到工作目录
# !!重要：package.json需要单独添加。
# Docker在构建镜像的时候，是一层一层构建的，仅当这一层有变化时，重新构建对应的层。
# 如果package.json和源代码一起添加到镜像，则每次修改源码都需要重新安装npm模块，这样木有必要。
# 所以，正确的顺序是: 添加package.json；安装npm模块；添加源代码。
COPY package*.json /app/
RUN npm i --registry=https://registry.npm.taobao.org  --production
# 拷贝所有源代码到工作目录，不需要拷贝的话可以在.dockerignore文件忽略
COPY . /app

EXPOSE 4000
VOLUME [ "/root/logs" ]

# RUN npm run test
CMD npm run dev

# docker run -d --name blog -p 4000:4000 -v ~/logs:/root/logs --restart always blog
