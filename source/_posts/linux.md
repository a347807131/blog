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
**摘要**

>

<!--more-->

### 获取root权限

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

### 镜像源

```html
http://mirrors.ustc.edu.cn/ubuntu/
```

备份

```bash
sudo cp /etc/apt/sources.list /etc/apt/sources.list.backup
```

编辑源码列表文件

```bash
sudo vim /etc/apt/sources.list
```

刪除原文件内容，添加新的源列表(中科大)

```bash
deb http://mirrors.ustc.edu.cn/ubuntu/ xenial main restricted universe multiverse
deb http://mirrors.ustc.edu.cn/ubuntu/ xenial-security main restricted universe multiverse
deb http://mirrors.ustc.edu.cn/ubuntu/ xenial-updates main restricted universe multiverse
deb http://mirrors.ustc.edu.cn/ubuntu/ xenial-proposed main restricted universe multiverse
deb http://mirrors.ustc.edu.cn/ubuntu/ xenial-backports main restricted universe multiverse
deb-src http://mirrors.ustc.edu.cn/ubuntu/ xenial main restricted universe multiverse
deb-src http://mirrors.ustc.edu.cn/ubuntu/ xenial-security main restricted universe multiverse
deb-src http://mirrors.ustc.edu.cn/ubuntu/ xenial-updates main restricted universe multiverse
deb-src http://mirrors.ustc.edu.cn/ubuntu/ xenial-proposed main restricted universe multiverse
deb-src http://mirrors.ustc.edu.cn/ubuntu/ xenial-backports main restricted universe multiverse
```

更更新

```bash
sudo apt-get update
```



---



## npm更改源

### 临时更改

在 npm install XXX 时加入--registry URL即可，不会影响到本地配置，如

```bash
npm --registry https://registry.npm.taobao.org install express
```

### 持久使用

永久修改本地npm的配置：

```bash
npm config set registry https://registry.npm.taobao.org
```

###  其他命令

查看npm源地址有没有换成功：

```bash
npm config get registry
```

### 重置为官方源：

```bash
npm config set registry https://registry.npmjs.org/
```

作者：章光辉_数据分析师
链接：https://www.jianshu.com/p/8e3643e3307a
来源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

---

## Windows系统下的包管理器

### Scoop安装

