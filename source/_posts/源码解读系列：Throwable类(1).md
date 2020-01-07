---
title: 源码解读——Throwable类——1
date: 2018-04-29 13:04:22
tags: 源码
categories: 源码解读 
---

## 简介

> Throwable类是整个异常体系类的父类，它实现了Serializable接口，表示它能够被序列化。它的子类主要是Error和Exception类，以及一个StackRecorder类（不常见）。
---
<!--more-->

## Throwable类图

![Exception类图](https://raw.githubusercontent.com/a347807131/ms/master/exception/Exception.png)
----------------------------------------------------------------------------------------------

## 异常类结构体系

![结构体系](https://raw.githubusercontent.com/a347807131/ms/master/exception/异常类体系.png)
### 解读

Error
> Error类层次描述了Java运行时系统的内部错误和资源耗尽错误。对于这类错误是无法难通过程序来解决的，所以程序不应该抛出这种类型的对象。如果出现了这样的内部错误，除了通知给用户，并尽力使程序安全地终止。当然这类情况是很少出现的。

Exception
> 在设计Java程序时，Exception是我们需要重点关注的错误，在Java程序中Exception又可以分为两类：Runtime Exception、其它异常如：IOException。
注:如果出现RuntimeException,那么久一定是自己的问题。

运行时异常和受检查异常
> * 在Java语言中将派生于Error或RuntimeException类的所有异常称为运行时异常，这类异常我们可以不处理，当出现这个的异常时，总是由虚拟机接管。
> * 除了运行时异常，其它的异常都被称为检查性异常除了运行时异常，其它的异常都被称为检查性异常。对于这种异常，Java编译器要求我们必须对出现的这些异常进行catch。
-----------

## 成员变量

### 实例变量
|类型     |   变量名      | 说明 |
|----    |   ---------: |-----: |
|Object|backtrace||
|String|detailMessage|异常具体信息|
|StackTraceElement[]|stackTrace|栈轨迹元素|
|int|depth|异常栈深度|
|List<Throwable>|suppressedException|被抑制的异常|
### 静态类变量
|类型     |   变量名      | 说明 |
|----    |   ---------: |-----: |
|StackTraceElement[]|UNASSIGNED_STACK|共享的空栈|
|List<Throwable>|SUPPRESSED_SENTINEL||
|Throwable[]|EMPTY_THROWABLE_ARRAY|空异常数组|
|class|StackTraceElement|代表轨迹中的元素|
||||
---

## 方法解读

- fillInStackTrace()
> 填充异常栈信息

- printStackTrace()
> 将跟踪栈信息打印到控制台

- getLocalizedMessage()
> 返回当前异常的具体描述信息，默认是返回detailMessage。

- getCause
```java
//疑惑点：为什么是synchronized修饰，为什么cause不能是自身
    public synchronized Throwable getCause() {
        return (cause==this ? null : cause);
    }
```
> 返回异常stack缘由

- initCause(Throwable cause)
> 构造异常链

- toString()
> 返回异常带有类名称的描述信息

### 构造方法

- 1.Throwable()
> 默认构造方法，其实现是直接调用fillInStackTrace()方法。

- 2.Throwable(String message)
> 除实例化对象外，将传入字符串作为异常详细信息。

- 3.Throwable(String message,Throwable cause)
> 在2的基础上并将当前对象指向cause。

- 4.Throwable(Throwable cause)
> 在1的基础上将cause.toString的返回信息作为detailMessage，并将当前对象指向cause。


## 小结

> 从异常类的设计中体会到，设计者的抽象思维与设计水平令人叹服，通过一个类去抽象出所有异常中通用的方法与表示形式以及其表达的实体结构，而且通过继承的方式对异常这个领域做一个水平划分，将其切分为Error和Exception两种平行的异常类型，然后，这两者将再次作为各自类型的异常的父类，因为每一种异常同样是存在不同的分类，再次创建一系列的类去继承上面的两种异常派生出新的异常类型划分。这样不断的继承下去，逐步的细化到每一种具体的异常类型，形成一个丰富的异常类族。

> 从扩展性上而言，由于Throwable实现的是异常类中通用的部分，那么，如果再有特殊的异常分类的话，可以通过继承Throwable的方式去扩展该异常体系，当然，我们最常用的可能不会涉及到直接继承Throwable。

## 补充
> 由于Java异常处理内容比较多，此次只大略解读其中比较重要的方法和变量的作用，后续会继续对每个方法实现进行解读。