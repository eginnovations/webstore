FROM store/oracle/serverjre:8

COPY target/gatewayVisa.jar /app/
WORKDIR /app
ENTRYPOINT ["java", "-jar", "gatewayVisa.jar"]
