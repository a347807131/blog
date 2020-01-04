---
title: dcker命令
date: 2020-01-03 14:40:42
tags:
categories:
mathjax:
---
**摘要**
>详细讲解地址：<https://www.runoob.com/docker/docker-command-manual.html>

<!--more-->

- ## 国内镜像地址

  - [docker官网中国区镜像](https://www.docker-cn.com/)
     `--registry-mirror=https://registry.docker-cn.com`
  - [网易163 docker镜像](https://c.163.com/product/service) **未使用,请自行判断**
     `--registry-mirror=http://hub-mirror.c.163.com`
  - [USTC镜像加速](https://lug.ustc.edu.cn/wiki/mirrors/help/docker)
     `--registry-mirror=https://docker.mirrors.ustc.edu.cn`
  - [daocloud镜像](https://www.daocloud.io/) **需注册**
     `--registry-mirror=http://{your_id}.m.daocloud.io`
  - [alicloud](https://jsfun.info/archive/docker在国内使用的加速配置/) **注册后有自己的加速地址**
     `--registry-mirror=https://{your_id}.mirror.aliyuncs.com`

  

  作者：Sunnky
  链接：https://www.jianshu.com/p/b5006ebf1522
  来源：简书
  著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

![](https://img2018.cnblogs.com/blog/1100338/201810/1100338-20181014202945937-1677031749.png)

```bash
$ docker pull [image name]<:version no>
#查看本地镜像
$ docker images
#查看本地运行的容器 -a表示包括未运行的容器
$docker ps <-a>

#启动、停止和重启
$docker start [container_name]/[container_id]
$docker restart [container_name]/[container_id]
$docker stop [container_name]/[container_id]

#进入容器
$docker attach [container_name]/[container_id]
#运行这个容器中的镜像的话，并且调用镜像里面的 bash
$docker run -t -i container_name/container_id /bin/bash
```



## DockerFile

Dockerfile` 是由一行行命令语句组成，并且支持已 `# 开头的注释行。DockerFile中所有命令都是`INSTROCTION argument`，即不区分大小写。

一般来说，我们可以将 `Dockerfile` 分为四个部分：

- 基础镜像(父镜像)信息指令 `FROM`
- 维护者信息指令 `MAINTAINER`
- 镜像操作指令 `RUN` 、 `EVN` 、 `ADD` 和 `WORKDIR` 等
- 容器启动指令 `CMD` 、 `ENTRYPOINT` 和 `USER` 等

示例：

```dockerfile

FROM python:2.7
MAINTAINER Angel_Kitty <angelkitty6698@gmail.com>
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt
EXPOSE 5000
ENTRYPOINT ["python"]
CMD ["app.py"]
```

### FROM

`FROM` 是用于指定基础的 `images` ，一般格式为 `FROM ` or `FORM :` ，所有的 `Dockerfile` 都用该以 `FROM` 开头，`FROM` 命令指明 `Dockerfile` 所创建的镜像文件以什么镜像为基础，`FROM` 以后的所有指令都会在 `FROM` 的基础上进行创建镜像。可以在同一个 `Dockerfile` 中多次使用 `FROM` 命令用于创建多个镜像。

```dockerfile
FROM python:2.7
```

### MAINTAINER

MAINTAINER 是用于指定镜像创建者和联系方式，一般格式为 `MAINTAINER ` 。

```dockerfile
MAINTAINER [Angel_Kitty] <angelkitty6698@gmail.com>
```

### COPY

`COPY` 是用于复制本地主机的 `` (为 Dockerfile 所在目录的相对路径)到容器中的 ``。当使用本地目录为源目录时，推荐使用 `COPY` 。一般格式为 `COPY ` 。例如我们要拷贝当前目录到容器中的 `/app` 目录下，我们可以这样操作：

```dockerfile
COPY . /app
```

### WORKDIR

`WORKDIR` 用于配合 `RUN`，`CMD`，`ENTRYPOINT` 命令设置当前工作路径。可以设置多次，如果是相对路径，则相对前一个 `WORKDIR` 命令。默认路径为`/`。一般格式为 `WORKDIR /path/to/work/dir` 。例如我们设置`/app` 路径，我们可以进行如下操作：

```dockerfile
WORKDIR /app
```

### RUN

`RUN` 用于容器内部执行命令。每个 `RUN` 命令相当于在原有的镜像基础上添加了一个改动层，原有的镜像不会有变化。一般格式为 `RUN ` 。例如我们要安装 `python` 依赖包，我们做法如下：

```dockerfile
RUN pip install -r requirements.txt
```

### EXPOSE

EXPOSE` 命令用来指定对外开放的端口。一般格式为 `EXPOSE  [...]。

例如上面那个例子，开放5000端口：

```dockerfile
EXPOSE 5000
```

### ENTRYPOINT

`ENTRYPOINT` 可以让你的容器表现得像一个可执行程序一样。一个 `Dockerfile` 中只能有一个 `ENTRYPOINT`，如果有多个，则最后一个生效。

ENTRYPOINT命令有两种形式

```dockerfile
ENTRYPOINT ["executable", "param1", "param2"] #：推荐使用的 exec形式
ENTRYPOINT command param1 param2 #：shell 形式
```

例如下面这个，我们要将 `python` 镜像变成可执行的程序，我们可以这样去做：

```dockerfile
ENTRYPOINT ["python"]
```

### CMD

`CMD` 命令用于启动容器时默认执行的命令，`CMD` 命令可以包含可执行文件，也可以不包含可执行文件。不包含可执行文件的情况下就要用 `ENTRYPOINT` 指定一个，然后 `CMD` 命令的参数就会作为`ENTRYPOINT`的参数。

CMD有三种格式：

```dockerfile
CMD ["executable","param1","param2"]#：推荐使用的 exec 形式。
CMD ["param1","param2"]#：无可执行程序形式
CMD command param1 param2#：shell 形式。
```

一个 `Dockerfile` 中只能有一个`CMD`，如果有多个，则最后一个生效。而 `CMD` 的 `shell` 形式默认调用 `/bin/sh -c` 执行命令。

`CMD` 命令会被 `Docker` 命令行传入的参数覆盖：`docker run busybox /bin/echo Hello` `Docker` 会把 `CMD` 里的命令覆盖。

例如我们要启动 `/app` ，我们可以用如下命令实现：

```dockerfile
CMD ["app.py"]
```
