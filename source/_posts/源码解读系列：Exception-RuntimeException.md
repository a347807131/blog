---
title: 源码解读——Exception&RuntimeException
tags: 源码解读
date: 2018-05-27 22:08:34
categories: 源码解读系列 
---


## 简介
> 本次解读`Exception`与`RunTimeException`的源码，以及在流程控制中的使用细节。
---
<!--more-->

## 体系
![exception-structure](https://raw.githubusercontent.com/a347807131/blog/master/ms/uml/exception-structure.jpg)
___

## 类图
- `Exception`——受检查异常
![Exception](https://raw.githubusercontent.com/a347807131/blog/master/ms/uml/Exception.png)
- `RunTimeException`——不受检查异常
![Exception](https://raw.githubusercontent.com/a347807131/blog/master/ms/uml/RuntimeException.png)
---

## 源码
- `Exception`
```java
public class Exception extends Throwable {

    static final long serialVersionUID = -3387516993124229948L;

    public Exception() {
        super();
    }

    public Exception(String message) {
        super(message);
    }

    public Exception(String message, Throwable cause) {
        super(message, cause);
    }

    public Exception(Throwable cause) {
        super(cause);
    }

    protected Exception(String message, Throwable cause,
                        boolean enableSuppression,
                        boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
```

- `RunTimeException`
```java
public class RuntimeException extends Exception {
    static final long serialVersionUID = -7034897190745766939L;

    public RuntimeException() {
        super();
    }

    public RuntimeException(String message) {
        super(message);
    }

    public RuntimeException(String message, Throwable cause) {
        super(message, cause);
    }

    public RuntimeException(Throwable cause) {
        super(cause);
    }

    protected RuntimeException(String message, Throwable cause,
                               boolean enableSuppression,
                               boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
```
---

## 解读：
> 其实就是Threable的实现，一个字符都没有变化，只是构造方法上的补充。
> 这里补充一下，子类只会继承父类的方法和属性，并不会继承父类的构造方法，所以子类需要重写构造方法。


> RuntimeException是一种Unchecked Exception，即表示编译器不会检查程序是否对RuntimeException作了处理，在程序中不必捕获RuntimException类型的异常，也不必在方法体声明抛出RuntimeException类。一般来说，RuntimeException发生的时候，表示程序中出现了编程错误，所以应该找出错误修改程序，而不是去捕获RuntimeException。常见的RuntimeException有NullPointException、ClassCastException、IllegalArgumentException、IndexOutOfBoundException等。

> Checked Exception是相对于Unchecked Exception而言的，Java中并没有一个名为Checked Exception的类。它是在编程中使用最多的Exception，所有继承自Exception并且不是RuntimeException的异常都是Checked Exception。JAVA 语言规定必须对checked Exception作处理，编译器会对此作检查，要么在方法体中声明抛出checked Exception，要么使用catch语句捕获checked Exception进行处理，不然不能通过编译。常用的Checked Exception有IOException、ClassNotFoundException等。

### 通用特点:
- JVM捕获并处理未被应用程序捕获的异常
- 异常catch有顺序性
- 如果在finally中返回值，那么在程序中抛出的异常信息将会被吞噬掉
```java
@Test
public void t12() throws Exception {
    t120();
}
private int t120() throws Exception {
    try{
        throw new Exception();
    }finally {
        return 0;
    }
}
```
#### 受检异常
- 必须处理或向上抛出
> 必须要对底层抛出来的受检异常进行处理，处理方式有`try...catch...`或者向上抛出（`throws`），否则程序无法通过编译。
- 不能捕获未被抛出的受检异常
> 如果我们试图去捕获一个未被抛出的受检异常，程序将无法通过编译（`Exception`除外）。
```java
//报错信息：Error:(209, 18) java: 在相应的 try 语句主体中不能抛出异常错误java.io.IOException
@Test
public void t13(){
    try {
        int i=0;
    }catch (IOException e){
        throw new RuntimeException();
    }
}
```
#### 运行时异常
> 运行时异常（runtime exception）与受检异常（checked exception）的最大区别是不强制对抛出的异常进行处理，所有的运行时异常都继承自RuntimeException这个类。
---

## 异常的使用的原则

- 大概率发生时使用运行时异常
> 最典型的就是NullPointException，java中每个对象的调用都有可能引发空指针问题，
> 如果这是一个受检异常，那么在每次调用对象方法要么try {} catch {}，那么使用throws关键字向上抛出。无论哪种方式，代码无疑都会是非常丑陋的，那画面太“美”不敢看。如果代码里充斥着各种异常处理块，可读性将会大打折扣。
- 异常无法恢复时使用运行时异常
> 当异常发生时，如果开发者无法从异常状态恢复到正常状态，那么这种异常应该是运行时异常。如果使用受检异常，这除了加重开发者的负担之外，别无它用。当在调用其他方法时，如果方法抛出受检异常，那么笔者就会比较紧张。因为这意味着需要停止业务逻辑开发，然后开始思考如何处理这该死的异常。
- 可恢复时优先使用受检异常
> 如果我们能够从异常中恢复到正常状态，那么应该优先使用受检异常。为什么是优先而不是一定呢？因为从原理上来说，使用运行时异常也可以恢复到正常状态，而且使用运行时异常的代码无疑会比较干净整洁。而使用受检异常，明确地说明了调用方式时可能发生异常情况，强制开发者去处理这些异常情况常常会增强代码的健壮性。受检异常通常是由外部环境所引起的，譬如IOException等。
- 使用受检异常做流程控制
> 《Effect Java》一书中也建议只有真正的异常情况才使用异常。但我们有时也会利用异常来达到业务流程控制的目的。这样做主要有下面的好处：
>* 简化代码逻辑。我们无需为多分枝业务流程编写各种if...else...语句来处理不同的情况。相反地，我们只需处理正常的业务流程即可，异常流程只需要通过异常向上抛出去即可，至于谁去处理这些异常，则不需要我们过多地关心。
>* 可读性增强。如果一段代码中充斥着分枝逻辑，那么整个代码的可读性会非常差。在阅读代码时，很难理清楚代码的主干。说到底，主干代码才是我们重点关注的。如果使用异常进行流程控制，主干代码就清晰地显示在面前，两个字：舒服！
- 尽量集中处理异常
> 在各种有关代码重构的书本中，都会提到一个核心原则：一个方法应该仅做一件事情。如果一个方法中，既包含业务逻辑，又包含异常处理程序，那么实际上这个方法就做了两件事情。如果异常上层可以处理，那么就不应该在下层处理。在上层进行处理的好处是，可以对异常进行统一地处理。而至于将异常处理程序分散到代码的各个地方，导致维护起来十分困难。在进行异常处理时，应该优先考虑使用AOP（面向切面编程）技术，这样降低了核心业务逻辑与异常处理的耦合性。
- catch时指定具体的异常
> 不要一股脑地catch Exception，具体的异常应该单独catch住，越具体的异常越早catch。
- 涉及到资源时，需要`finally`处理
- 最小化try{ } catch{ }范围
> try的范围应该尽量小，最好就是try住抛出异常的那个方法即可。
--- 

## 参考

- [xialei的个人小站](http://hinylover.space/2016/06/05/relearn-java-exception/)