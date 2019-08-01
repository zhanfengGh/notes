## Hachintosh

> TODO
>
> Imac18.3 尝试



## History

### 2019-05-26

reisntall fresh

instant wake from sleep

> Wake reason: XHXC
>
> fix it with https://www.tonymacx86.com/threads/still-cant-solve-the-problem-of-instant-wake.270420/



### 2019-05-23

1. 闪屏 提高WhateverGreen 中显存到2048M 
  
   1. framebuffer-unifiedmem <data> ->00000080  
   
      > not working
   
   2. try "AAPL,ig-platform-id", Buffer() { 0x07, 0x00, 0x9b, 0x3e }  for Macmini8.1 待测试
   
      > no geekbench metal score/lower opencl score
   
   3. "AAPL,ig-platform-id", Buffer() { 0x00, 0x00, 0xa5, 0x3e }  for iMac16.2
   
      > not working
   
   4. try SMBIOS 14.2
   
   5. search for UHD655 for solutions
   
   6. update WhateverGreen.kext and Lilu.kext
   
   7. try clean install with everything Rehabman says
   
   8. 
1. Handoff not working
  
   1. relogin icloud and it works. fuck me.
1. Apple Keyboard can't wake from sleep
  
   1. try change bt usb connect-type to 0(just usb2.0) 
   
      > instant wake up from sleep, guess have to live with it.
   



### 2019-05-21

1. fixes SSDT-USB-NUC8-BC.dsl
1. fully install Rehabman 
1. remove unnessary kexts

### 2019-05-17

1. try SATA-unsupported.kext to fix Generic SATA driver.
1. try Rehabman SSDT-XDCI.aml

### 2019-05-16

failed

fixes：check Clover version (RehabMan).

1. RehabMan 4701 failed 
1. RehabMan 4658 failed
1. sourceforge 4920 worked

SATA

1. SSDT-SATA.aml 100 serial
1. todo try SATA-unsupported.kext

todo

1. 去掉 lilucpu=10
1. HDMI 4k@60Hz

GPU

1. whateverGreen.kext
1. hdmi con-type:00080000
1. enable-hdmi2.0 + -cdfon

audio

1. **FakePCIIDs.kext** + **FakePCIID_Intel_HDMI_Audio.kext** 
1. **Lilu.kext**
1. **AppleALC.kext** 
1. SSDT-HDEF.aml

USB - done

1.  -uia_exclude_ss uia_exclude=USR1,USR2 测试usb2.0
   1. front left hs02
   1. front right hs01
   1. back up hs04
   1. back down hs03
   1. internel header1(right) hs06
   1. internel header2(left) hs05
1. -uia_exclude_hs uia_include=HS01 测试usb3.0
   1. front left hs02 / ss02
   1. front right hs01 / ss01
   1. back up hs04 / ss04
   1. back down hs03 / ss03
   1. type-c not recognized.

SMBIOS

1. try Macmini8,1

## Hardware



## How



## Clover 配置解析

also see https://www.insanelymac.com/forum/topic/282787-clover-v2-instructions/?tab=comments#comment-1852972

### Some general rules:

**If you do not know what value a parameter needs, exclude it from the config file completely!**

**Do not leave a parameter without a value.**

**Last but not least, do not set a value you do not understand!**

### The following way of creating a configuration file is offered:

1. Install the minimal version, which only uses safe parameters
1. Load Clover's GUI and enter the Options menu (by pressing O)
1. Browse all options and try to understand what is set and why
1. Fix what you understand and leave the rest like it is
1. Load the OS. If it doesn't load, repeat from step 2 until it starts

### DSDT

1. **/booted_partition/DSDT.aml** if not found then
1. Took OEM DSDT from BIOS of the computer.

### Clover DSDT autopatcher

```dsl
<key>ACPI</key>
<dict>
  <key>DSDT</key>
  <dict>
  	<key>Debug</key>	// 开启debug模式。/EFI/CLOVER/ACPI/origin目录下有生成的DSDT文件
		<true/>
    <key>Name</key>
    <string>DSDT.aml</string>
    <key>Fixes</key>
    <dict>
      <key>AddDTGP_0001</key>
      <true/>
      ...
      <key>FixRegions_10000000</key>
      <true/>
    </dict>
  </dict>
</dict>
```

