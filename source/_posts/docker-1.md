---
title: Dcker系列(2):dcker命令
date: 2020-01-03 14:40:42
tags:
categories:
- 工具及框架
- Docker系列
mathjax:
---
**摘要**
>详细讲解地址：<https://www.runoob.com/docker/docker-command-manual.html>

<!--more-->

# 命令总览

![](https://img2018.cnblogs.com/blog/1100338/201810/1100338-20181010205425908-509725301.jpg)

![](https://img2018.cnblogs.com/blog/1100338/201810/1100338-20181014202945937-1677031749.png)

![lIgpp6.png](https://s2.ax1x.com/2020/01/11/lIgpp6.png)

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

### 快速刪除容器和镜像

刪除全部容器

```bash
docker rm $(docker ps -aq)
```

一条命令实现停用并删除容器：

```
docker stop $(docker ps -q) & docker rm $(docker ps -aq)
```



## Docker-machine

> https://www.jianshu.com/p/a40c07f9f456

```bash
#!/bin/bash

# 本脚本用于优化虚拟机的docker镜像源，修改为与localhost一样的中科大源
for NODE in `seq 1 5`
do
  docker-machine scp /etc/docker/daemon.json node-${NODE}:/home/docker
  docker-machine ssh node-${NODE} 'sudo mv /home/docker/daemon.json /etc/docker/daemon.json && sudo chown root:root /etc/docker/daemon.json && sudo kill -SIGHUP $(pidof dockerd)'
done
```

