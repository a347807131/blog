---
title: 源码解读——Socket编程之ServerSocket
tags: 源码解读
---

## 简介

>该类实现了server sockets,`服务端套接字`,协议。该socket会等待通过网络传递过来的请求，它会根据请求信息作出一些操作，并可能会返回一个处理结果。

> 该socket的具体实现是由类, `SocketImpl`,的实例实现的。

## 