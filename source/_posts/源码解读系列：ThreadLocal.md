---
title: 源码解读——ThreadLocal
tags: 源码
date: 2018-07-03 15:52:59
categories: 源码解读系
---


## 简介

引出 如何将线程与变量绑定，以解决多线程安全问题？
> 首先，在Thread解读中提到，每个线程都有一个线程栈，该栈里的数据只能该线程访问。这样一看，貌似线程里创建的变量就天然是线程隔离的，不存在多线程安全问题，
> 实际上，栈空间只是存的方法局部变量，所以如果需要变量与线程全程绑定，这是不可行的。
<!--more-->

问题：如何解决？
> 既然栈空间不能做到，那么将变量放在线程都能访问的地方，再以当前线程作为索引不就解决问题了吗？
> 这就是`ThreadLocal`，将线程相关的变量放在一个都能访问到的map中。

## 成员变量

|修饰符|类型|成员名|默认值|作用|
|---|---|---|---|---|
|private final|int|threadLocalHashCode|nextHashCode|在创建实例时获取下一个hash值|
|private static|AtomicInteger|nextHashCode|new AtomicInteger|用于生成hash值|
|private static final|int|HASH_INCREMENT|0x61c88647|前后两个hash值的间隙|

内部类
```java
static class ThreadLocalMap{
    static class Entry extends WeakReference<ThreadLocal<?>> {
        //与当前线程本地map相关的值
        Object value;
    
        Entry(ThreadLocal<?> k, Object v) {
            super(k);
            value = v;
        }
    }
    //初始容量
    private static final int INITIAL_CAPACITY = 16;
    private Entry[] table;
    
    //集合的大小
    private int size = 0;

    //下一个进行增容的容量大小
    private int threshold; // Default to 0

}
```

## 构造方法

```java
public ThreadLocal() {
}
```

## 公共方法

```java
/**
 * 返回该线程局部变量的初始值，该方法是一个protected的方法，显然是为了让子类覆盖而设计的。
 * 这个方法是一个延迟调用方法，在线程第1次调用get()或set(Object)时才执行，并且仅执行1次。
 * ThreadLocal中的缺省实现直接返回一个null。
 */    
protected T initialValue() {
    return null;
}
/**
 * 根据Suppier重新构建
 */
public static <S> ThreadLocal<S> withInitial(Supplier<? extends S> supplier) {
    return new SuppliedThreadLocal<>(supplier);
}
/**
 * 获取线程绑定的变量
 */
public T get() {
    Thread t = Thread.currentThread();
    ThreadLocalMap map = getMap(t);
    if (map != null) {
        ThreadLocalMap.Entry e = map.getEntry(this);
        if (e != null) {
            @SuppressWarnings("unchecked")
            T result = (T)e.value;
            return result;
        }
    }
    return setInitialValue();
}
/**
 * 设置对应的值与当前线程绑定
 * 以当前线程为键获取对应的map，再以当前ThreadLocal对象为键、value为值
 * 组成键值对放入map中
 */
public void set(T value) {
    Thread t = Thread.currentThread();
    ThreadLocalMap map = getMap(t);
    if (map != null)
        map.set(this, value);
    else
        createMap(t, value);
}

/**
 * 将与当前线程绑定的变量移除
 */
public void remove() {
     ThreadLocalMap m = getMap(Thread.currentThread());
     if (m != null)
         m.remove(this);
}
```

## ThreadLocal和哦同步机制

ThreadLocal和线程同步机制相比有什么优势呢？
> ThreadLocal和线程同步机制都是为了解决多线程中相同变量的访问冲突问题。
> 在同步机制中，通过对象的锁机制保证同一时间只有一个线程访问变量。这时该变量是多个线程共享的，使用同步机制要求程序慎密地分析什么时候对变量进行读写，什么时候需要锁定某个对象，什么时候释放对象锁等繁杂的问题，程序设计和编写难度相对较大。
> 而ThreadLocal则从另一个角度来解决多线程的并发访问。ThreadLocal会为每一个线程提供一个独立的变量副本，从而隔离了多个线程对数据的访问冲突。因为每一个线程都拥有自己的变量副本，从而也就没有必要对该变量进行同步了。ThreadLocal提供了线程安全的共享对象，在编写多线程代码时，可以把不安全的变量封装进ThreadLocal。

问题1：既然Threadlocal本质是一个map，那么这个map在哪儿？
> 在`Thread`解读中，了解到一个线程都可以看做是一个`Thread`的实例，而它的成员变量有一个类型为`ThreadLocal`的变量，这里才是真正将变量与线程绑定的实现。

问题2：既然`ThreadLocal`是通过`Thread`实现的，为什么不直接将一个map存放在`Thread`中，以达到目的？