### Configuration

#### KernelAndKextPatches

1. AppleRTC

   > 解决BIOS CMOS 被重置问题。2种解决方法：1 修复DSDT，2 patch kext。

   ```
   <key>AppleRTC</key>
   <true/>
   ```

   > OS X has compatibility issues with a BIOS CMOS resulting in its reset on each wake after sleep and reboot, which is noticeable in a loss of BIOS settings. Mostly Gigabyte motherboards are affected. Usually it can be solved by patching Device(RTC) in the DSDT.
   > If this does not help, the kext itself can be patched, which is done here.

## Intel Mojave on NUC8I7BEH

### Hardware

| Hardware       | Name                                   | Remark                                          |
| -------------- | -------------------------------------- | ----------------------------------------------- |
| CPU            | I7-8559U                               |                                                 |
| Graphic        | Intel® Iris® Plus Graphics 655         | deviceId: 0x3EA5                                |
| LAN            | I1219-V                                | 8086-15BE                                       |
| Audio          | ALC233                                 | 10EC-0235(8086-2074)                            |
| RAM            | Kingston HyperX DDR4 2666 16G*2        |                                                 |
| SSD            | Samsung SSD 860 EVO 1TB                | SATA3.0 6G                                      |
| WIFI/BT        | BCM94360CS2 + M.2 Bridge               | MacBook Air (A1465/A1466) 拆机卡                |
| Monitor        | DELL P2415Q                            | 4K @ 60Hz using type-c -> dp                    |
| Keyboard/Mouse | Apple Magic Keyboard 2 / Logitech M220 | can not wake from sleep using my apple Keyboard |

### RehabMan 要求

1. EmuVariableUefi-64.efi
1. BIOS settings you *must* enable legacy boot 



### target

1. USB - total 11 ports
   1. native USB/3.0 5G
   1. front/back total 4 USB2.0 and 4USB3.0
   1. type-c USB3.0 
   1. internal headers 2 USB2.0
1. Graphics - Intel® Iris™ Plus Graphics 655
   1. HDMI2.0 4K@60HZ
   1. type-c to DP 4K@60HZ
1. Audio
   1. front jack audio/micro
   1. internal micro
   1. HDMI audio
   1. DP audio
   1. 声音自动切换/麦克风测试
1. sleep/wake/shutdown/restart
1. LAN
1. iCloud/iMessage/Handoff/共享剪贴板/Watch unlock/电话

### BIOS settings

**BIOS Version 0064**

To start, choose "Load Defaults" (choose from the menu or press F9 in the BIOS setup).

Then change:
- Boot->Boot Configuration, disable "Network Boot"
- Power->Secondary Power Settings, "Wake on LAN from S4/S5", set to "Stay Off" **// todo why**

These settings are important but are already set as needed by "Load Defaults"
- Devices->Video, "IGD Minimum Memory" set to 64mb or 128mb
- Devices->Video, "IGD Aperture Size" set to 256mb
- Boot->Secure Boot, "Secure Boot" is disabled
- Security->Security Features, "Execute Disable Bit" is enabled.

Suggested:
- Boot->Boot Priority->Legacy Boot Priority, enable "Legacy Boot".

### Clover

download from https://bitbucket.org/RehabMan/clover/downloads/

### config.plist

download from https://github.com/RehabMan/Intel-NUC-DSDT-Patch

#### kexts in /EFI/Clover/kexts/Other

- IntelMausiEthernet.kext 驱动有线网卡
- WhateverGreen.kext +Lilu.kext 驱动显卡
- AppleALC.kext + Lilu.kext 驱动声卡
- USBInjectAll.kext 驱动USB
- FakeSMC.kext 必备

#### drivers in /EFI/Clover/drivers64UEFI

