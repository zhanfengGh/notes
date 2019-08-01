## vi 复制粘贴

1. `"lyy`复制一行到`l`寄存器
1. `"lp"` 把`l`寄存器的内容粘贴到当前行

## Mac 截图工具的使用

### 全屏截图

`⌘ + ⇧ + 3`  截图后保存到文件，保存之前可以编辑

`⌘ + ⇧ + ⌃ + 3` 直接截图到内存

### 选取区域截图

`⌘ + ⇧ + 4` 截图后保存到文件，保存之前可以编辑

`⌘ + ⇧ + ⌃ + 4` 直接截图到内存

#### 选取窗口截图

`⌘ + ⇧ + 4` /`⌘ + ⇧ + ⌃ + 4`，然后`␣`，然后选取要截图的窗口





## Ubuntu18.04 更改网卡设置

1. 配置文件

   sudo vi /etc/netplan/50-cloud-init.yaml

   ```yaml
   network:
   	ethernets:
   		enp0s3:
   			dhcp4: false
         addresses:
         	- 192.168.56.49/24
       enp0s10:
         dhcp4: true
         optional: true
   ```

1. sudo netplan apply

## VirtualBox 随系统启动vm

1. 配置文件

   1. copy /Applications/VirtualBox.app/Contents/MacOS/org.virtualbox.vboxautostart.plist  to /Library/LaunchDaemons and change the Disabled key from true to false

   1. sudo chown root:wheel /Library/LaunchDaemons/org.virtualbox.vboxautostart.plist

   1. 添加/etc/vbox/autostart.cfg

      1. sudo mkdir /etc/vbox
      1. sudo vi /etc/vbox/autostart.cfg

      ```
      default_policy = deny
      feng = {
          allow = true
          startup_delay = 10
      }
      ```

1. 添加需要启动的vm
   ```
   VBoxManage list vms
   VBoxManage modifyvm "${vmName}" --autostart-enabled on
   VBoxManage modifyvm "${vmName}" --autostop-type acpishutdown
   VBoxManage modifyvm "${vmName}" --defaultfrontend headless
   ```
   
1. test

   ```
   sudo launchctl load /Library/LaunchDaemons/org.virtualbox.vboxautostart.plist
   ```

## Springboot 开启热加载

1. 加入devtools依赖

   ```xml
   <dependency>
     <groupId>org.springframework.boot</groupId>
     <artifactId>spring-boot-devtools</artifactId>
     <optional>true</optional>
   </dependency>
   ```

1. idea `⌘ + F9` rebuild project

1. done

## Enable AirDrop Over Ethernet & Wi-Fi for Old Unsupported Macs

- Launch Terminal, found in /Applications/Utilities/
- Paste in the following defaults command:
- `defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1`

- Hit Return, then on a new line in the Terminal type the following command to relaunch the Finder:
- `killall Finder`

- Exit out of Terminal if you want, and launch any Finder window to discover the AirDrop icon

You can also reboot the Mac for changes to take effect.

## Mac Idea Hang debug/saving caches

1. 查看hostname

   > hostname

1. 更改hostname

   > sudo scutil --set HostName nuc8i7beh

1. 添加到hosts文件中

   > sudo nvim /etc/hosts
   >
   > 127.0.0.1 localhost nuc8i7bek
   >
   > ::1             localhost nuc8i7beh

1. 实测这里和System Preferences -> Sharing 中的Computer Name没有毛线关系

## Mac tcpdump

```
tcpdump -i lo0 -n -v -XX port 8081
For the expression syntax, see pcap-filter(7).
```



## Mac 开启路由转发

```
sysctl -w net.inet.ip.forwarding=1
```



## Mac 获取路由信息

```
route -n get default
route -n get 192.168.30.5
route -n get www.google.com
netstat -rn
```



## CentOS 更新时间

```shell
yum install ntpdate
ntpdate us.pool.ntp.org
```



## Shell 获取目录下的所有目录

