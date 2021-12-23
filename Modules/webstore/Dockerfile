FROM tomcat:8-jre8-alpine

ADD target/webstore.war /usr/local/tomcat/webapps/ 
ADD target/ContainerCommunication.war /usr/local/tomcat/webapps/ 

ADD change.log /opt/

CMD ["catalina.sh", "run"] 
