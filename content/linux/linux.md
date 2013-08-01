# linux

------

误删除数据后，如果其他进程有使用该数据，可以进行恢复

1. 找到刚才的Python进程 $ ps -Af | grep python
2. 查看进程 ll /proc/4933/fd
3. 查看文件 cat /proc/4933/fd/3

## 命令行

跳到行首: `ctrl+a`
跳到行尾: `ctrl+e`
删除整行: `ctrl+c`

递归设置文件夹权限(一般为775):
`find -type d|xargs chmod 775`

递归设置文件权限(一般为664):
`find -type f|xargs chmod 664`

更改文件的用户和用户组
`sudo chown -R stonelee:stonelee .spm/`

## 安装卸载

安装: `sudo dpkg -i 软件名.deb`

卸载: 先`dpkg -l | grep qq` 找到名字，然后执行：`sudo dpkg -r qq-for-wine 或 sudo dpkg -P qq-for-wine`

`-P`删除配置文件，比较常用；`-r`保留配置文件，可以用来重装软件。

nginx配置 `/etc/nginx`

## 启动

关机: `halt`
重启: `reboot`

进入root账户: `sudo -i`

查看log:  `/var/log`

查看系统启动信息 `dmesg`

### 系统启动显示详细开机信息

修改`/etc/default/grub`, 修改`GRUB_CMDLINE_LINUX_DEFAULT=""`

修改`/etc/grub.d/10_linux`, 注释掉`gfxmode &linux_gfx_mode`

然后`update-grub`

实际修改的是`/boot/grub/grub.cfg`

## 服务器

### 修改apache2端口

配置文件在/etc/apache2中

修改ports.conf
```
NameVirtualHost *:8000
Listen 8000
```

修改sites-enabled/000-default
```
<VirtualHost *:8000>
```

重启 `sudo service apache2 restart`

### Apache添加虚拟目录

```
/etc/apache2/sites-enabled/000-default中

Alias /php/ "/home/stonelee/libs/php/"
<Directory /home/stonelee/libs/php/>
  Options Indexes FollowSymLinks MultiViews
  AllowOverride None
  Order allow,deny
  allow from all
</Directory>
```

## 数据库

### mysql中文乱码

修改/etc/mysql/my.cnf

```
[mysql]
character-set-server=utf8
[mysqld]
character-set-server=utf8
```

## 版本控制

### git

抛弃未提交的变动 `git reset --hard HEAD`

撤销上次提交 `git revert HEAD`

### svn

```
svn checkout https://someurl
svn: 方法 OPTIONS 失败于 “https://someurl”: SSL handshake failed: SSL 错误：在证书中检测到违规的密钥用法。 (https://10.10.22.20:8888)
```

解决方法

```
sudo apt-get remove libneon27
sudo apt-get install libssl0.9.8
```

```
Download the latest libneon package fromhttp://packages.debian.org/squeeze/libneon27  (at the bottom you can choose the right version for your architecture).
32位下载：http://ftp.cn.debian.org/debian/pool/main/n/neon27/libneon27_0.29.3-3_i386.deb
64位下载：http://ftp.cn.debian.org/debian/pool/main/n/neon27/libneon27_0.29.3-3_amd64.deb
dpkg -i libneon27_0.29.3-3_amd64.deb 或 libneon27_0.29.3-3_i386.deb
```

```
sudo mv /usr/lib/libneon-gnutls.so.27 /usr/lib/libneon-gnutls.so.27.old
sudo ln -s /usr/lib/libneon.so.27 /usr/lib/libneon-gnutls.so.27
```

## vim

`ctrl+n` 关键字补全

## jshint

在.jshint中配置es3:true，用于兼容IE8以下语法，例如数组中最后一项没有逗号

