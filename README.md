
## Webstore : Java Based Micro Services ECommerce Application 

![Home](https://github.com/eginnovations/webstore/raw/master/docs/images/webstore-home-page.png)

## eG Service Topology 
![topology](https://github.com/eginnovations/webstore/raw/master/docs/images/webstore-eg-topology.png)

## This application can be executed in following modes

1.  Run the application without APM Agent attached to it
2.  Run the application with APM Agent using volume mount approach
3.  Run the application using embedded APM Agent

## Pre-requisites

-   Make sure you have JAVA 8 or JRE 8 installed.
-   Make sure you have maven installed.
-   Make sure you have git installed.
-   Make sure you have docker-compose installed.

## Compile and Build Application

**Step 1 :** To clone this application

```
git clone https://github.com/eginnovations/webstore.git
```

**Step 2 :** Navigate to application home directory

```
cd webstore
```

**Step 3 :** To build the application

```
mvn clean package
```

## Run the application without APM Agent

**Step 1 :** Navigate to application home directory (webstore) 

**Step 2 :** To build docker images and run all the application containers
```
docker-compose up -d --build
```

**Step 3 :** To ensure all containers started and running `docker ps -a` 

**Step 4 :** Open the browser and access the application using "http://DOCKER_HOST_IP:8070/webstore"

## Run the application with APM Agent using volume mount (Only Linux)

**Step 1 :** Navigate to directory "webstore/btm_volume_mount/" 

**Step 2 :** To build docker images and run all the application containers

```
docker-compose up -d --build
```

**Step 3 :** To ensure all containers started and running `docker ps -a` 

**Step 4 :** Open the browser and access the application using "http://DOCKER_HOST_IP:8070/webstore"

## Run the application using embedded APM Agent (APM Agent embedded inside container image)

**Step 1 :** Navigate to directory "webstore/btm_embedded/" 

**Step 2 :** To build docker images and run all the application containers

```
docker-compose up -d --build
```

**Step 3 :** To ensure all containers started and running `docker ps -a` 

**Step 4 :** Open the browser and access the application using "http://DOCKER_HOST_IP:8070/webstore"

## To stop the application

**Step 1 :** Navigate to directory where the docker-compose.yml is present and run the below command.

```
docker-compose down
```

## THIS IS FOR THE PURPOSES OF TRAINING OR INTERNAL USE ONLY, DO NOT SHARE TO CUSTOMER/PROSPECT/OTHERS
