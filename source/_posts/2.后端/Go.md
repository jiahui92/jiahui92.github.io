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
list := res["data"].([]interface{})
item := list[0].(map[string]interface{})
user := item["user"].(map[string]interface{})
userName := user["name"].(map[string]interface{})

// 通过toObject直接转成定义好的struct
// https://stackoverflow.com/questions/63328016/how-to-retrieve-a-nested-json-value-in-a-top-level-struct-in-golang

```

### nil的判断
https://mangatmodi.medium.com/go-check-nil-interface-the-right-way-d142776edef1
```go
val == nil || reflect.ValueOf(val).IsNil()
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
* go install / get
  * bin pkg 目录
* go modules
* go package
* go list
* go vender

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