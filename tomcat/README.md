# zabbix通过jmx监控tomcat多实例
jmx（Java Management Extensions),即Java管理扩展。

环境
- zabbix3.4  
yum安装
- java 1.8
- tomcat 8.x
- tomcat统一路径

例如 /data/web/{tomcat_1,tomcat_2,tomcat_3}

监控项目
- 堆对象内存状态
- 非堆对象内存状态
- 线程状态
- 类状态
- 系统状态(文件打开数和负载)

部署步骤

### 一、导入xml文件，添加主机
### 二、发现脚本
### 三、定义key
### 四、jmx配置

在bin/catalina.sh添加这几行
```shell
# ----- Execute The Requested Command -----------------------------------------
export CATALINA_OPTS="$CATALINA_OPTS -Dcom.sun.management.jmxremote"
export CATALINA_OPTS="$CATALINA_OPTS -Djava.rmi.server.hostname=172.18.94.193"
export CATALINA_OPTS="$CATALINA_OPTS -Dcom.sun.management.jmxremote.port=60008"
export CATALINA_OPTS="$CATALINA_OPTS -Dcom.sun.management.jmxremote.ssl=false"
export CATALINA_OPTS="$CATALINA_OPTS -Dcom.sun.management.jmxremote.authenticate=false"
```

### 五、重启服务

重启tomcat

重启zabbix

systemctl restart  zabbix-agent.service 

其他:

catalina-jmx-remote.jar

wget http://central.maven.org/maven2/org/apache/tomcat/tomcat-catalina-jmx-remote/8.5.11/tomcat-catalina-jmx-remote-8.5.11.jar

cmdline-jmxclient-0.10.3.jar

wget http://crawler.archive.org/cmdline-jmxclient/cmdline-jmxclient-0.10.3.jar





