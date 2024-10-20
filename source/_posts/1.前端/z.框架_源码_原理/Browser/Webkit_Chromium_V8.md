---
title: Webkit/Chromium/V8
toc: true
date: 2020-03-12 00:00:03
tags:
---

![](https://user-gold-cdn.xitu.io/2018/12/3/16771e08d735e0be)

Name | 渲染引擎 | JS解释引擎
---------|----------|---------
 WebKit | WebCore | JSCore
 Chromium | Blink | V8

【[参考资料](https://juejin.im/post/5c0492a36fb9a049e82b435a)】


<br/><br/><br/>
之前的内容都是渲染相关的，接下来的是JS解释引擎V8

## V8.JIT vs JSCore
`JIT: 解释 + 编译 = 即时编译` 相比JSCore，V8放弃了在字节码阶段可以进行的一些性能优化（移除空格，不会被执行的死码和冗余代码等），但保证了执行速度；【[参考资料](https://juejin.im/post/5a582b13f265da3e355aff46)】


## V8
【[参考资料](https://www.jianshu.com/p/80a7d1ab8620)】

![](/img/Snip20200312_11.png)
* js --> ast --> 本地代码 --> 编译成机器码执行
* 支持众多操作系统，如windows、linux、android等，也支持其他硬件架构，如IA32,X64,ARM等，具有很好的可移植和跨平台特性

### 数据表示
由于JavaScript是无类型语言，那就不能像c++那样在执行时已经知道变量的类型和地址，需要临时确定。这也就是JavaScript运行效率比C++或者JAVA低很多的原因之一。


### 编译本地代码
并非所有的函数都被编译生成本地代码，而是延迟编译，在调用时才会编译
* Script: js代码的编译入口和运行入口
* Compiler: 生成AST
* AstVisitor
* FullCodeGenerator: 生成汇编代码


### 运行代码
* 在V8中，函数是一个基本单位，当某个JavaScript函数被调用时，V8会查找该函数是否已经生成本地代码，如果已经生成，则直接调用该函数。否则，V8引擎会生成属于该函数的本地代码。
* 执行编译后的代码为JavaScript构建JS对象，这需要Runtime类来辅组创建对象，并需要从Heap类分配内存。再次，借助Runtime类中的辅组函数来完成一些功能，如属性访问等。
* 最后，将不用的空间进行标记清除和垃圾回收。


### V8拓展1
```java
module mymodule {
  interface [
    InterfaceName = MyObject
  ] MyObj { 
    readonly attribute long myAttr;
    DOMString myMethod (DOMString myArg);
  };
}
```
* 定义新的接口文件，比如上图的js调用mymodule.MyObj.myAttr
* 使用webkit工具生成v8MyObj.h（具体实现函数）和V8MyObj.cpp（js和V8桥接代码）两个文件
* 和V8引擎一起打包


### V8拓展2
```java
class MYExtension : public v8::Extension {
  public:
    MYExtension() : v8::Extension("v8/My", "native function my();") {}
    virtual v8::Handle<v8::FunctionTemplate> GetNativeFunction (
    v8::Handle<v8::String> name) {
      // 可以根据name来返回不同的函数
      return v8::FunctionTemplate::New(MYExtention::MY);
    }
    static v8::Handle<v8::Value> MY(const v8::Arguments& args) {
      // Do sth here
      return v8::Undefined();
    }
};
MYExtension extension;
RegisterExtension(&extension);
```
* 基于Extension基类构建一个它的子类，并实现它的虚函数—GetNativeFunction，根据参数name来决定返回实函数（这里写上拓展函数的name）。
* 创建一个该子类的对象，并通过注册函数将该对象注册到V8引擎，当JavaScript调用’my’函数时就可被调用到。
* 这个灵活性高一点，不需要和V8一起打包，但性能低一些


### 总结
* `内存`。虽然JavaScript语言会自己进行垃圾回收，但我们也应尽量做到及时回收不用的内存，**对不再使用的对象设置为null或使用delete方法来删除**(使用delete方法删除会触发隐藏类新建，需要更多的额外操作)。
* `类型`。对于函数，JavaScript是一种动态类型语言，JSCore和V8都使用隐藏类和内嵌缓存来提高性能，为了保证缓存命中率，一个函数应该使用较少的数据类型；**对于数组，应尽量存放相同类型的数据，这样就可以通过偏移位置来访问。**
* `优化回滚`。**在执行多次之后，不要出现修改对象类型的语句**，尽量不要触发优化回滚，否则会大幅度降低代码的性能。
* ~~`数据表示`。**简单类型数据（如整型）直接保存在栈中，可以减少寻址时间和内存占用**，如果可以使用整数表示的，尽量不要用浮点类型。~~



### 其他
* 运行期间的优化与优化回滚
* 优化数据表示：隐藏类&内嵌缓存
* 垃圾回收机制





## V8: Node.js
![](/img/Snip20200312_12.png)

Node.js基于V8【[参考资料](https://segmentfault.com/a/1190000014722508?utm_source=index-hottest)】
* lib目录是js实现的node api
* src目录是c/c++编写的V8拓展
* [node拓展](https://juejin.im/post/5af58b81f265da0b767d8837)


## V8: Electron
* Electron基于CEF和Node.js，CEF基于V8
* Electron同时在主进程和渲染进程中都暴露了Node.js的所有接口，即支持node所有API和npm包。

## V8: CEF
Chromium Embedded Framework【[参考资料](https://blog.csdn.net/jiftlixu/article/details/18220743)】
* 基于Google Chromium项目的开源Web browser控件，支持Windows, Linux, Mac平台。除了提供C/C++接口外，也有其他语言的移植版。
* CEF还提供的如下特性：自定义插件、自定义协议、自定义JavaScript对象和扩展；可控制的resource loading, navigation, context menus等等

### 应用
* 做一个浏览器
* 客户端
* Electron跨平台的桌面底层方案



## nodejs与强类型语言的对比
### 性能
js背后都是靠v8来编译执行，v8功能主要分为两部分
* js计算逻辑(非底层函数调用): 性能损耗很大
  * JIT: 运行时编译再执行，相比强类型语言编译然后运行二进制 性能差异比较大，也是js不擅长计算的原因
    * 循环、数据处理
    * 运行时类型检查和处理
    * 垃圾回收频繁
  * 泛型变量: 内存占用大
* js底层函数调用: 性能几乎无损耗，甚至比强类型语言更好，优点取决于底层调用库+架构上的异步非阻塞的事件驱动模型
  * nodejs: JIT编译完后由c++库运行，擅长io操作，比如文件、网络/数据库 (java.NIO)
  * deno: JIT编译完后由rust库运行，具有内存安全的特点
  * bun: jscore编译完后使用zig

#### 性能解决
遇到明显的复杂计算逻辑时
* webAssembly
* gRPC (delay: 10ms)


### 可维护性与开发效率
* 主要是: ts(关闭any) vs 强类型语言

### 生态
xxx
