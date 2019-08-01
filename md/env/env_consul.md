#### consul 笔记

1. 安装

   ```shell
   brew install consul
   ```

2. 启动dev模式

   ```shell
   consul agent -dev -node machine
   ```

   http://127.0.0.1:8500/ui/dc1/services

3. 启动单节点集群，和dev模式的区别在于能保存数据

   ```shell
   nohup consul agent -server -bootstrap \
   -node=consul_server \
   -data-dir=/usr/local/var/lib/consul \
   -ui \
   &>/usr/local/var/log/consul/consul.log \
   &
   ```

4. brew services run/start/stop/restart consul

   > 注意：brew 默认安装的启动脚本只会启动-dev模式，把一下内容替换掉consul安装目录下(/usr/local/Cellar/consul/${version}/)的 **homebrew.mxcl.consul.plist**

   ```
   <?xml version="1.0" encoding="UTF-8"?>
   <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
   <plist version="1.0">
     <dict>
       <key>KeepAlive</key>
       <dict>
         <key>SuccessfulExit</key>
         <false/>
       </dict>
       <key>Label</key>
       <string>homebrew.mxcl.consul</string>
       <key>ProgramArguments</key>
       <array>
         <string>/usr/local/opt/consul/bin/consul</string>
         <string>agent</string>
         <string>-server</string>
         <string>-bootstrap</string>
         <string>-bind=127.0.0.1</string>
         <string>-node=consul_server</string>
         <string>-data-dir=/usr/local/var/lib/consul</string>
         <string>-ui</string>
       </array>
       <key>RunAtLoad</key>
       <true/>
       <key>WorkingDirectory</key>
       <string>/usr/local/var</string>
       <key>StandardErrorPath</key>
       <string>/usr/local/var/log/consul.log</string>
       <key>StandardOutPath</key>
       <string>/usr/local/var/log/consul.log</string>
     </dict>
   </plist>
   ```

   