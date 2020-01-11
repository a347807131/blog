---
title: JHipster
date: 2020-01-03 14:21:59
tags:
categories: 类库工具
mathjax:
---
**摘要**
>

<!--more-->

```bash
$ docker container run --name jh-registry -e \ JHIPSTER.SECURITY.AUTHENTICATION.JWT.SECRET=dkk20dldkf0209342334 -d -p 8761:8761 jhipster/jhipster-registry
```



## Local installation with Yarn (alternative to NPM)

### Quick setup

This is the same procedure as using NPM, with two differences:

1. Instead of upgrading NPM in step 3, install Yarn from [the Yarn website](https://yarnpkg.com/en/docs/install)

2. Use

   ```bash
   $yarn global add
   ```

   instead of

    

   ```bash
   $npm install -g
   ```

   , for example:

   - To install Yeoman, type: `yarn global add yo`
   - To install JHipster, type: `yarn global add generator-jhipster`



## Usage on Linux/Mac Windows (using Docker Toolbox)

#### Pull the image

Pull the latest JHipster Docker image:

```bash
$docker image pull jhipster/jhipster
```

Pull the development JHipster Docker image:

```bash
$ docker image pull jhipster/jhipster:master
```

You can see all tags [here](https://hub.docker.com/r/jhipster/jhipster/tags/)

#### Run the image

> *Warning:* If you are using Docker Machine on Mac or Windows, your Docker daemon has only limited access to your OS X or Windows file system. Docker Machine tries to auto-share your /Users (OS X) or C:\Users\<username> (Windows) directory. So you have to create the project folder under these directory to avoid any volume mounting issues.

Create a “jhipster” folder in your home directory:

```
mkdir ~/jhipster
```

Run the Docker image, with the following options:

- The Docker “/home/jhipster/app” folder is shared to the local “~/jhipster” folder
- Forward all ports exposed by Docker (8080 for the Java application, 9000 for BrowserSync, 3001 for the BrowserSync UI)

```bash
docker container run --name jhipster -v ~/jhipster:/home/jhipster/app -v ~/.m2:/home/jhipster/.m2 -p 8080:8080 -p 9000:9000 -p 3001:3001 -d -t jhipster/jhipster
```



## Jhipster下一个mvn插件的问题

> 原文链接：https://blog.csdn.net/chaijunkun/article/details/93067786

### 简介

frontend-maven-plugin是一个将maven与nodejs结合的插件，旨在maven生命周期中帮你下载并且本地（相对于项目来说）安装一份node和npm，并且执行npm install命令，并且还能执行其他的组合命令例如：Bower, Grunt, Gulp, Jspm, Karma, 或者 Webpack. 支持Windows, OS X 和Linux. 然而在默认情况下，在下载nodejs和npm时会报如下错误：

```
[ERROR] Failed to execute goal com.github.eirslett:frontend-maven-plugin:1.6:install-node-and-npm (install node and npm) on project XXX:
 Could not download Node.js: Could not download https://nodejs.org/dist/v9.11.1/node-v9.11.1-linux-x64.tar.gz:
  sun.security.validator.ValidatorException: PKIX path building failed: 
  sun.security.provider.certpath.SunCertPathBuilderException:
  unable to find valid certification path to requested target -> [Help 1]
12345
```

产生该问题的原因在于本地访问nodejs官方网站的过程当中SSL校验被破坏（本人测试似乎与公司网络有关系）。

### 解决方法

该maven插件默认使用了SSL校验机制，所以要么禁用该机制，要么将下载链接改一下。

```
<execution>
	<id>install node and npm</id>
	<goals>
		<goal>install-node-and-npm</goal>
	</goals>
	<configuration>
		<nodeDownloadRoot>http://nodejs.org/dist/</nodeDownloadRoot>
		<npmDownloadRoot>http://registry.npmjs.org/npm/-/</npmDownloadRoot>
		<nodeVersion>v9.11.1</nodeVersion>
	</configuration>
</execution>
1234567891011
```

在install-node-and-npm环节，增加配置：nodeDownloadRoot和npmDownloadRoot配置，并且将协议限制为http，而非使用默认的https（当然，安全性可能会引发问题，请酌情使用）。

2019年7月8日补充：当然，由于众所周知的原因，国内下载npm有可能会比较慢，所以也可以在npmDownloadRoot参数中配置淘宝的npm镜像：[https://registry.npm.taobao.org](https://registry.npm.taobao.org/)，如果依然遇到该问题，也可以同样尝试使用http协议

### 参考资料

关于本问题的解决方法参考了：https://github.com/eirslett/frontend-maven-plugin/issues/278
插件更多使用技巧，请参阅：https://blog.csdn.net/weixin_34130269/article/details/86974309

 