- *AptioMemoryFix* -  the new hotness that includes NVRAM fixes, as well as better memory management
- *VBoxHfs-64* (or *HFSPlus* if available) - one of these is required for Clover to see and boot HFS+ volumes.  
- *ApfsDriverLoader* - (Available in Dids' Clover builds - or [here](https://github.com/acidanthera/ApfsSupportPkg/releases)) this allows Clover to see and boot from APFS volumes by loading apfs.efi from ApfsContainer located on block device (if using AptioMemoryFix as well, requires R21 or newer)
- *EmuVariableUefi-64* - Workaround for store NVRAM variables for systems without UEFI hardware.Mostly UEFI boot uses hardware NVRAM but in some rare cases this driver is needed. Use it only if you have a problem without it

### now try downgrade bios version to 0056





## Mac 文件系统格式

HFS+    	<==>		Mac OS Extended 

HFSX		<==>		Case-sensitive HFS+

JHFS+ 	  <==> 		Journaled HFS+

JHFSX	   <==>		Case-sensitive Journaled HFS+ 

APFS

## DSDT

Keep in mind that even changes you make to your own system (BIOS, hardware, etc.) will require re-extract, re-patch.

If any of the following is changed, you must re-extract, re-patch, as these changes may cause significant changes to the native ACPI (especially SystemMemory regions):
- updating BIOS
- changing any BIOS option
- changing hardware or memory configuration

The process of patching involves several steps:
- extracting native files
  1. Extracting with Clover F4 
- disassembling the native files
  1. iasl: https://bitbucket.org/RehabMan/acpica/downloads
  1. place all DSDT and SSDT files in a single directory (DO NOT copy ACPI files that don't begin with DSDT or SSDT), and change the names such that they have an .aml extension.
  1. `cd "to directory where you placed all SSDT/DSDT"; iasl -dl DSDT.aml SSDT*.aml`
  1.  **work exclusively with the resulting \*.dsl** files using MaciASL
- analyzing the native files
- patching
- saving (compiling) and installing

## Useful tips

format u disk

> diskutil partitionDisk /dev/disk1 1 GPT HFS+J "install_osx" R

how to install/uninstall kexts

>sudo cp -R KextToInstall.kext /Library/Extensions
>
>sudo kextcache -i /
>
>sudo rm -Rf /Library/Extensions/KextToInstall.kext

how to add/remove BIOS start options

>bcfg boot dump
>
>bcfg boot rm 1
>
>bcfg boot mv 2 0
>
>bcfg boot add 3 fs0:\\EFI\boot/bootx64.efi "Clover"
>
>[more](https://wiki.archlinux.org/index.php/Unified_Extensible_Firmware_Interface#UEFI_Shell)
>
>search keys: uefi shell

## MacOS 10.14.3

1. target

   > native CPU

   > DiskPlay 4K@60 DP/HDMI2.0/HDMI

   >shutdown/restart/sleep/wakeup

   >navtive WI-FI/BT

   >iCloud/iMessage/Handoff/共享剪贴板/Watch unlock/电话

   >声音自动切换/麦克风测试/apfs日志

   >native USB/3.0 5G

   >Ethernet cards just need one to work

2. 遇到问题及解决方案

   1. 睡眠后U盘未被正常弹出

      > BIOS XMP 导致，关闭XMP，内存手动超频2666Mhz

   2. USB 端口太多

      | location            | ports     |
      | ------------------- | --------- |
      | front left          | HS01/SS01 |
      | front right         | HS02/SS02 |
      | BT                  | HS10      |
      | back up left        | HS03/SS03 |
      | back up right       | HS04/SS04 |
      | back down right     | HS06/SS06 |
      | back down rightleft | HS05/SS05 |
      | back down leftright | HS08/SS08 |
      | back down left      | HS07/SS07 |
      | USB-C               | HS09/SS09 |

      共19个端口，去掉back down 4个USB3.0和USB-C的2.0

      19 个 - 5 个（底部4个USB3.0 + type-c 2.0)，剩下14个端口

      1. Install USBInjectAll.kext in /Library/Extensions
      2. 修改SSDT-UIAC.dsl后编译成SSDT-UIAC.aml，放到Clover的/ACPI/patched中

   3. 



## ACPI

ACPI Machine Language



### ASL的基本准则

a)  变量名必须由4个字符组成，第1个字符不能是数字。

b)  变量名和函数名不区分大小写。

