---
title: Go
toc: true
date: 2020-03-02 00:00:01
tags:
---


# 类型
## 类型推断 与 取值
### 
```go
// 一层一层推断
// 方式一： interface{}的取值与推断
var userName = ""
if list, ok1 := res["data"].([]interface{}); ok1 {
   if item, ok2 := list[0].(map[string]interface{}); ok2 {
      if modifiedUser, ok3 := item["modifiedUser"].(map[string]interface{}); ok3 {
         userName = modifiedUser["name"].(string)
      }
   }
}

// 通过toObject直接转成定义好的struct
// https://stackoverflow.com/questions/63328016/how-to-retrieve-a-nested-json-value-in-a-top-level-struct-in-golang
// 方式二： 使用ToObject转成struct
var list []gen_ei.IAsset
utils.ToObject(res["data"], &list)
var userName = ""
if len(list) > 0 && list[0].ModifiedUser != nil {
   userName = assets[0].ModifiedUser.Name
}

```

### nil的判断
空struct的nil判断比较特别，类型不等于nil
https://mangatmodi.medium.com/go-check-nil-interface-the-right-way-d142776edef1
```go
val == nil || reflect.ValueOf(val).IsNil()
```

## 数组与slice
正常情况下直接用slice就行了
* 数组是固定长度的，slice长度可变；
* 作为参数传递时，数组会传递值，slice会传递指针
```go
// 数组的声明
a1 := [3]int{1,2,3}
a2 := [...]int{1,2,3}
```


## json


# 协程
* 通过协程来实现并发，比开启一个线程和进程消耗都小，4K栈内存
* 协程的底层实现也是线程，像java一样开了一堆线程池来支持协程；

```js
func hello() {  
  fmt.Println("Hello world goroutine")
}

func main() {  
  go hello()
  time.Sleep(1 * time.Second)
  fmt.Println("main function")
}
```


# 其它
## omitempty类型的坑
* 并非当值为空值时不返回字段给前端，特别要注意为0和false时，都会被json.marshal给忽略返回；前端在处理时会当作undefined；【[参考资料](https://ethancai.github.io/2016/06/23/bad-parts-about-json-serialization-in-Golang/)】
* 定义为`interface`时可以达到空值不返回的目的


# go cli
## 目录
* bin/pkg：存放go依赖文件的目录
* src：本地开发代码存放目录
  * vender: 开发项目的目录，在该目录下查到到依赖时，则不会再去找bin/pkg
  * go.mod文件中定义依赖

## 安装依赖
### go get
`go get` 安装依赖（下载、编译、安装到对应目录）
```sh
  go get -u github.com/golang/protobuf@v1.4.0
```
* go build 编译生成可执行文件
* go install 将编译后的可执行文件安装到指定bin/pkg目录
* go run 编译并运行程序

### vender
`go mod vender`将本地的包`$GOPATH/pkg/mod`安装进开发项目的vender依赖


## modules开发
```sh
mkdir src/hello
cd src/hello
## 初始化go模块
go mod init github.com/jiahui/hello
go run hello.go

## 使用go modules
go get
go mod vender
```

# vscode的配置
## gopls
语法提示 、 rename 、 autoimport

## delve
默认的dlv插件配置不好用，需要手动配置一下【[参考资料](https://itnext.io/golang-bits-better-debugging-in-vscode-599bc5b018da)】
```json
"go.delveConfig": {
  "useApiV1": false,
  "dlvLoadConfig": {
    "followPointers": true,
    "maxVariableRecurse": 5, // debug时变量最多可展开多少层，默认为1，越大debug启动越慢
    "maxStringLen": 400,
    "maxArrayValues": 400,
    "maxStructFields": -1
  }
}
```