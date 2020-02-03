---
title: 系统环境及依赖清单
tags:
  - 清单
  - windows
  - linux
categories:
  - 清单
date: 2020-01-03 13:21:11
mathjax:
---
**摘要**

>记录个人电脑使用中需要配置的环境和工具

<!--more-->

## windows系统

### scoop直接管理

| 名称         | 描述                             | `scoop`安装       |      |
| :----------- | :------------------------------- | ----------------- | ---- |
| sccop        | windows下的包管理器              |                   |      |
| Java         |                                  | openjdk           |      |
| aria2        |                                  |                   |      |
| toolbox app  | jetbtain公式的idea开发工具管理器 | jetbrains-toolbox |      |
| python       |                                  |                   |      |
| chrome       | 浏览器                           |                   |      |
| typora       | md编辑器                         |                   |      |
| ngrok        | 内网穿透工具                     |                   |      |
| MobaXterm    | shell                            | mobaxterm         |      |
| virtualbox   |                                  |                   |      |
| nodejs       |                                  |                   |      |
| git          |                                  |                   |      |
| picgo        | 图床工具                         |                   |      |
| sublime-text |                                  |                   |      |
|              |                                  |                   |      |
|              |                                  |                   |      |
|              |                                  |                   |      |
|              |                                  |                   |      |
|              |                                  |                   |      |

### 间接管理

| 名称       | 描述           | 安装                  |
| ---------- | -------------- | --------------------- |
| hexo       | hexo博客脚手架 | `npm install -g hexo` |
| scrapy     | 爬虫框架       | `pip`                 |
| jhipster   |                |                       |
| virtualenv |                | `pip`                 |
|            |                |                       |
|            |                |                       |
|            |                |                       |
|            |                |                       |
|            |                |                       |



### 安装包

| 名称      | 描述             | 官网地址                             |      |
| --------- | ---------------- | ------------------------------------ | ---- |
| 钉钉      |                  | https://www.dingtalk.com/            |      |
| 微信      |                  | https://weixin.qq.com/               |      |
| Mathpix   | 公式图片识别软件 | https://mathpix.com/                 |      |
| Matlap    |                  | https://ww2.mathworks.cn/            |      |
| Photoshop |                  |                                      |      |
| Axure     |                  | https://www.axure.com.cn/            |      |
| magnetW   |                  | https://github.com/xiandanin/magnetW |      |
| Motrix    | download manager | https://github.com/agalwood/Motrix   |      |
|           |                  |                                      |      |

## 镜像源设置

### pip

```bash
# https://mirrors.ustc.edu.cn/pypi/web/simple
$pip config set global.index-url [url] 
```

### apt

> 1.原文件备份
>
> ```bash
> sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
> ```
>
> 2.编辑源列表文件
>
> ```bash
> sudo vim /etc/apt/sources.list
> ```
>
> 3.将原来的列表删除，添加如下内容（中科大镜像源）
>
> ```bash
> deb http://mirrors.ustc.edu.cn/ubuntu/ xenial main restricted universe multiverse
> deb http://mirrors.ustc.edu.cn/ubuntu/ xenial-security main restricted universe multiverse
> deb http://mirrors.ustc.edu.cn/ubuntu/ xenial-updates main restricted universe multiverse
> deb http://mirrors.ustc.edu.cn/ubuntu/ xenial-proposed main restricted universe multiverse
> deb http://mirrors.ustc.edu.cn/ubuntu/ xenial-backports main restricted universe multiverse
> deb-src http://mirrors.ustc.edu.cn/ubuntu/ xenial main restricted universe multiverse
> deb-src http://mirrors.ustc.edu.cn/ubuntu/ xenial-security main restricted universe multiverse
> deb-src http://mirrors.ustc.edu.cn/ubuntu/ xenial-updates main restricted universe multiverse
> deb-src http://mirrors.ustc.edu.cn/ubuntu/ xenial-proposed main restricted universe multiverse
> deb-src http://mirrors.ustc.edu.cn/ubuntu/ xenial-backports main restricted universe multiverse
> ```
>
> 4、运行`sudo apt-get update`
>
> ————————————————
> 版权声明：本文为CSDN博主「zgljl2012」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。
> 原文链接：https://blog.csdn.net/zgljl2012/article/details/79065174/

### Maven

在settings.xml中添加镜像设置

> 
>
> ```xml
> <mirrors>
> 	<mirror>
>         <id>alimaven</id>
>         <name>aliyun maven</name>
>         <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
>         <mirrorOf>central</mirrorOf>
>     </mirror>
>     <mirror>
>         <id>central</id>
>         <name>Maven Repository Switchboard</name>
>         <url>http://repo1.maven.org/maven2/</url>
>         <mirrorOf>central</mirrorOf>
>     </mirror>
>     <mirror>
>         <id>repo2</id>
>         <mirrorOf>central</mirrorOf>
>         <name>Human Readable Name for this Mirror.</name>
>         <url>http://repo2.maven.org/maven2/</url>
>     </mirror>
>     <mirror>
>         <id>ibiblio</id>
>         <mirrorOf>central</mirrorOf>
>         <name>Human Readable Name for this Mirror.</name>
>         <url>http://mirrors.ibiblio.org/pub/mirrors/maven2/</url>
>     </mirror>
>     <mirror>
>         <id>jboss-public-repository-group</id>
>         <mirrorOf>central</mirrorOf>
>         <name>JBoss Public Repository Group</name>
>         <url>http://repository.jboss.org/nexus/content/groups/public</url>
>     </mirror>
>     <!-- 中央仓库在中国的镜像 -->
>     <mirror>
>         <id>maven.net.cn</id>
>         <name>oneof the central mirrors in china</name>
>         <url>http://maven.net.cn/content/groups/public/</url>
>         <mirrorOf>central</mirrorOf>
>     </mirror>
> </mirrors>
> ```

### npm

> 1、查看npm源地址
>  `npm config list`
>
> 结果:
>  `metrics-registry = "http://registry.npm.taobao.org/"`
>
> 2、修改registry地址，比如修改为淘宝镜像源。
>  `npm set registry https://registry.npm.taobao.org/`
>  如果有一天你肉身FQ到国外，用不上了，用rm命令删掉它
>  `npm config rm registry`
>
> 
>
> 作者：四月天__
> 链接：https://www.jianshu.com/p/66f97cadd1eb
> 来源：简书
> 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

### Docker

**一些镜像地址**

```json
Docker 官方中国区
https://registry.docker-cn.com
网易
http://hub-mirror.c.163.com
ustc
https://docker.mirrors.ustc.edu.cn
```



直接设置 –registry-mirror 参数，仅对当前的命令有效 

```bash
$ docker run hello-world --registry-mirror=https://docker.mirrors.ustc.edu.cn
```

 推荐使用 json 配置文件的方式，默认为 /etc/docker/daemon.json，非默认路径需要修改 dockerd 的 –config-file，在该文件中加入如下内容： 

```jso
{ "registry-mirrors": ["https://docker.mirrors.ustc.edu.cn"] }
```

### yarn

临时更改

```bash
yarn save 包的名字 --registry https://registry.npm.taobao.org/
```

全局更改

```bash
yarn config set registry https://registry.npm.taobao.org/
```

### Docker

编辑/etc/docker/daemon.json文件，并输入docker-cn镜像源地址

```bash
sudo vim /etc/docker/daemon.json
```

```json
{
  "registry-mirrors": ["https://registry.docker-cn.com"]
}
```

