# linux

------

## 命令行

跳到行首: `ctrl+a`
跳到行尾: `ctrl+e`
删除整行: `ctrl+c`

递归设置文件夹权限(一般为775):
`find -type d|xargs chmod 775`

递归设置文件权限(一般为664):
`find -type f|xargs chmod 664`

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
