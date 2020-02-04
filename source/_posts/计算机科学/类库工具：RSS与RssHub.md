title: 类库工具：RSS与RssHub
date: 2020-02-04 22:55:50
tags:
categories:
mathjax:
---
## 前言

这两天翻看大佬Diygod的开源项目，翻到一项收藏上万名叫`rsshub`的东西，后来再查查文档，倒腾倒腾，顿时发现了新世界。感觉有了一种十分方便且有效的信息获取途径，告别以前繁琐的信息获取过程。然后产生了把`rss`相关的内容做个笔记的想法，于是就有了这篇内容。

---

## 什么是RSS

> [简易信息聚合](https://baike.baidu.com/item/简易信息聚合)（也叫聚合内容）是一种RSS基于[XML](https://baike.baidu.com/item/XML)标准，在互联网上被广泛采用的内容包装和投递协议。
>
> RSS(Really Simple Syndication)是一种描述和同步[网站](https://baike.baidu.com/item/网站)内容的格式，是使用最广泛的XML应用。RSS搭建了[信息](https://baike.baidu.com/item/信息/111163)迅速传播的一个技术平台，使得每个人都成为潜在的信息提供者。
>
> 发布一个RSS文件后，这个RSS Feed中包含的信息就能直接被其他站点调用，而且由于这些数据都是标准的XML格式，所以也能在其他的[终端](https://baike.baidu.com/item/终端/1903878)和服务中使用，是一种描述和同步网站内容的格式。

> RSS广泛用于网上新闻频道，[blog](https://baike.baidu.com/item/blog/8086465)和wiki，主要的版本有0.91, 1.0, 2.0。使用RSS订阅能更快地获取信息，网站提供RSS输出，有利于让用户获取网站内容的最新更新。

——摘选自[百度百科][1]



## 什么又是RssHub

> RSSHub 是一个开源、简单易用、易于扩展的 RSS 生成器，可以给任何奇奇怪怪的内容生成 RSS 订阅源。RSSHub 借助于开源社区的力量快速发展中，目前已适配数百家网站的上千项内容。
>
> 可以配合浏览器扩展 [RSSHub Radar](https://github.com/DIYgod/RSSHub-Radar) 食用。

——摘选自 https://docs.rsshub.app/

### 它能做什么

简单来讲`rsshub`是一个基于`nodejs`开发的web应用服务器，它北部不封装了用于获取应用网站的内容，其结果保存在以基于`xml`标准文档中，拿到了该文档，也就拿到了应用网站中的内容链接和摘要。由于当下多数网站基于各种原因不再以`rss`来做内容推送，(关于`rss`衰落的讨论可参见[这里][2])，所以很多网站都不支持rss订阅，自然就无法通过抓取xml文档来获取网站内容。

而`rsshub`就解决了这类问题，它根据访问的`uri`链接，判断需要爬取的是哪一个目标网站，然后根据然后对应的封装的路由规则取爬取目标页面，然后生成xml文档。

![示例路由](https://raw.githubusercontent.com/a347807131/ms/master/images/20200205010309.png)

而对于我们来讲，我们需要做的就是使用rss阅读器订阅这些链接，在订阅之后，阅读器会定期的取请求这些链接，以此获取最新的内容，而如果有新内容，阅读器就会推送给我们。

而要查找支持的网站和对应的路由就需要到[rsshub,app](https://docs.rsshub.app/)查找，然后根据路由规则添加到rss阅读器中了。

## RSS阅读器推荐

### Reeder

### Feedly

> ### Readkit
>
> 单从仍是拟物风格的图标就能看出，ReadKit 同样是一款「老字号」应用了。不过，ReadKit 的界面早已焕新，与 macOS 原生设计相仿。除了 Feedly、NewsBlur、Fever 等 RSS 服务外，ReadKit 还支持添加并浏览 Instapaper、Pocket 和 Pinboard 等稍后阅读服务，成为你的一站式阅读管理工具。
>
> ![](https://pic4.zhimg.com/80/v2-7c9c97060afae01c693c63bd3b300b39_hd.jpg)
>
> ## **Cappuccino**
>
> Cappuccino 是一款跨 macOS 和 iOS 双平台的 RSS 阅读器，来自知名的邮件客户端 Airmail 的开发商。除了那些标配特性外，它还有一个独具特色的功能，就是支持将订阅内容更新生成邮件，每天发送到你设置的邮箱，不打开应用也能了解新鲜事。你还可以为每个订阅源单独开启或关闭通知，只关注重要内容。
>
> ![](https://pic3.zhimg.com/80/v2-1648ebee80712db106c0a9988b1a6501_hd.jpg)
>
> 如果你只想获知部分重要内容更新，或者用邮箱管理订阅，可以在 [App Store](https://link.zhihu.com/?target=https%3A//itunes.apple.com/cn/app/cappuccino/id1286725949%3Fmt%3D12) 以 60 元的价格购买 Cappuccino 的 macOS 版，应用同时包含在 [Setapp](https://link.zhihu.com/?target=https%3A//setapp.sjv.io/c/1249877/344537/5114) 订阅中。
>
> ### **RSS 追踪**
>
> 「RSS 追踪」提供了清晰明确的界面层级、便捷的订阅源获取方式，以及独具平台特色的 Timeline 与 OneDrive 同步方式。应用既支持手动输入订阅源，也可以通过 Feedly 服务进行关键词搜索或导入 OPML 文件。

> 作者：少数派
> 链接：https://www.zhihu.com/question/28808592/answer/866134265
> 来源：知乎
> 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

## RSS阅读源收录

你必读的 RSS 订阅源有哪些？ - 知乎用户的回答 - 知乎 https://www.zhihu.com/question/19580096/answer/574717640

【可能是目前最全的RSS订阅源了】导读 继上一篇文章《当我们谈论RSS时，我们在谈论什么？ 》发布后，阅读甚少，反响也是平平。奶酪不得不承认一个事实，RSS 做为一种…@奔跑中的奶酪 https://www.runningcheese.com/rss-subscriptions#m

[1]: https://baike.baidu.com/item/rss/24470?fr=aladdin	"百度百科"
[2]: https://www.zhihu.com/question/54729057?sort=created