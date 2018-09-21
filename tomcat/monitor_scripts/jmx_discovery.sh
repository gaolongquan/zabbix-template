#!/bin/bash

t_datadir=`find /data/web/tomcat*/bin/ -name catalina.sh|awk -F "/bin/catalina.sh" '{print $1}'`       
tomcat_no=`find /data/web/tomcat*/bin/ -name catalina.sh|awk -F "/bin/catalina.sh" '{print $1}'|wc -l`
#配置监控初始端口 
n_port=60000                                                                                
i=1
printf '{"data":[\n'
 
#输出JSON文件
for tomcat in $t_datadir                                                                   

do

    t_service=`echo "$tomcat"|awk -F"/" '{print $(NF)}'`

    if [ "$i" != ${tomcat_no} ];then

        printf "\t\t{ \n"

        printf "\t\t\t\"{#JMX_PORT}\":\"${n_port}\",\n"

        printf "\t\t\t\"{#JAVA_NAME}\":\"${t_service}\"},\n"

    else

        printf "\t\t{ \n"

        printf "\t\t\t\"{#JMX_PORT}\":\"${n_port}\",\n"

        printf "\t\t\t\"{#JAVA_NAME}\":\"${t_service}\"}]}\n"

    fi

    let "n_port=n_port+1"

    let "i=i+1"

done
