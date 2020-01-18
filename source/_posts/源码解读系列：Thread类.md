---
title: Thread类解读
date: 2018-04-25 23:00:49
tags: 源码
categories: 源码解读 
---

## 简介

    Thread类是Java并发编程的基础，是对多线程编程的实现，底层大量使用了native调用C/C++实现的API，是jdk中也非常基础也非常重要的类。
<!--more-->

## 类图

![](https://raw.githubusercontent.com/a347807131/ms/master/images/20200118101552.png)

---

## volatile关键字

### 作用



    Java 语言中的 volatile 变量可以被看作是一种 “程度较轻的 synchronized”；与 synchronized 块相比，volatile 变量所需的编码较少，并且运行时开销也较少，但是它所能实现的功能也仅是 synchronized 的一部分。
    
    一旦一个共享变量（类的成员变量、类的静态成员变量）被volatile修饰之后，那么就具备了两层语义：
    　　1）保证了不同线程对这个变量进行操作时的可见性，即一个线程修改了某个变量的值，这新值对其他线程来说是立即可见的。（反映到硬件层的话，就是CPU的L1或者L2缓存中对应的缓存行无效）
    　　2）禁止进行指令重排序。
    volatile关键字禁止指令重排序有两层意思：
    　　1）当程序执行到volatile变量的读操作或者写操作时，在其前面的操作的更改肯定全部已经进行，且结果已经对后面的操作可见；在其后面的操作肯定还没有进行；
    　　2）在进行指令优化时，不能将在对volatile变量访问的语句放在其后面执行，也不能把volatile变量后面的语句放到其前面执行。

<br>

### volatile保证了可见性，不保证原子性

比如下列代码就时而成功，时而失败。
```java
public class ThreadTest {
    private volatile int inc = 0;

    private void increase() {
        inc++;
    }

    @Test
    public void t(){
        for(int i=0;i<10;i++){
            new Thread(() -> {
                for(int j=0;j<1000;j++)
                    increase();
            }).start();
        }
       assert inc==10000;
    }
}
```
    解释：当线程读取inc的值后修改之前，cpu调度到其它线程，但是线程1没有进行修改，所以其他线程根本就不会看到修改的值。
<br>

### 使用volatile关键字需要具备的条件

- 1.对变量的写操作不依赖当前值
- 2.该变量没有包含在具有其他变量的不变式中
<br>

## 成员变量

|类型     |   变量名      | 说明 |
|----    |   ---------: |-----: |
| String|    name |  线程名     |
| int   |    priority | 优先级 |
| long  |    eetop    |       |
| boolean|   single_step |  线程是否单步  |
| boolean|   daemon   |是否为守护线程|
| boolean|   stillborn|  虚拟机状态 |
| Runnable|  target   |目标run方法对象 |
| ThreadGroup|   group|   线程组 |
| ClassLoder |   contextClassLoader | 类加载器 |
| AccessControlContext | inheritedAccessControlConext |
| ThreadLocalMap    |   threadlocals  | |
| ThreadLocalMap    |   inheritableThreadLocals ||
| long  |   stackSize |该线程栈大小 |
| long | nativeParkEventPointer| |
|long|tid|线程id|
|int|threadStatus|线程状态|
|Object|parkBlocker||
|Interruptible|blocker||
|Object|blockerLock||
|UncaughtExceptionHandler|uncaughtExceptionHandler||
<br>

静态成员变量

|类型    |   变量名      | 说明 |
|----    |   ---------: |-----: |
|int|threadInitNumber|s|
|long|threadSeqNumber||
|int|MIN_PRIORITY|最小优先权|
|int|NORM_PRIORITY|默认优先权|
|Int|MAX_PRIORITY|最大优先权|
|StackTraceElement[]|EMPTY_STACK_TRACE| |
|RuntimePermission| SUBCLASS_IMPLEMENTATION_PERMISSION| |
|class|Caches||
|UncaughtExceptionHandler|defaultExceptionhandler||
|long|threadLocalRandomSeed||
|int|threadLocalRandomProbe||
|int|threadLocalRandomSecondarySeed||

## 线程的生命周期

    在Java虚拟机 中，线程从最初的创建到最终的消亡，要经历若干个状态：创建(new)、就绪(runnable/start)、运行(running)、阻塞(blocked)、等待(waiting)、时间等待(time waiting) 和 消亡(dead/terminated)。
    在给定的时间点上，一个线程只能处于一种状态，各状态的含义如下图所示：
   ![](https://raw.githubusercontent.com/a347807131/ms/master/images/20200118100458.png)

### 解释：

- 创建:程创建之后，不会立即进入就绪状态，因为线程的运行需要一些条件（比如程序计数器、Java栈、本地方法栈等）。
- 就绪:只有线程运行需要的所有条件满足了，才进入就绪状态。不代表立刻就能获取CPU执行时间，也许此时CPU正在执行其他的事情，因此它要等待。
- 运行:当得到CPU执行时间之后，线程便真正进入运行状态。行状态过程中，可能有多个原因导致当前线程不继续运行下去，比如用户主动让线程睡眠（睡眠一定的时间之后再重新执行）、用户主动让线程等待，或者被同步块阻塞，此时就对应着多个状态：time waiting（睡眠或等待一定的时间）、waiting（等待被唤醒）、blocked（阻塞）。
- 消亡:当由于突然中断或者子任务执行完毕，线程就会被消亡。
<br>

## 创建线程的方法

```java
public class ThreadTest {

    public static void main(String[] args) {

        //使用继承Thread类的方式创建线程
        new Thread(){
            @Override
            public void run() {
                System.out.println("Thread");
            }
        }.start();

        //使用实现Runnable接口的方式创建线程
        Thread thread = new Thread(new Runnable() {
            @Override
            public void run() {
                System.out.println("Runnable");
            }
        });
        thread.start();

        //JVM 创建的主线程 main
        System.out.println("main");
    }
}/* Output: (代码的运行结果与代码的执行顺序或调用顺序无关)
        Thread
        main
        Runnable
 *///:~
```

## 线程相关比较重要的方法

### start()

    创建好自己的线程类之后，就可以创建线程对象了，然后通过start()方法去启动线程。
    通过start()方法启动一个线程之后，若线程获得了CPU执行时间，便进入run()方法体去执行具体的任务。如果用户直接调用run()方法，即相当于在主线程中执行run()方法，跟普通的方法调用没有任何区别，此时并不会创建一个新的线程来执行定义的任务。
    实际上，start()方法的作用是通知 “线程规划器” 该线程已经准备就绪，以便让系统安排一个时间来调用其 run()方法，也就是使线程得到运行。

### run()

    自定义的执行方法实体，在线程执行该线程时，会执行该方法体中的内容

一般来说，有两种方式可以达到重写run()方法的效果：
  - 直接重写：直接继承Thread类并重写run()方法；
  - 间接重写：通过Thread构造函数传入Runnable对象 (注意，实际上重写的是 Runnable对象 的run() 方法)。


### sleep()

    作用是在指定的毫秒数内让当前正在执行的线程（即 currentThread() 方法所返回的线程）睡眠，并交出 CPU 让其去执行其他的任务。
    调用sleep方法相当于让线程进入阻塞状态。

注意：
  - 如果调用了sleep方法，必须捕获InterruptedException异常或者将该异常向上层抛出；
  - sleep方法不会释放锁，也就是说如果当前线程持有对某个对象的锁，则即使调用sleep方法，其他线程也无法访问这个对象。

### yield()

> 调用 yield()方法会让当前线程交出CPU资源，让CPU去执行其他的线程。但是，yield()不能控制具体的交出CPU的时间。

### 源码注释中比较重要的几点

- Yield是一个静态的原生(native)方法。
- Yield告诉当前正在执行的线程把运行机会交给线程池中拥有相同优先级的线程。
- Yield不能保证使得当前正在运行的线程迅速转换到可运行的状态。
- 仅能使一个线程从运行状态转到可运行状态，而不是等待或阻塞状态.

注意:
  - yield()方法只能让 拥有**相同优先级**的线程 有获取 CPU 执行时间的机会。
  - 调用yield()方法并不会让线程进入阻塞状态，而是让线程重回就绪状态，它只需要等待重新得到 CPU 的执行。
  - 它同样不会释放锁。

参考代码
```java
public class YieldTest{
    @Test
    public void t1(){
        new Thread(() -> {
            long beginTime = System.currentTimeMillis();
            int count = 0;
            for (int i = 0; i < 50000; i++) {
                Thread.yield();             // 将该语句注释后，执行会变快
                count = count + (i + 1);
            }
            long endTime = System.currentTimeMillis();
            System.out.println("用时：" + (endTime - beginTime) + "毫秒！");
        });
    }
}
```

### join()

    由于 join方法 会调用 wait方法 让宿主线程进入阻塞状态，并且会释放线程占有的锁，并交出CPU执行权限。

### interrupt()

    单独调用interrupt方法可以使得 处于阻塞状态的线程 抛出一个异常，也就是说，它可以用来中断一个正处于阻塞状态的线程；另外，通过 interrupted()方法 和 isInterrupted()方法 可以停止正在运行的线程。

问题:interrupt()只能中断一个阻塞状态下的线程，是否有办法阻断一个运行中的线程

###

## 死锁的出现

    在使用 suspend 和 resume 方法时，如果使用不当，极易造成公共的同步对象的独占，使得其他线程无法得到公共同步对象锁，从而造成死锁。
示例:
```java
public class MyThread extends Thread {

    private long i = 0;

    @Override
    public void run() {
        while (true) {
            i++;
            System.out.println(i);
        }
    }

    public static void main(String[] args) {
        try {
            MyThread thread = new MyThread();
            thread.start();
            Thread.sleep(1);
            thread.suspend();
            System.out.println("main end!");
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
```

## 线程优先级

    优先级代表cpu调度时获得cpu时间的几率大小，线程的优先级具有一定的规则性，也就是CPU尽量将执行资源让给优先级比较高的线程。特别地，高优先级的线程总是大部分先执行完，但并不一定所有的高优先级线程都能先执行完。
    在 Java 中，线程的优先级具有继承性，比如 A 线程启动 B 线程， 那么 B 线程的优先级与 A 是一样的。

## 守护进程

    在 Java 中，线程可以分为两种类型，即用户线程和守护线程。
    任何一个守护线程都是整个JVM中所有非守护线程的保姆，只要当前JVM实例中存在任何一个非守护线程没有结束，守护线程就在工作；只有当最后一个非守护线程结束时，守护线程才随着JVM一同结束工作。

## 相关参考资料

- volatile https://www.cnblogs.com/dolphin0520/p/3920373.html
- thread https://blog.csdn.net/justloveyou_/article/details/54347954