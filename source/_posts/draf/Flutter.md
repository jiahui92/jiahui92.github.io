---
title: Flutter
toc: true
hidden: true
date: 2023-01-01 00:00:00
tags:
---

# Flutter常用命令
```sh
# 安装依赖
flutter pub get
# 运行
flutter run

# 添加依赖
flutter pub add package_namexxx
# 打包
# 混淆代码xxx

# 翻墙相关设置
```

# Android
* 打包工具：and, maven, gradle

## 真机调试
* 手机设置
  * 打开开发者模式
  * 勾选 允许USB安装应用
```sh
# 配对或者先使用USB连接后信任pc设备
adb pair 192.168.1.2:xxx
# 无线调试
adb connect 192.168.1.2:xxx
# 查看已连接设备
adb devices -l
```