Make sure [PowerShell 5](https://aka.ms/wmf5download) (or later, include [PowerShell Core](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-windows?view=powershell-6)) and [.NET Framework 4.5](https://www.microsoft.com/net/download) (or later) are installed. Then run:

```powershell
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')

# or shorter
iwr -useb get.scoop.sh | iex
```

Note: if you get an error you might need to change the execution policy (i.e. enable Powershell) with

```powershell
Set-ExecutionPolicy RemoteSigned -scope CurrentUser
```

### Chocolatey安装

1. With PowerShell, you must ensure [Get-ExecutionPolicy](https://go.microsoft.com/fwlink/?LinkID=135170) is not Restricted. We suggest using `Bypass` to bypass the policy to get things installed or `AllSigned` for quite a bit more security.

   - Run `Get-ExecutionPolicy`. If it returns `Restricted`, then run `Set-ExecutionPolicy AllSigned` or `Set-ExecutionPolicy Bypass -Scope Process`.

   Now run the following command:

   ```powershell
   Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
   ```


## linux和windows环境变量的命令行操作

### windows

- 设置一个环境变量

  ```powershell
  set [varible name]=[path]
  ```

- 追加一条变量到path中

  ```powershell
  set PATH=%PATH%;[path]
  ```

- 查看一个环境变量

  ```bash
  set [varible name]
  ```

- 其它变量名及用途

  ```po
  %ALLUSERSPROFILE% 局部 返回所有“用户配置文件”的位置。
  %APPDATA% 局部 返回默认情况下应用程序存储数据的位置。
  %CD% 局部 返回当前目录字符串。
  %CMDCMDLINE% 局部 返回用来启动当前的 Cmd.exe 的准确命令行。
  %CMDEXTVERSION% 系统 返回当前的“命令处理程序扩展”的版本号。
  %COMPUTERNAME% 系统 返回计算机的名称。
  %COMSPEC% 系统 返回命令行解释器可执行程序的准确路径。
  %DATE% 系统 返回当前日期。使用与 date /t 命令相同的格式。由 Cmd.exe 生成。有关 date 命令的详细信息，请参阅 Date。
  %ERRORLEVEL% 系统 返回最近使用过的命令的错误代码。通常用非零值表示错误。
  %HOMEDRIVE% 系统 返回连接到用户主目录的本地工作站驱动器号。基于主目录值的设置。用户主目录是在“本地用户和组”中指定的。
  %HOMEPATH% 系统 返回用户主目录的完整路径。基于主目录值的设置。用户主目录是在“本地用户和组”中指定的。
  %HOMESHARE% 系统 返回用户的共享主目录的网络路径。基于主目录值的设置。用户主目录是在“本地用户和组”中指定的。
  %LOGONSEVER% 局部 返回验证当前登录会话的域控制器的名称。
  %NUMBER_OF_PROCESSORS% 系统 指定安装在计算机上的处理器的数目。
  %OS% 系统 返回操作系统的名称。Windows 2000 将操作系统显示为 Windows_NT。
  %PATH% 系统 指定可执行文件的搜索路径。
  %PATHEXT% 系统 返回操作系统认为可执行的文件扩展名的列表。
  %PROCESSOR_ARCHITECTURE% 系统 返回处理器的芯片体系结构。值: x86，IA64。
  %PROCESSOR_IDENTFIER% 系统 返回处理器说明。
  %PROCESSOR_LEVEL% 系统 返回计算机上安装的处理器的型号。
  %PROCESSOR_REVISION% 系统 返回处理器修订号的系统变量。
  %PROMPT% 局部 返回当前解释程序的命令提示符设置。由 Cmd.exe 生成。
  %RANDOM% 系统 返回 0 到 32767 之间的任意十进制数字。由 Cmd.exe 生成。
  %SYSTEMDRIVE% 系统 返回包含 Windows XP 根目录（即系统根目录）的驱动器。
  %SYSTEMROOT% 系统 返回 Windows XP 根目录的位置。
  %TEMP% and %TMP% 系统和用户 返回对当前登录用户可用的应用程序所使用的默认临时目录。有些应用程序需要 TEMP，而其它应用程序则需要 TMP。
  %TIME% 系统 返回当前时间。使用与 time /t 命令相同的格式。由 Cmd.exe 生成。有关 time 命令的详细信息，请参阅 Time。
  %USERDOMAIN% 局部 返回包含用户帐户的域的名称。
  %USERNAME% 局部 返回当前登录的用户的名称。
  %UserProfile% 局部 返回当前用户的配置文件的位置。
  %WINDIR% 系统 返回操作系统目录的位置。
  ————————————————
  版权声明：本文为CSDN博主「crazy_itman」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。
  原文链接：https://blog.csdn.net/zkn_CS_DN_2013/article/details/49122015
  ```

  

### linux

- 添加变量

  ```bash
  export PATH=$PATH:[path]
  ```

  export使用方法为 export PATH=$PATH:路径1:路径2:路径n;$PATH为系统变量,表示之前所有设置的路径，如果不加则之前所有的路径都失效。所以必须加上。

- 配置文件

  ```bash
  vi /etc/profile
  #在里面加入:export PATH=$PATH:[path]
  ```

  如果是修改用户主目录下的.bash_profile，则添加的环境变量只对该用户有效，修改/etc/profile对所有用户都生效。也可以修改/etc/rc.local文件和/root/.bashrc文件。
  修改好配置文件后执行source /etc/profile 或者 source /root/.bashrc使配置文件生效



