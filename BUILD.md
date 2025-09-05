**To Build Specific Service-**
	
	cd /opt/github_demo_apps/webstore
	mvn clean package -f Modules/customers/pom.xml 
	mvn clean package -f Modules/order/pom.xml 
	mvn clean package -f Modules/payment/pom.xml 
	mvn clean package -f Modules/products/pom.xml 
	mvn clean package -f Modules/quote/pom.xml 
	mvn clean package -f Modules/webstore/pom.xml 

	cd /opt/github_demo_apps/webstore/Modules/webstore
	docker build --pull --squash -t egapm/new-webstore:webstore_2025 .
	docker push egapm/new-webstore:webstore_2025

	cd /opt/github_demo_apps/webstore/Modules/order
	docker build --pull --squash -t egapm/new-webstore:order_2025 .
	docker push egapm/new-webstore:order_2025

	cd /opt/github_demo_apps/webstore/Modules/customers
	docker build --pull --squash -t egapm/new-webstore:customer_2025 .
	docker push egapm/new-webstore:customer_2025

	cd /opt/github_demo_apps/webstore/Modules/payment
	docker build --pull --squash -t egapm/new-webstore:payment_2025 .
	docker push egapm/new-webstore:payment_2025

	cd /opt/github_demo_apps/webstore/Modules/products
	docker build --pull --squash -t egapm/new-webstore:products_2025 .
	docker push egapm/new-webstore:products_2025


	cd /opt/github_demo_apps/webstore/Modules/quote
	docker build --pull --squash -t egapm/new-webstore:quote_2025 .
	docker push egapm/new-webstore:quote_2025

	cd /opt/github_demo_apps/webstore/Modules/mysqldb
	docker build --pull --squash -t egapm/new-webstore:mysql_8.1.0_2025 .
	docker push egapm/new-webstore:mysql_8.1.0_2025

		

