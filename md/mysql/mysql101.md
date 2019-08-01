1. 创建数据库

   ```
   create database ${db_name};
   
   create database atlantis_db;
   ```

1. 创建用户

   ```
   create user '${user_name}'@'${host}' identified by '${password}';
   
   create user 'yhyc'@'%' identified by 'Yhyc@Mysql0.';
   
   alter user 'yhyc'@'%' identified by 'aaaa';
   
   drop user 'yhyc@%';
   ```

1. 赋予相应权限

   ```
   grant all on ${db_name}.* to '${user_name}' identified by '${password}';
   
   grant all on atlantis_db.* to 'yhyc'@'%' identified by '${password}';
   ```

localhost: mysql -uroot

vm1:

username:	test@%

password:	c

db_name:	test

## Mysql 常用操作

### copy/clone table

First, this query will copy the data and structure, but the indexes are not included:

```
CREATE TABLE new_table SELECT * FROM old_table;
```

Second, this query will copy the table structure and indexes, but not data:

```
CREATE TABLE new_table LIKE old_table;
```

So, to copy everything, including database objects such as indexes, primary key constraint, foreign key constraints, triggers, etc., run these queries:

```
CREATE TABLE new_table LIKE old_table; 
INSERT new_table SELECT * FROM old_table;
```

If you want to copy a table from one database to another database:

```
CREATE TABLE destination_db.new_table LIKE source_db.old_table;

INSERT destination_db.new_table
SELECT
    *
FROM
    source_db.old_table;
```

### Example

```mysql
mysql> alter table redis_choose
    -> add column machine_key varchar(50) not null comment "机器标识",
    -> add column random_master varchar(20)  not null default 0 comment "主随机数",
    -> add column random_slave varchar(20) not null default 0 comment "备随机数",
    -> add column enforce int(2) default 0 comment '强制',
    -> add column run_machinekey varchar(20) comment "标识" after machine_key
    -> ;

mysql> alter table redis_choose
    -> add primary key(id),
    -> add unique(machine_key),
    -> change run_machinekey run_machine_key varchar(50),	change用于改名
    -> modify id int not null auto_increment				modify用于修改列属性
    -> ;
```

### database 库

#### show

```mysql
show databases;
```

#### create

```mysql
create database ${db_name};
```

#### drop

```mysql
drop database ${db_name};
```

### table 表

#### show all tables

```mysql
show tables;
```

#### show table struct

```mysql
desc `${table_name}`;
```

#### create

##### clone create

```sql
create table ${new_table} like ${old_table_name}
```

```mysql
create table [${database_name}.].${table_name} (
	`id` int not null auto_increment,
	`name` varchar(128) default "" comment "姓名",
	`age` int not null default 0 comment "年龄",
	primary key(`id`),
  unique index `name_unique_index`(`name`)
)engine=innodb default charset=utf8;
```

##### show create table

```mysql
show create table `${table_name}`;
```

```mysql
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT '姓名',
  `age` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_unique_index` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
```

#### alter

##### comment 添加表注释

```mysql
alter table `${table_name}` comment "";

alter table `user` comment "用户表";
```

##### add column 新建列

```mysql
alter table `${table_name}` add column `${column_name}` ${column_desc} after `${column_name}`;

alter table `user` add column `gender` int not null default 0 comment "性别：0-male;1-female" after `name`;
```

##### drop column 删除列

```mysql
alter table `${table_name}` drop column `${column_name}`;

alter table `user` add column `test` int;
alter table user drop column `test`;
```

##### update column 更新列

更改列名/添加列注释/调整列顺序

modify/change区别：change 更改为新列名字；modify只能修改列描述，不能改列名称。

```mysql
alter table `${table_name}` modify `${column_name}` ${column_desc} after `${another_column}`;
alter table `${table_name}` change `${column_name}` `${new_column_name}` ${column_desc} after `${another_column}`;
```

##### drop 删除表

```mysql
drop table if exists [${database_name}.]${table_name};
```

### index 索引

#### show 显示表索引

```mysql
show index from `${table_name}`;
```

#### add 添加表索引

```mysql
create [unique] index `${index_name}` on `${table_name}`(`${column_name}`[,`${column_name_2}`]);

