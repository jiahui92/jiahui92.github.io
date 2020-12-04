---
title: Go
toc: true
date: 2020-03-02 00:00:01
tags:
---

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


## omitempty类型的坑
* 并非当值为空值时不返回字段给前端，特别要注意为0和false时，都会被json.marshal给忽略返回；前端在处理时会当作undefined；【[参考资料](https://ethancai.github.io/2016/06/23/bad-parts-about-json-serialization-in-Golang/)】
* 定义为`interface`时可以达到空值不返回的目的
