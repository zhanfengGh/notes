# Linux commands

## awk

### awk 根据memberIdsFile.txt生成sql

memberIdsFile.txt 每行一个会员id

1. 编写awk代码

   ```
   BEGIN {print "INSERT INTO `yh_gray_user` (`scene_code`, `member_id`, `result`) VALUES"}
         NR>1 { print "('" SCENE_CODE "'," memberId "," "'" RESULT "'),"}
         { memberId=$1 }
   END   { print "('" SCENE_CODE "'," memberId "," "'" RESULT "');"}
   ```

1. 执行awk

   ```shell
   awk -v SCENE_CODE=SVIP_GRAY_18 -v RESULT=old_member -f insert_sql.awk memberIdsFile.txt > old_member.sql
   ```

   > -v 声明变量
   >
   > -f 指定awk文件

1. 结果

   ```sql
   INSERT INTO `yh_gray_user` (`scene_code`, `member_id`, `result`) VALUES
   ('SVIP_GRAY_18',688049160325338237,'contrast'),
   ('SVIP_GRAY_18',688240905219324039,'contrast'),
   ('SVIP_GRAY_18',688519112069618799,'contrast'),
   ('SVIP_GRAY_18',688550641373003416,'contrast');
   ```

## dos2unix/unix2dos

DOS/Mac to Unix and vice versa text file format converter

1. dos(windows) convert to unix

   > dos2unix file1 [file2, file3, filen]

1. unix convert to dos

   > unix2dox file1 [file2, file3, filen]

## sort

1. 按数字排序

   > sort -n [file ...] > result.file

1. 去除重复行

   > sort -u  [file ...] > result.file

1. 排序后写回源文件

   > sort a.txt -o a.txt
   >
   > 注意：不能重定向要源文件如sort a.txt > a.txt 会清空a.txt

1. 其他参数

   >  sort -r [-k field1[,field2]] [-t char] [file ...]
   >
   > -r 反序

## ssh-keygen

1. 生成密钥对

   > ssh-keygen

1. 指定文件/算法/密码/注释

   > ssh-keygen -f ~/.ssh/test -t dsa -P 'password' -C 'comment'

1. 添加/修改/取消密码

   > ssh-keygen -p [-P old_passphrase] [-N new_passphrase] [-f keyfile]
   >
   > ssh-keygen -p -P 'password' -N '' -f  ~/.ssh/test

1. 根据私钥生成公钥

   > ssh-keygen -y [-f input_keyfile]
   >
   > ssh-keygen -y -f  ~/.ssh/test

## zip

压缩当前目录下所有的文件

> zip dir.zip *

压缩当前目录下所有的文件，包括以.开头的隐藏文件

> zip -v dir.zip .\* *

压缩当前目录下所有的文件，包括以.开头的隐藏文件和递归子目录（也包含子目录下的隐藏文件）

> zip -v -r dir.zip .\* *

> -r 发生递归时，不管有没有 .* ， 子目录中的隐藏文件都会被加入到压缩文件中。

-0 只打包 -1 轻度压缩 -9 重度压缩 

> zip -0 -r dir.zip .\* *
>
> zip -1 -r -v dir.zip .\* *
>
> zip -9 -r -v dir.zip .\* *

-f 更新zip中存在的文件 -u 更新和添加新文件 -m 删除源文件

> zip -v -r -9 dir.zip Library/
>
> zip -v -r -9 -u dir.zip Library/
>
> zip -v -r -9 -f dir.zip Library/
>
> zip -v -r -9 -m dir.zip Library/

-@ 读取文件列表

> find . -name "\*.[ch]" -print | zip source -@

加密 -e 

> zip -v -r -9 -u -e dir.zip Library/

把a.txt 内容压缩后输出到stdout （重点最后一个'-'）

> zip -v -9 -r - a.txt | > a.zip

> cat a.txt | zip -v -9 stdin.zip -
>
> tar cf - . | zip backup.zip -
>
> tar cf - . | zip | dd of=/dev/nrst0 obs=16k
>
> tar cf - . | zip - - | dd of=/dev/nrst0 obs=16k

## unzip 日常用法

测试zip文件

> unzip -t library.zip

查看zip文件中的内容

> unzip -v library.zip
>
> unzip -l library.zip

解压到当前目录

> unzip library.zip

解压到指定目录

> unzip  -d a library.zip

更新压缩包中的较新到目录（只更新已存在的文件，压缩包中新创建的文件不会新建到目录中）

> unzip -d a -f library.zip
>
> unzip -d a -u library.zip 会新建不存在的文件

## curl

curl 支持`DICT, FILE, FTP,FTPS, GOPHER, HTTP, HTTPS, IMAP, IMAPS, LDAP, LDAPS, POP3, POP3S, RTMP, RTSP, SCP, SFTP,  SMB,  SMBS,  SMTP,SMTPS, TELNET and TFTP`协议，不只是用于http请求。

```
curl 
	-v	verbose
	-X 	--request	GET/POST/PUT/DELETE/HEAD
	-d	--data 
	--data-raw
	--data-binary
```

```shell
# POST 增
curl -v -X POST \
  http://127.0.0.1:8080/v1/sender_configs \
  -H 'Content-Type: application/json' \
  -d '{
    "name": "sms_bdy_builder"
}'
# DELETE 删
curl -v -X DELETE localhost:8080/v1/sender_configs/1
# POST 改
curl -v -X PUT \
	localhost:8080/v1/sender_configs/1 \
	-H 'Content-Type: application/json;charset=UTF-8' \
	-d '{"name":"local_log_builder"}'
# GET 查
curl -v -X GET localhost:8080/v1/sender_configs/1
```

### 请求体携带数据

```shell
curl -v --request POST \
	http://localhost:8080/v1/sender_configs \
	-d "para1=aa"
	-d "para2=张峰"
```



### 返回结果重定向

## tcpdump

