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
