#!/usr/bin/env bash
#目录权限
chmod -R 777 ~/app/jenkins
#tomcat
docker run -it --name tomcat -p 8080:8080 -v ~/app/tomcat:/usr/local/tomcat/webapps -d tomcat /bin/bash
#jenkins
docker run --name jenkins -p 8080:8080 -p 50000:50000 -v ~/app/jenkins:/var/jenkins_home -it -d jenkins
#mysql
docker run --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=admin -d mysql:5.7
docker run -p 3306:3306 --name mysql   -v /opt/mysql/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=admin -d mysql

#mysql远程授权
grant all privileges  on *.* to root@'%' identified by "h5767356q";
#gitlab
docker run --detach --hostname do.catarina.top --publish 443:443 --publish 80:80 --publish 22:22  --name gitlab  --restart always  --volume ~/app/gitlab/config:/etc/gitlab  --volume ~/app/gitlab/logs:/var/log/gitlab  --volume ~/app/gitlab/data:/var/opt/gitlab gitlab/gitlab-ce:latest

#nginx
docker run --detach \
    --name nginx \
    --publish 80:80 \
    -v ~/app/nginx/data:/usr/share/nginx/html:rw \
    -v ~/app/nginx/config/nginx.conf:/etc/nginx/nginx.conf:rw \
    -v ~/app/nginx/config/servers:/etc/nginx/servers:rw \
    -v ~/app/nginx/logs/error.log:/var/log/nginx/error.log:rw \
    -d nginx

