FROM store/oracle/serverjre:8

COPY target/gatewayMaster.jar /app/
WORKDIR /app
ENTRYPOINT ["java", "-jar", "gatewayMaster.jar"]