c)  Scope和Device都会形成自己的作用域。

d)  所有以”_”开头的函数都是Reserved的，给系统使用，不能给自己的函数起这样的名字

e)  ASL中的路径有相对路径和绝对路径之分。其结构有点像文件目录。

f)  对于函数，最多只能传递8个参数（Arg0~Arg7），只能用这8个名字，不能自己起名字

g)  对于局部变量，最多能使用8个变量（Local0~Local7），和函数参数一样，不能自己起名字，而且在使用之前必须手动赋初值。

h)  声明变量时不需要显示声明其类型。

### ASL数据类型

a)  Integer  – 整数  

b)  String   – 字符串  

c)  Event   -- 事件  

d)  Buffer  -- 数组  

e)  Package – 对象结合

可以通过使用objectType（obj）函数可以获知使用的是哪一种数据类型：

![hachintosh_acpi_data_type.png](/Users/feng/Documents/notes/pictures/hachintosh_acpi_data_type.png)





### ASL的常用函数

1. 定义变量的函数 name（x，****）；

   前面提到定义变量不需要定义变量类型，直接使用函数定义即可，如

   name（temp，100）         //定义一个整数

   name（str，"hello"）         //定义了一个字符串

1. 赋值函数  store（），如

​    store(0x99, Local0)

​    store("Hello", Local1)

### 算数运算

在ASL中算数运算也不是采用+，—，*，/等，而是使用函数

![20161128193856461.png](/Users/feng/Documents/notes/pictures/hackintosh_acpi_math.png)

### 逻辑运算

和算术运算一样，ASL中同样使用函数来进行逻辑运算

**LAnd:**                          LAnd(0x1, 0x2)                                     //0x1 && 0x2

**LEqual:**                       LEqual(0x1, 0x2)                                  // 0x1== 0x2

**LGreater:**                   LGreater(0x1, 0x2)                               //0x1 > 0x2

**LGreaterEqual:**         LGreaterEqual(0x1,0x1)                       // 0x1 >= 0x2

**LLess:**                        LLess(0x1, 0x2)                                   // 0x1 < 0x2

**LLessEqual:**              LLessEqual(0x1,0x2)                           // 0x1 <= 0x2

**LNot:**                          LNot(0x1)                                             //!(0x1)

**LNotEqual:**                LNotEuqal(0x1,0x2)                             //0x1 != 0x2

**LOr:**                           LOr(0x1,0x2)                                        // 0x1 || 0x2



### 函数定义

Method(ADBG, 2) //表示有两个输入参数

{

​    // Arg0, First parameter

​    // Arg1, Second parameter

​    Store(Arg0, Local0)     //局部变量0

​    Store(Arg1, Local1)     //局部变量1

​    Add(Local0, Local1, Local1)

​    Return(Local1)          //返回Local1

}

### 调用函数

ADBG(3, 5)

### ASL的域

在root下一共存在5个不同的域，用来负责不同的事件 

​             \\_GPE, 主要负责ACPI的事件处理

​             \\_PR, 处理器相关

​            \\_SB, 所有的设备和总线

​            \\_SI, 系统指示灯

​             \\_TZ, Thermal相关，用于读取某些温度值

### ASL的设备配置

Name(_HID,EISAID("PNP0303"))        // Standard Keyboard 101/102 

​      这个是指使用的硬件为PS2 KB。

Name(_HID, EISAID(“PNP0F03”))，这个是则PS2 _MOUSE。



总结

​      1：在ACPI中，各个状态都有自己的下标，下标的数值越大，则该状态所对应的能耗也就越低。

​      2：部分状态只有在满足一定的条件才会呈现，比如说，C状态只有在G0下才会呈现，而P状态又呈现在C0状态下。

​      3：ASL编译形成的AML镜像会对应ACPI中的各个table表，OS通过抓取这些table表就可以获取ACPI的配置和控制方法，实现其作用。