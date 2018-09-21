#!/bin/bash                                       

t_datadir=`find /data/web/tomcat*/bin/ -name catalina.sh|awk -F "/bin/catalina.sh" '{print $1}'`      
tomcat_no=`find /data/web/tomcat*/bin/ -name catalina.sh|awk -F "/bin/catalina.sh" '{print $1}'|wc -l`
#配置监控初始端口
n_port=60000
#提取主机IP                                                                                
local_ip=`ifconfig eth0|grep inet|awk '{print $2}'`                                 

for tomcat in $t_datadir

do

    m_no=`cat -n $tomcat/bin/catalina.sh|grep 'Execute The Requested Command'|awk '{print $1}'`    #提取代码插入位置

    \cp $tomcat/bin/catalina.sh  $tomcat/bin/catalina.sh_bak                                        #备份catalina.sh

    \cp /tmp/catalina-jmx-remote.jar  $tomcat/lib/catalina-jmx-remote.jar                           #复制文件到实例lib目录

    sed -i ''$m_no'a export CATALINA_OPTS="$CATALINA_OPTS -Dcom.sun.management.jmxremote"'  $tomcat/bin/catalina.sh                        #插入监控配置

    let "m_no=m_no+1"                                                                                                                      #设置行号

    sed -i ''$m_no'a export CATALINA_OPTS="$CATALINA_OPTS -Djava.rmi.server.hostname='$local_ip'"' $tomcat/bin/catalina.sh                 #插入监控配置

    let "m_no=m_no+1"                                                                                                                      #设置行号

    sed -i ''$m_no'a export CATALINA_OPTS="$CATALINA_OPTS -Dcom.sun.management.jmxremote.port='$n_port'"' $tomcat/bin/catalina.sh          #插入监控配置

    let "m_no=m_no+1"                                                                                                                      #设置行号

    sed -i ''$m_no'a export CATALINA_OPTS="$CATALINA_OPTS -Dcom.sun.management.jmxremote.ssl=false"' $tomcat/bin/catalina.sh               #插入监控配置

    let "m_no=m_no+1"                                                                                                                      #设置行号

    sed -i ''$m_no'a export CATALINA_OPTS="$CATALINA_OPTS -Dcom.sun.management.jmxremote.authenticate=false"' $tomcat/bin/catalina.sh      #插入监控配置

    let "n_port=n_port+1"

done
