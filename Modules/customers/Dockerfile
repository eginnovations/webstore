FROM tomcat:8-jre8-alpine

ADD target/customers.war /usr/local/tomcat/webapps/ 
ADD pod-network/ReceiverService.war /usr/local/tomcat/webapps/ 

CMD ["catalina.sh", "run"] 
