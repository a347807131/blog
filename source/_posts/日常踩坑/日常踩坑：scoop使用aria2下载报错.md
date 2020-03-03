---
title: 日常踩坑：scoop使用aria2下载报错
categories:
  - 日常踩坑
abbrlink: 38b60689
date: 2020-02-04 21:09:37
tags:
mathjax:
img:
---

在日常使用`scoop`安装工具时，不止以此出现如下错误

```shell
ERROR Download failed! (Error 1) An unknown error occurred
ERROR https://updates.tdesktop.com/tsetup/tportable.1.9.9.zip
    referer=https://updates.tdesktop.com/tsetup/
    dir=C:\Users\Administrator\scoop\cache
    out=telegram#1.9.9#https_updates.tdesktop.com_tsetup_tportable.1.9.9.zip

ERROR & 'C:\Users\Administrator\scoop\apps\aria2\current\aria2c.exe' --input-file='C:\Users\Administrator\scoop\cache\telegram.txt' --user-agent='Scoop/1.0 (+http://scoop.sh/) PowerShell/5.1 (Windows NT 10.0; Win64; x64; Desktop)' --allow-overwrite=true --auto-file-renaming=false --retry-wait=2 --split=5 --max-connection-per-server=5 --min-split-size=5M --console-log-level=warn --enable-color=false --no-conf=true --follow-metalink=true --metalink-preferred-protocol=https --min-tls-version=TLSv1.2 --stop-with-process=5012 --continue

Please try again or create a new issue by using the following link and paste your console output:
https://github.com/lukesampson/scoop-extras/issues/new?title=telegram%401.9.9%3a+download+via+aria2+failed
```

在按照提示在项目地址提了个`issue`得到回复

![](https://cdn.jsdelivr.net/gh/a347807131/cdn/images/20200204211448.png)

然后我就关闭了使用`aria2`下载的设置

```shell
Administrator :: ~\WebstormProjects\RSSHub <master> » scoop install telegram
Installing 'telegram' (1.9.9) [64bit]
tportable.1.9.9.zip (24.6 MB) [===============================================================================] 100%
Checking hash of tportable.1.9.9.zip ... ok.
Extracting tportable.1.9.9.zip ... done.
Running pre-install script...
Linking ~\scoop\apps\telegram\current => ~\scoop\apps\telegram\1.9.9     Creating shim for 'telegram'.
Creating shortcut for Telegram (Telegram.exe)
Persisting tdata
'telegram' (1.9.9) was installed successfully!
```

它成了。