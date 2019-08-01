## 笔记的记录

1. 笔记很重要
1. 每天记笔记
1. 晚上下班前总结笔记
1. 第二天上班前复习笔记
1. 每周最后一天总结当周笔记
1. 把每周的笔记分类归档

## 个人特点

1. 创造性资深研发；有实力，肯钻研；有激情，肯实干；
2. 知其然并知其所以然
3. **最**求工作效率
4. 追求极致（架构无小事）
5. UML 类图/活动图/状态图/架构图
6. 熟练git /awk语言 生成sql语句（快）
7. linux 理论知识/常用命令/网络/虚拟化/IO调优等

## TODO

1. 源码阅读
   1. ThreadLocal
   1. ThreadPoolExecutor
   1. ConcurrentHashMap
   1. HashMap (树) 不需要细节
1. 学习spring security时梳理http的安全认证
1. spring cache redis 实现
1. spring mvc mock
1. 会员idhbase分区设计
1. 打印二叉树算法
1. 日志框架梳理，如何实时更新日志级别 目标快速使用
1. 单元测试覆盖开发配置
1. mybatis 源码解读
1. spring-mybatis/spring-redis
1. spring事务
1. ~~java 日期操作~~ java8 
1. ssh 免密登陆原理
1. ssh-add/ssh-agent
1. Linux commands curl 细节填充
1. Lock
1. r/w Lock
1. 网络/netty 线程模型
1. JVM 调优常用工具 jps/jinfo/jstat/jmap/stack
1. shadowsockets 高级用法
1. http 认证
1. markdown 文档编写逐步转移到nvim中（全部放弃鼠标）
1. VM install nvim and config
1. Elasticsearch Cluster in Docker
1. Logstash 多pipeline
1. Elasticsearch monitor/Kibana monitor/Logstash monitor
1. gitlab -> jiro -> fisheye -jira
1. 数据库事务/Spring的事务
1. gradle 快速入门
1. rxjava
1. lambda 类/实例方法
1. 日志动态开关
1. spring config
1. ftp/smb 服务器
1. vpn服务器
1. 汉语舌前舌后音如何区分
1. JDK ConcurrentMap-based Cache 实现
1. spring cache redis 实现
1. SynchronousQueue
1. 封装自己的常用类
1. 2019-07-22 Java 堆实现中的范型实现 Comparable/Comparator
1. kafka
1. redis
1. es
1. netty
1. ArrayList/LinkedList/HashMap/ConcurrentHashMap -> Java Collections Framework
1. 复习algorithm java 实现代码 
1. ~~复习learn-basic final 用法~~
1. 1.8 Map/Map.Entry 新添加的default/static 方法



## 2019-08-01

### Java finally

see [FinallyTest.java](https://github.com/zhanfengGh/comfenglearn/blob/master/learn-basic/src/test/java/com/feng/learn/basic/FinallyTest.java)

```java
try {
	// do something
  return 0;
} catch (Exception e) {
	// do another thing
  return -1;
} finally {
	// do finally thing
  return 1;
}
// 方法肯定return 1
```

1. try 无异常 -> finally

1. try 有异常 -> catch -> finally

1. finally 有return，以finally return为主

   > try 和 catch 中 throw和return语句是一样的，finally中有return，以finally return为主

### Java final

1. final class -> 类不能被继承

1. final method -> 方法不能被重写

   > final 用于修饰static method `static final a()` 表示a方法不能被子类重写（隐藏）

1. final field / final static field -> 初始化后不能被重新赋值

   > 基本类型/String 在声明时直接赋值且编译时能确定值，会被编译器优化掉，直接变成常量
   >
   > final field / final static field / final local variable 都会被编译器执行宏替换

### maven not authorized

1. Check the servers section in the settings.xml file.Is username and password correct?

```html
<servers>
  <server>
    <id>serverId</id>
    <username>username</username>
    <password>password</password>
  </server>
</servers>
```

1. Check the repository section in the pom.xml file.**The id of the server tag should be the same as the id of the repository tag.**

```html
<repositories>
	<repository>
	  <id>serverId</id>  
	  <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
	</repository>
</repositories>
```

1. If the repository tag is not configured in the pom.xml file, look in the settings.xml file.

```html
<profiles>
	<profile>
	  <repositories>
	    <repository>
		    <id>serverId</id>
		    <name>aliyun</name>
		    <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
	    </repository>
	  </repositories>
	</profile>
</profiles>
```

Note that you should ensure that **the id of the server tag should be the same as the id of the repository tag.**


