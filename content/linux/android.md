# android

-------------

### 安装

```bash
sudo apt-get install openjdk-6-jdk
sudo apt-get install git-core gnupg flex bison gperf build-essential \
  zip curl libc6-dev libncurses5-dev:i386 x11proto-core-dev \
  libx11-dev:i386 libreadline6-dev:i386 libgl1-mesa-glx:i386 \
  libgl1-mesa-dev g++-multilib mingw32 openjdk-6-jdk tofrodos \
  python-markdown libxml2-utils xsltproc zlib1g-dev:i386
```

### 创建应用

`android create project --target 1 --name MyFirstApp --path ～/test/MyFirstApp --activity MainActivity --package com.example.myfirstapp`

在应用目录中：

编译：`ant debug`

安装：`adb install <path to your .apk>`，`-r`可以自动卸载软件然后安装

## phonegap

创建应用:
`./bin/create ~/test/MyFirstPhoneGapApp com.example.myfirstphonegapapp MyFirstPhoneGapApp`

在应用目录中：

编译：`./cordova/build`
安装：`./cordova/run`
