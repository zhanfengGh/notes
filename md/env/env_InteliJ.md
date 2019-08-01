1. idea google code style

   > download https://github.com/google/styleguide/blob/gh-pages/intellij-java-google-style.xml
   >
   > InteliJ -> Preferences -> Editor -> Code Style -> Schema -> Import Schema -> intellij-java-google-stayle.xml

2. idea maven artifact index

   1. 开启shadowsock代理
   2. 开启命令行代理  export all_proxy=socks5://127.0.0.1:1086
   3. maven配置文件settings.xml去掉所有的mirror（尤其是阿里云的，深坑。可以下载插件，却不能下载index）
   4. idea -> Preferences -> Build -> Maven -> Repositories -> 选中https://repo.maven.apache.org/maven2 -> 点击update
   5. 由于开启了代理，maven central 仓库的下载速度那是溜溜的。

3. idea 解决卡在（hang）"Finished,saving caches"

   ```
   sudo nvim /etc/hosts
   127.0.0.1 localhost <hostnameOfMac>
   ```

   > 把上面的hostnameOfMac改为自己的mac名字，System Preferences -> Sharing -> "Computers on your local network can access your computer at: zhanfengzhangs-MacBook-Pro-18.local"
   >
   > zhanfengzhangs-MacBook-Pro-18.local即是我的mac的名字

4. jetbrains 激活

   > https://www.dropbox.com/s/f4b8jx9xo4huqhj/jetbrains-agent-lastest.zip?dl=0

5. 

