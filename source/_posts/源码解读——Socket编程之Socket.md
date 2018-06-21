---
title: 源码解读——Socket编程之Socket(后续补充)
tags: 源码解读
date: 2018-06-19 18:54:05
---


## 类图
![Socket](https://raw.githubusercontent.com/a347807131/blog/master/ms/uml/Socket.png)

接口方法
```java
//用于关闭流并且释放相关的系统资源，如果资源已近关闭，调用该方法不会有任何影响。
public void close() throws IOException;
```

## 简介
> 该类实现了`Socket Client`，该类的具体实现实际上是由`SocketImpl`类的实例所实现的。
> 通过socket工厂，它可以配置自身来创建一个适合于本地防火墙的Socket。

## 成员变量

- Socket状态变量

|修饰符|类型|变量名|默认值|说明|
|---|---|---|---|---|
|private|boolean|created|false|是否已创建|
|private|boolean|bound|false|是否已绑定端口|
|private|boolean|connected|false|是否已连接|
|private|boolean|closed|false|是否已关闭|
|private|Object|closeLock|new Object|对象锁|
|private|boolean|shutIn|falses|是否已介入|
|private|boolean|ShutOut|fasle|是否已被挂起|

- 静态成员变量

|修饰符|类型|变量名|默认值|说明|
|---|---|---|---|---|
|private static|SocketImpl|factory|null|套接字工厂|
|private static|Set<SocketOption<?>>|options||Socket|
|private static|boolean|optionSet|false||

- 其它相关变量

|修饰符|类型|变量名|默认值|说明|
|---|---|---|---|---|
||SocketImpl|impl| |socket实现|
|private|boolean|oldImpl|false|是否使用原实现|

## 相关方法

### 构造方法

默认构造方法
```java
    /**
     * 根据系统默认的socketImpl创建一个未连接的套接字
     *
     * @since   1.1
     * @revised 1.4
     */
     public Socket() {
         setImpl();
     }
    /**
     * @since 1.4
     */
    void setImpl() {
        if (factory != null) {
            impl = factory.createSocketImpl();
            checkOldImpl();
        } else {
            // No need to do a checkOldImpl() here, we know it's an up to date
            // SocketImpl!
            impl = new SocksSocketImpl();
        }
        if (impl != null)
            impl.setSocket(this);
    }
```
其它构造方法
```java
    /**
     * 根据代理对象来创建代理Socket
     * @since   1.5
     */
    public Socket(Proxy proxy){}
    //根据SocketImpl创建Socket
    protected Socket(SocketImpl impl) throws SocketException {
        this.impl = impl;
        if (impl != null) {
            checkOldImpl();
            this.impl.setSocket(this);
        }
    }
    /**
     *根据主机名和端口创建Socket
     */
    public Socket(String host, int port)
        throws UnknownHostException, IOException
    {
        this(host != null ? new InetSocketAddress(host, port) :
             new InetSocketAddress(InetAddress.getByName(null), port),
             (SocketAddress) null, true);
    }
    /**
     * 根据本地主机名及端口及远端主机及端口创建Socket
     */
    public Socket(String host, int port, InetAddress localAddr,
                  int localPort) throws IOException {
        this(host != null ? new InetSocketAddress(host, port) :
               new InetSocketAddress(InetAddress.getByName(null), port),
             new InetSocketAddress(localAddr, localPort), true);
    }
```
