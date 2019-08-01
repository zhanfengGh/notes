## VirtualBox

### 使用方法

1. ssh-add ~/.ssh/local_vms/id_rsa

### centos001pro

1. Hoss-only Adapter

   > vboxnet0 192.168.56.1

1. Bridged Adapter

- JDK1.8
- Mysql
  - systemctl start/stop mysqld
  - root/db_Dba_root0.
  - zhanfeng.zhang / db_Dba_root0.
- Docker
- filebeat

### centos002pro

1. Hoss-only Adapter

   > vboxnet0 192.168.56.2	

1. Bridged Adapter

- filebeat
- mysql-client

### centos001

1. Hoss-only Adapter

   > vboxnet0 192.168.56.1

1. Bridged Adapter

- JDK1.8
- Mysql
  - systemctl start/stop mysqld
  - root/db_Dba_root0.
- Docker
- filebeat

### centos002

1. Hoss-only Adapter

   > vboxnet0 192.168.56.2	

1. Bridged Adapter

- filebeat

### ubuntu001 (Ubuntu18.04)

> username:`feng`
>
> password:`0.`

#### Network

1. Hoss-only Adapter

   > vboxnet0 192.168.56.49

1. Bridged Adapter

### ubuntu002 (Ubuntu14.04)

> username:`feng`
>
> password:`0.`

#### Network

1. Hoss-only Adapter

   > vboxnet0 192.168.56.50

1. Bridged Adapter

auto eth0
iface eth0 inet static
address 192.168.56.50
netmask 255.255.255.0

### Lede-v2.31

#### Network

你还可以设置两个物理网络接口在你的宿主操作系统上. 这样的话：

- 用一个网络接口作为 **WAN** 并在VirtualBox 中选择为 **桥接网卡(Bridged Adapter)** 并且 **混杂模式(Promiscuous Mode)** 设置为 **拒绝(Deny)**
- 用另一个网卡作为 **LAN** 并在VirtualBox 中选择为 **桥接网卡(Bridged Adapter)** 并且 **混杂模式(Promiscuous Mode)** 设置为
  - **拒绝(Deny)** 如果你不希望暴露桥接的虚拟网络到你的物理网络中
  - **允许所有(Allow All)** 如果你希望连接你的桥接虚拟网络到你的物理网络

1. Hoss-only Adapter

   > vboxnet0 192.168.56.97

1. Bridged Adapter

   1. WAN bridged to eth0 (I219-V)

   1. LAN bridged to eth4 (I211)

      > 混杂模式设置为Allow All 容许其他vm和物理设备连接

1. 