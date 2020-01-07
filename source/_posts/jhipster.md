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

