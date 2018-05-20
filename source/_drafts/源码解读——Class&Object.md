---
title: 源码解读——Class&Object
tags: 源码解读
---
## 简介
> Object类是Java类体系的基础，所有的类包括数组都以它为父类，并实现了它的方法。可以这样讲，它是对所有实现类公共属性的抽象。

> 在面向对象的编程思想下，对实现不同功能的代码进行抽象和封装成一个个对象，而不同对象存在于内存空间的数据结构，就是对象的实例。对象只有在实例化后才有它的实际意义，其它情况下都只是class的不同结构的体现。
---

## 面向对象与面向过程的程序设计思想

### 什么是面向对象
> 我个人认为 `class`是人认知世界的方式，我们把感受到属性一致的事务看成一种事务，这本身就是一种对事务进行归类的一种方式。
> 我们对所熟知的事务进行抽象，抽取出他们的共同属性————形状、味道、颜色、姿态等等，然后将这些属性放在一起我们就建立齐了事务与类的联系。
> 在计算机领域，`class`就是对公共代码在对象认识上的抽取与封装，赋予它们属性与功能，以达到简化开发过程的目的。
> 我认为，本质上来讲`class`其实就是数据结构的一种体现，它将`字段`和`方法`进行归并，是面向对象思想的体现。

总的来说
- 面向对象是将事务高度抽象化。
- 面向对象是一种字顶向下的编程。
- 面向对象必须先建立抽象模型，之后直接使用模型即可。

### 什么是面向过程
> `面向过程`是一种是事件为中心的编程思想。就是分析出解决问题所需的步骤，然后用函数把这写步骤实现，并按顺序调用。面向对象是以“对象”为中心的编程思想。

简单的举个例子：汽车发动、汽车到站
> 这对于“面向过程”来说，是两个事件，汽车启动是一个事件，汽车到站是另一个事件，面向过程编程的过程中我们关心的是事件，而不是汽车本身。针对上述两个事件，形成两个函数，之后依次调用。
> 然而这对于面向对象来说，我们关心的是汽车这类对象，两个事件只是这类对象所具有的行为。而且对于这两个行为的顺序没有强制要求。

---

## 一、Object

### 方法解读

- 1.
```java
@HotSpotIntrinsicCandidate
public final native Class<?> getClass();
```
> 本地方法，用于获取该类的字节码对象，且子类无法继承该方法。
- 2. 
```java
private static native void registerNatives();
```
> 本地方法，用于向jvm加载该类的本地方法实现。
- 3. `public final native Class<?> getClass();` 
> 本地方法，用于获取该类的字节码对象。
- 4. 
```java
public native int hashCode();
```
> 本地方法，返回该对象的hash值。
- 5. 
```java
public boolean equals(Object obj);
```
> 用于比较两个对象是否相等，该类的该方法实现默认为判断是否是同一个内存地址。
- 6
```java
protected native Object clone() throws CloneNotSupportedException;
```
> 本地方法，用于复制一份跟当前类equals的对象，默认为浅复制——内存中的属性值仍是原类的内容空间的数据。
- 7
```java
public String toString() {
        return getClass().getName() + "@" + Integer.toHexString(hashCode());
    }
```
> 默认返回由类名和hash值构成的字符串。
- 8
```java
@HotSpotIntrinsicCandidate
public final native void notify();
```
> 如果对象调用了notify方法就会通知某个正在等待这个对象的控制权的线程可以继续运行。
- 9
```java
@HotSpotIntrinsicCandidate
public final native void notifyAll();
```
> 如果对象调用了notifyAll方法就会通知所有等待这个对象控制权的线程继续运行。
- 10
```java
public final void wait() throws InterruptedException {
    wait(0L);
}
```
> 使当前线程进入等待状态，并重新分配CPU资源。
- 11
```java
@Deprecated(since="9")
protected void finalize() throws Throwable { }
```
> 与构造方法相对应的析构方法，当一个对象被垃圾回收机制回收之前会调用该对象的析构方法，默认为空实现。
---

## 二、Class<T>

### 引出
- 问题1：Object是对所有类的抽象出来的类，那么Class类作何解释？
  > 既然`class`是数据结构的体现，那么各种不通的类不就可以看做是这种数据结构的不同实例吗？
  > 所以，我的理解是`Class`就是所有类的模板类，定义类的过程就是它的实例化过程，而它的实例就是编译后的各种字节码。
- 问题2：如何实例化`Class`?
```java
  /*
   * Private constructor. Only the Java Virtual Machine creates Class objects.
   * This constructor is not used and prevents the default constructor being
   * generated.
   */
  private Class(ClassLoader loader, Class<?> arrayComponentType) {
      // Initialize final field for classLoader.  The initialization value of non-null
      // prevents future JIT optimizations from assuming this final field is null.
      classLoader = loader;
      componentType = arrayComponentType;
  }
  ```
  > 由源码可以知道，`Class`唯一的构造方法是私有的，也就是说，`Class`无法在代码中显式的去实例化，而只能由java虚拟机去创建。
- 问题3：既然`Class`的唯一构造方法是私有的，那么是否可以通过`反射`来调用该方法来创建实例？

### 类图
![Class]()

### 字段解读

- 实例成员变量

|字段名|字段类型|值|注释|
|---:|---:|---:|---:|
|ANNOTAION|int|0x00002000|注解标识|
|ENUM|int|0x00004000|枚举标识|
|SYNTHETIC|int|0x00001000||

- 类成员变量

|字段名|字段类型|注释|
|---:|---:|---:|
|cacheConstructor|Constructor<T>||
|newInstanceCallerCache|Class<T>||
|String|name||
||||
||||
||||


### 构造方法
> 参考问题`如何实例化Class?`


