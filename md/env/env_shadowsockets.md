#### SS 账号

1. vultr

   > ssr://MjA3LjI0Ni45MS45MDo2MTg4ODphdXRoX2NoYWluX2I6YWVzLTEyOC1jdHI6cGxhaW46V2k1bVpXNW5NakF4T1RBMk1EYw

1. YH_W.weilong

   > ssr://MTUyLjMyLjE4NS4xNjg6MTAwMDE6YXV0aF9jaGFpbl9hOmFlcy0yNTYtY2ZiOnRsczEuMl90aWNrZXRfYXV0aDphRGxLVWpoSS8_b2Jmc3BhcmFtPSZwcm90b3BhcmFtPSZyZW1hcmtzPVZWTkImZ3JvdXA9V1VoZlZ5NTNaV2xzYjI1bg

1. W.chao

   > https://cdnapi.fyapi.net/index.php?m=fyzhujicloudpane&command=FYAUTHAPISsrJsonSub&port=57742&authcode=FYZHUJI1441kyvWnBIRe23Rmav

####CentOS 搭建Shadowsocks服务端

1. 安装

   ```shell
   yum install python-setuptools;easy_install pip;pip install shadowsocks
   ```

2. 配置

   新建/etc/shadowsocks.json文件，内容如下

   ```json
   {
       "server": "0.0.0.0",
       "local_address": "127.0.0.1",
       "local_port": 1080,
       "port_password": {
           "10888": "Zfeng03295813",
          	"10889": "Wchao20190603"
       },
       "timeout": 300,
       "method": "camellia-256-cfb",
       "fast_open": false
   }	 
   ```
   
3. 运行

   1. 前台运行(Ctrl+C或者关闭终端服务会自动停止)：

      ```shell
      ssserver -c /etc/shadowsocks.json
      ```

   2. 后台运行(推荐，关闭终端后服务会继续运行)：

      ```shell
      ssserver -c /etc/shadowsocks.json -d start
      
      ssserver -c /etc/shadowsocks.json -d stop
      
      ssserver -c /etc/shadowsocks.json -d stop;ssserver -c /etc/shadowsocks.json -d start
      ```

4. 加速运行，youtube 1080P 无压力

   ```shell
   nohup java -Xmx128M -XX:+UseG1GC -XX:MaxGCPauseMillis=8 -jar /fs/fs.jar &> /fs/server.log  &
   ```

5. 