```
for dir in `ls -d */`;do
	ls -lh $dir
done
```



## CentOS 网络相关

1. 配置网卡

   vi /etc/sysconfig/network-scripts/ifcfg-enp0s10

   > dhcp

   ```
   TYPE=Ethernet
   BOOTPROTO=dhcp
   DEVICE=enp0s10
   ONBOOT=yes
   ```

   > static

   ```
   TYPE=Ethernet
   BOOTPROTO=static
   IPADDR=192.168.56.1
   PREFIX=24
   DEVICE=enp0s10
   ONBOOT=yes
   ```

   

1. 设置主机名

   ```shell
   hostnamectl set-hostname ${hostname}
   ```

1. 重启网卡

   ```shell
   ifdown enp0s10;ifup enp0s10
   ```

## VirtualBox 常用命令

1. Headless start

   > VBoxManage startvm <uuid|vmname> [--type gui|headless|separate]

1. Pause/Resume

   > VBoxManage controlvm <uuid|vmname> pause|resume|poweroff|savestate|reset

1. 查看vm信息

   > VBoxManage showvminfo <uuid|vmname> [--details]

1. 控制Guest

   > TODO VBoxManage guestcontrol 

## Mac: smart quotes and dashes

> 会把2个英文短横变成1个中文长横
>
> 关闭方法：System Preferences -> Keyboard -> Text -> uncheck "Use smart quotes and dashes"

## Docker: enable the remote API for dockerd

1. TODO use TLS to secure the deamon

2. Create a file at `/etc/systemd/system/docker.service.d/startup_options.conf` with the below contents:

   ```
   # /etc/systemd/system/docker.service.d/override.conf
   [Service]
   ExecStart=
   ExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:2376
   ```

   > **Note:** The -H flag binds dockerd to a listening socket, either a Unix socket or a TCP port. You can specify multiple -H flags to bind to multiple sockets/ports. The default -H fd:// uses systemd's socket activation feature to refer to /lib/systemd/system/docker.socket.

3. Reload the unit files:

   ```
   $ sudo systemctl daemon-reload
   ```

4. Restart the docker daemon with new startup options:

   ```
   $ sudo systemctl restart docker.service
   ```

5. Ensure that anyone that has access to the TCP listening socket is a trusted user since access to the docker daemon is root-equivalent.

## MacOS: just install docker client on 

1. brew install docker
2. brew info docker-compose

## mac: 查看端口占用

```shell
lsof -nP -i[tcp|udp][@hostname|hostaddr][:service|port]

lsof -nP -i :80
lsof -nP -i :http

lsof -nP -i tcp:8500

lsof -nP -i tcp@127.0.0.1:8500
```

## mac: 查看端口监听

```shell
lsof -nP -itcp -stcp:listen
```

## mac: 终端tcp/udp流量走shadowsocks代理

```
vim ~/.zshrc  

添加一下3行到文件最后
# proxy list
alias proxy='export all_proxy=socks5://127.0.0.1:1080'
alias unproxy='unset all_proxy
```

验证方法如下：

1. unproxy

   > curl https://ip.cn

2. proxy

   > curl https://ip.cn

3. 对比输出

## mac: unix时间戳

```shell
date +%s
```
## mac: 显示隐藏文件

> ⌘ + ⇧ + . 可以快速显示/隐藏 隐藏文件

```
//显示隐藏文件
defaults write com.apple.finder AppleShowAllFiles -bool true
//不显示隐藏文件
defaults write com.apple.finder AppleShowAllFiles -bool false

// restart finder
```
## mac: 删除所有.DS_Store

```
cd ~; find . -name ".DS_Store"|less
cd ~; find . -name ".DS_Store" -exec rm -f {} \;
```

## mac: 不自动挂载磁盘

```
sudo vifs

UUID=NUMBER none hfs rw,noauto
把NUMBER替换成磁盘的UUID（可在磁盘管理工具中查看）
diskutil info disk0s3 可直接查看分区的UUID
```



