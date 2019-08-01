### Maven 3套生命周期：

3套生命周期相互独立，互不影响。

1. clean 清理项目 pre-clean -->clean-->post-clean
1. default 构建项目
1. site 建立项目站点 pre-site-->site-->post-site-->site-deploy

### Maven 3种classpath

1. compile classpath 	编译classpath

   编译时，若引用了其他jar中的类，则这个jar包需要被classpath指定，否则会抛出变异异常

1. test classpath		测试classpath

1. runtime classpath	运行时classpath

### Maven 5中依赖范围

A–>B–>C。当前项目为A，A依赖于B，B依赖于C。知道B在A项目中的scope，那么怎么知道C在A中的scope呢？答案是： 
当C是test或者provided时，C直接被丢弃，A不依赖C； 
否则A依赖C，C的scope继承于B的scope。

1. compile 默认值

   编译/测试编译/测试运行/打包/项目运行都需要

1. test

   测试编译/测试运行时需要

   junit

1. runtime

   编译/测试编译都不需要

   需要打包

   只有测试运行/运行时需要（编译时不需要）

   mysql-connector-java

1. provided

   编译/测试编译/测试运行需要

   不打包 

   运行时由别的容器提供

   javax.servlet-api

1. system

1. import

### lifecycle phases 构建生命周期

编译部署线命令由上到下一次执行

validate, initialize, 

generate-sources, process-sources, 

generate-resources, process-resources (--> resources:resources), 

**compile** (--> compiler:compile), process-classes,

generate-test-sources, process-test-sources, 

generate-test-resources, process-test-resources (--> resources:testResources),

**test-compile** (--> compiler:testCompile), process-test-classes, 

**test** (-->surefire:test), 

prepare-package, **package**, 

pre-integration-test, integration-test, post-integration-test, 

verify, (此阶段可以绑定source:jar-no-fork，用来打包源码)

**install**, 

**deploy**, 

clean 线：pre-clean, **clean**, post-clean, 

site 线：pre-site, site, post-site, site-deploy

### goal 

in the format 

<plugin-prefix>:<goal> 

> source:jar

or <plugin-group-id>:<plugin-artifact-id>[:<plugin-version>]:<goal>

> org.apache.maven.plugins:maven-source-plugin:3.1.0:jar 



###  常用的构建生命周期

#### mvn clean

clean the target dir

#### mvn compile

mvn会调用一下2个goal去做2件事

1. maven-resources-plugin:2.6:resources 

   **处理并拷贝** `src/main/resources` 下的资源（配置文件）到 `target/classes/` 目录下

1. maven-compiler-plugin:3.1:compile

   编译`src/main/java` 目录下的java源文件并把class文件拷贝`/target/classes` 目录下

#### mvn test-compile

mvn会调用一下4个goal去做4件事

1. maven-resources-plugin:2.6:resources 

   **处理并拷贝** `src/main/resources` 下的资源（配置文件）到 `target/classes/` 目录下

1. maven-compiler-plugin:3.1:compile

   编译`src/main/java` 目录下的java源文件并把class文件拷贝`/target/classes` 目录下

1. maven-resources-plugin:2.6:testResources

   **处理并拷贝** `src/test/resources` 下的资源（配置文件）到 `target/test-classes/` 目录下

1. maven-compiler-plugin:3.1:testCompile 

   编译`src/test/java` 目录下的java源文件并把class文件拷贝`/target/test-classes` 目录下

#### mvn test

mvn会调用一下5个goal去做5件事

1. maven-resources-plugin:2.6:resources 

   **处理并拷贝** `src/main/resources` 下的资源（配置文件）到 `target/classes/` 目录下

1. maven-compiler-plugin:3.1:compile

   编译`src/main/java` 目录下的java源文件并把class文件拷贝`/target/classes` 目录下

1. maven-resources-plugin:2.6:testResources

   **处理并拷贝** `src/test/resources` 下的资源（配置文件）到 `target/test-classes/` 目录下

1. maven-compiler-plugin:3.1:testCompile 

   编译`src/test/java` 目录下的java源文件并把class文件拷贝`/target/test-classes` 目录下

1. maven-surefire-plugin:2.12.4:test

   运行测试

#### mvn package

mvn会调用一下6个goal去做6件事

1. maven-resources-plugin:2.6:resources 

   **处理并拷贝** `src/main/resources` 下的资源（配置文件）到 `target/classes/` 目录下

1. maven-compiler-plugin:3.1:compile

   编译`src/main/java` 目录下的java源文件并把class文件拷贝`/target/classes` 目录下

1. maven-resources-plugin:2.6:testResources

   **处理并拷贝** `src/test/resources` 下的资源（配置文件）到 `target/test-classes/` 目录下

1. maven-compiler-plugin:3.1:testCompile 

   编译`src/test/java` 目录下的java源文件并把class文件拷贝`/target/test-classes` 目录下

1. maven-surefire-plugin:2.12.4:test

   运行测试

1. maven-jar-plugin:2.4:jar

   打jar包或者其他war包/zip包等

### 常用的插件和goal

#### mvn resources:resources

1. maven-resources-plugin:2.6:resources 

   **处理并拷贝** `src/main/resources` 下的资源（配置文件）到 `target/classes/` 目录下

#### mvn resources:testResources

1. maven-resources-plugin:2.6:testResources

   **处理并拷贝** `src/test/resources` 下的资源（配置文件）到 `target/test-classes/` 目录下

#### mvn compiler:compile

1. maven-compiler-plugin:3.1:compile

   编译`src/main/java` 目录下的java源文件并把class文件拷贝`/target/classes` 目录下

#### mvn compiler:testCompile

1. maven-compiler-plugin:3.1:testCompile 

   编译`src/test/java` 目录下的java源文件并把class文件拷贝`/target/test-classes` 目录下

#### mvn surefire:test

1. maven-surefire-plugin:2.12.4:test

   运行测试

#### mvn jar:jar

1. 把`/target/classes`打包

#### mvn jar:test-jar

1. 把`/target/test-classes`打包

#### mvn source:jar

1. `src/java/`目录下的项目源码（包括`src/java/main`和`src/java/resources`)打包

#### mvn source:test-jar

1. `src/test/`目录下的测试源码（包括`src/test/main`和`src/test/resources`)打包

