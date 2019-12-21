---
title: HTTP协议
date: 2019-12-15 10:24:49
tags: 知识点
categories: 知识点系列
---

> 摘要
<!--more-->

## WebServer通讯过程
> HTTP通信机制是在一次完整的HTTP通信过程中，Web浏览器与Web服务器之间将完成下列7个步骤：

- 1.建立TCP连接
> 在HTTP工作开始之前，Web浏览器首先要通过网络与Web服务器建立连接，该连接是通过TCP来完成的，该协议与IP协议共同构建Internet，即著名的TCP/IP协议族，因此Internet又被称作是TCP/IP网络。HTTP是比TCP更高层次的应用层协议，根据规则，只有低层协议建立之后才能，才能进行更层协议的连接，因此，首先要建立TCP连接，一般TCP连接的端口号是80。 
- 2.Web浏览器向Web服务器发送请求命令<request-line>
> 一旦建立了TCP连接，Web浏览器就会向Web服务器发送请求命令。
例如：GET/sample/hello.jsp HTTP/1.1
- 3.浏览器发送请求头信息<headers>
> 浏览器发送其请求命令之后，还要以头信息的形式向Web服务器发送一些别的信息，之后浏览器发送了一空白行`<blank line>`来通知服务器，它已经结束了该头信息的发送。
- 4.Web服务器应答
> 客户机向服务器发出请求后，服务器会客户机回送应答，HTTP/1.1 200 OK，应答的第一部分是协议的版本号和应答状态码.
- 5.Web服务器发送应答头信息
> 正如客户端会随同请求发送关于自身的信息一样，服务器也会随同应答向用户发送关于它自己的数据及被请求的文档。
- 6.Web服务器向浏览器发送数据
> Web服务器向浏览器发送头信息后，它会发送一个空白行来表示头信息的发送到此为结束，接着，它就以Content-Type应答头信息所描述的格式发送用户所请求的实际数据
- 7.Web服务器关闭TCP连接
> 一般情况下，一旦Web服务器向浏览器发送了请求数据，它就要关闭TCP连接，然后如果浏览器或者服务器在其头信息加入了这行代码Connection:keep-alive，TCP连接在发送后将仍然保持打开状态，于是，浏览器可以继续通过相同的连接发送请求。保持连接节省了为每个请求建立新连接所需的时间，还节约了网络带宽。

## HTTP报文格式

- request
![request](https://img-blog.csdn.net/20171210212141116?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvWmVuTmFpSGVRaWFv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)
- response
![response](https://img-blog.csdn.net/20171210212147651?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvWmVuTmFpSGVRaWFv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

例子
```http
POST /index.html HTTP/1.1  
HOST: www.XXX.com  
User-Agent: Mozilla/5.0(Windows NT 6.1;rv:15.0) Firefox/15.0  
  
Username=admin&password=admin 
```

```http
HTTP/1.1 200 OK  
Content-Encoding: gzip  
Content-Type: text/html;charset=utf-8  

...HTML文本语言
```


## 状态码

- 1XX：信息提示。表示请求已被服务器接受，但需要继续处理，范围为100~101。
- 2XX：请求成功。服务器成功处理了请求。范围为200~206。
- 3XX：客户端重定向。重定向状态码用于告诉客户端浏览器，它们访问的资源已被移动，并告诉客户端新的资源位置。客户端收到重定向会重新对新资源发起请求。范围为300~305。
- 4XX：客户端信息错误。客户端可能发送了服务器无法处理的东西，比如请求的格式错误，或者请求了一个不存在的资源。范围为400~415。
- 5XX：服务器出错。客户端发送了有效的请求，但是服务器自身出现错误，比如Web程序运行出错。范围是500~505。


常见的状态码务必要熟悉：

|状态码|解释|
|---|---|
|200|客户端请求成功。        |
|302|重定向。            |
|404|请求资源不存在。        |
|400|请求语法错误，服务器无法理解。 |
|403|服务器收到请求，但拒绝提供服务。|
|500|服务器内部错误。        |
|503|服务器当前不能处理客户端请求，可能需要一段时间后才能恢复正常。|
