---
title: 'Docker系列(1):Docker在ubuntu系统下的安装'
tags: docker
categories:
  - 计算机科学
  - docker
date: 2020-01-03 13:21:11
mathjax:
---
**摘要**

>收录了Docker官网的教程

<!--more-->

![](https://img2018.cnblogs.com/blog/1100338/201810/1100338-20181012214101184-1339527466.jpg)



### 移除旧版本

```bash
#remove old version
$ sudo apt-get remove docker docker-engine docker.io
```



## 安装Docker CE的方式

You can install Docker CE in different ways, depending on your needs:

- Most users [set up Docker’s repositories](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-using-the-repository) and install from them, for ease of installation and upgrade tasks. This is the recommended approach.
- Some users download the DEB package and [install it manually](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-from-a-package) and manage upgrades completely manually. This is useful in situations such as installing Docker on air-gapped systems with no access to the internet.
- In testing and development environments, some users choose to use automated [convenience scripts](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-using-the-convenience-script) to install Docker.



## 以仓库的形式安装

Before you install Docker CE for the first time on a new host machine, you need to set up the Docker repository. Afterward, you can install and update Docker from the repository.

#### SET UP THE REPOSITORY

1. Update the `apt` package index:

   ```bash
   $ sudo apt-get update
   ```

2. Install packages to allow `apt` to use a repository over HTTPS:

   ```bash
   $ sudo apt-get install \
       apt-transport-https \
       ca-certificates \
       curl \
       software-properties-common
   ```

3. Add Docker’s official GPG key:

   ```
   $curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
   ```

   Verify that you now have the key with the fingerprint `9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88`, by searching for the last 8 characters of the fingerprint.

   ```bash
   $ sudo apt-key fingerprint 0EBFCD88
   
   pub   4096R/0EBFCD88 2017-02-22
         Key fingerprint = 9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
   uid                  Docker Release (CE deb) <docker@docker.com>
   sub   4096R/F273FCD8 2017-02-22
   ```

4. Use the following command to set up the **stable** repository

   ```bash
   $ sudo add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) \
      stable"
   ```

#### INSTALL DOCKER CE

1. Update the `apt` package index.

   ```bash
   $ sudo apt-get update
   ```

2. Install the latest version of Docker CE, or go to the next step to install a specific version. Any existing installation of Docker is replaced.

   ```bash
   $ sudo apt-get install docker-ce
   ```

3. Verify that Docker CE is installed correctly by running the `hello-world` image.

   ```bash
   $ sudo docker run hellow-world
   ```

## 用更为便利的脚本安装

The scripts require `root` or `sudo` privileges in order to run. 

```bash
$ curl -fsSL get.docker.com -o get-docker.sh
$ sudo sh get-docker.sh
```



## Uninstall Docker CE

1. Uninstall the Docker CE package:

   ```
   $ sudo apt-get purge docker-ce
   ```

2. Images, containers, volumes, or customized configuration files on your host are not automatically removed. To delete all images, containers, and volumes:

   ```
   $ sudo rm -rf /var/lib/docker
   ```

You must delete any edited configuration files manually.