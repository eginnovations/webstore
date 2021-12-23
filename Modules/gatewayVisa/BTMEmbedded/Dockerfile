FROM store/oracle/serverjre:8
COPY egbtm /opt/egbtm
COPY target/gateway.jar /app/
WORKDIR /app
ENTRYPOINT ["java",  "-javaagent:/opt/egbtm/eg_btm.jar", "-jar", "gateway.jar"]
