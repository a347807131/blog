---
title: linux
date: 2020-01-03 14:37:06
tags:
categories:
mathjax:
---
**摘要**
>

<!--more-->

获取root权限

```bash
$ sudo su
```

### apt安装yarn

On Debian or Ubuntu Linux, you can install Yarn via our Debian package repository. You will first need to configure the repository:

```bash
$ curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
$ echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
```

然后，安装

```bash
sudo apt-get update && sudo apt-get install yarn
```



