## 构建历史

### jar-basic-archetype 1.1-RELEASE

- 此处为在1.0-RELEASE基础上新增的功能
- 添加源码打包功能
- todo

### jar-basic-archetype 1.0-RELEASE

- lombok
- junit
- slf4j/logback 日志打印到控制台

## 项目搭建

1. 配置maven-resources-plugin的编码为`UTF-8`

   ```xml
    <properties>
    	<!-- maven-resources-plugin 会自动读取此配置 -->
    	<project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>
   ```

2. 配置maven-compiler-plugin（IDE 编译时会读取此配置）

   ```xml
   <properties>
   	<!-- maven-compiler-plugin 会自动读取此配置 -->
   	<maven.compiler.source>1.8</maven.compiler.source>
   	<maven.compiler.target>1.8</maven.compiler.target>
   </properties>
   ```

3. 配置maven-source-plugin 打包源码

   ```xml
<plugin>
     <groupId>org.apache.maven.plugins</groupId>
     <artifactId>maven-source-plugin</artifactId>
     <version>3.1.0</version>
     <executions>
       <execution>
         <id>attach-sources</id>
         <phase>verify</phase>
         <goals>
         <goal>jar-no-fork</goal>
         </goals>
       </execution>
     </executions>
   </plugin>
   ```
   
   
   
4. 配置maven-toolchains-plugin

   1. 项目pom.xml 添加plugin及配置

      ```xml
        <build>
          <plugins>
            <!-- ${user.home}/.m2/toolchains.xml -->
            <plugin>
              <groupId>org.apache.maven.plugins</groupId>
              <artifactId>maven-toolchains-plugin</artifactId>
              <version>1.1</version>
              <executions>
                <execution>
                  <goals>
                    <goal>toolchain</goal>
                  </goals>
                </execution>
              </executions>
              <configuration>
                <toolchains>
                  <jdk>
                    <version>1.8</version>
                    <vendor>sun</vendor>
                  </jdk>
                </toolchains>
              </configuration>
            </plugin>
          </plugins>
        </build>
      ```

   2. ${user.home}/.m2/toolchains.xml 配置文件

      ```xml
      <?xml version="1.0" encoding="UTF8"?>
      <toolchains>
        <!-- JDK toolchains -->
        <toolchain>
          <type>jdk</type>
          <provides>
            <version>1.8</version>
            <vendor>sun</vendor>
          </provides>
          <configuration>
         <jdkHome>/Library/Java/JavaVirtualMachines/jdk1.8.0_201.jdk/Contents/Home</jdkHome>
          </configuration>
        </toolchain>
      </toolchains>
      ```

5. 