alter table `${table_name}` add constraint `${index_name}` unique(`${column_name}`[,`${column_name_2}`]);
```

#### drop 删除表索引

```mysql
drop index `${index_name}` on `${table_name}`;
alter table `${table_name}` drop index `${index_name}`;
```

### data

#### 从sql文件中导入数据

```
source ~/Downloads/ddl.sql
```



### grants 权限管理

#### show 显示用户权限

```
show grants for '${user}'@'%';
```

#### revoke 撤销授权

```
revoke all on `${database}`.`%{table}` from '${user}'@'%';
```

#### grant 授权

```
表权限
ALTER, CREATE VIEW, CREATE, DELETE, DROP, GRANT OPTION, INDEX, INSERT, REFERENCES,SELECT, SHOW VIEW, TRIGGER, and UPDATE
创建库 db_name
DBA负责
${db_name}_dba@%	dba(拥有库的所有权限,可以对库进行操作） 		
	grant all on ${db_name}.* to '${db_name}_dba' identified by '52_${db_name}_DBA@%'
	grant all on xqcx_message.* to xqcx_message_dba identified by '52xqcx_message_DBA@%';

业务组小组组长负责
${db_name}_op@%		operator(只拥有库中表的操作权限和drop库的权限，无法操作数据)
	grant create,create view,alter,drop,index,references,show view,trigger,GRANT OPTION on ${db_name}.* to $
{db_name}_op
	grant create,create view,alter,drop,index,references,show view,trigger,GRANT OPTION on xqcx_message.* to xqcx_message_op identified by '52xqcx_message_OP@%';

开发人员负责
${db_name}_data@% 		研发(只拥有数据操作权限)		
	grant select,insert,update,delete on ${db_name}.* to ${db_name}_data
	grant select,insert,update,delete on xqcx_message.* to xqcx_message_data identified by '52xqcx_message_DATA@%';

flyway上线时，由${db_name}_op赋予${db_name}_op的所有权限给${db_name}_data，上线后收回。
	grant create,alter,drop,index on xqcx_message.* to xqcx_message_data;
	revoke create,create view,alter,drop,index,references,show view,trigger,grant option on xqcx_message.* from xqcx_message_data;
```





## mysql 通配符

```
% 0-n 个字符
_ 1 个字符
[abc] 其中一个字符
[^abc] [!abc] 不是abc的一个字符
```



## mysql 细节相关

1. 查看日志位置

   > select @@log_error;

1. 查看当前用户

   > select user();

1. 更改自动递增列的起始值

   ```sql
   alter table `${table_name}` auto_increment=${start_value}
   
   alter table `user` auto_increment=1000
   ```

1. 时间相关操作

   ```sql
   mysql> select now(), curdate(), curtime();
   +---------------------+------------+-----------+
   | now()               | curdate()  | curtime() |
   +---------------------+------------+-----------+
   | 2019-04-16 17:10:46 | 2019-04-16 | 17:10:46  |
   +---------------------+------------+-----------+
   1 row in set (0.00 sec)
   ```

   对于datetime类型的字段判等时必须是**yyyy-MM-dd hh:MM:ss 全部相同**，用between时可以**省略**yyyy-MM-dd hh:MM:ss中的一些字段，省略的字段默认以**0替代**。

1. null相关操作

   ```sql
   `${column}` is null / `${column}` is not null 判断一个字段是否为null
   '' is null 返回false
   0 is null 返回false
   
   select ifnull(`${column}`, 0) 可以把null值转换成0值
   ```

1. 聚合查询

   ```
   select count(*) from `${table_name}`
   select count(`${column}`) from `${table_name}` // 按某列聚合时，会忽略字段为null的行
   select count(distinct(`${column}`)) from `${table_name}`
   ```

## Mysql Centos 安装笔记

1. 下载并安装repo，<http://dev.mysql.com/downloads/repo/yum/>

1. 查看mysql 的版本：yum repolist|grep mysql /  yum repolist all|grep mysql

1. 安装：yum install mysql-community-server -y

   > 只安装client yum install mysql-community-client

1. 启动：systemctl start mysqld.service

1. 查看随机密码并修改root@localhost密码

   1. cat /var/log/mysqld.log|grep root
   1. ALTER USER 'root'@'localhost' IDENTIFIED BY 'root@Mysql0.';

   