# localHttps
本地搭建 ip + https（目前仅支持chrome）


cd 到本目录
执行 ./mkcert.sh
输入密码时都输空就ok.

执行完命令后，在out目录下会生成需要的ca证书和服务器证书
其中：
ca.key  ca证书的key
ca.crt  ca证书
server.key 服务端key
server.crt 服务端crt
server.req 生成服务端crt的请求文件，忽略

目前该程序经测试，在chrome67下ok.

另外：
127.0.0.1 是始终允许的
localhost, 本地实际ip访问（需要修改conf/local.ext中的ip才能支持）

下面以apache安装为例：
```
Listen 4433
<VirtualHost  *:4433>
    ###SiteName safe.cn
    SSLEngine on
    SSLCertificateFile "${SRVROOT}/conf/ssl/safe.cn/server.crt"
    SSLCertificateKeyFile "${SRVROOT}/conf/ssl/safe.cn/server.key"
    DocumentRoot "E:/workspace/php_workspace/traffic"
    <Directory "E:/workspace/php_workspace/traffic">
        Options Indexes FollowSymLinks Includes ExecCGI
        AllowOverride all
        Require all granted
    </Directory>
    #ErrorLog    "../../logs/Apache/safecn-error.log"
    #TransferLog "../../logs/Apache/safecn-access.log"
    #ServerName  safe.cn
</VirtualHost>
```

其中server.crt, server.key就是通过mkcert.sh生成的证书文件

需要将ca.crt导入到受信任的根证书区。windows下只需双击ca.crt按照提示安装到受信任的
根证书去即可。
