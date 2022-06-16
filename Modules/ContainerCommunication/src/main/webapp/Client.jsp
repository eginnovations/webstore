<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Client Side</title>
<script>
		function makeConnection(){
			var url = "/ContainerCommunication/Podcommunication";
			
			var xhr = new XMLHttpRequest();
			if (!window.XMLHttpRequest)
                xhr = new ActiveXObject("Microsoft.XMLHTTP");
				xhr.open("POST",url,true);
				xhr.setRequestHeader("Content-type", "text/plain; charset=UTF-8");
				xhr.send("test");
				console.log(url);
				document.getElementById("final").innerHTML="successful call made";
				
		}
	
	</script>
</head>
<body>
<h1>This is a client side code</h1>


<%

	


%>
	<p>Click on the button below to start communication with Server</p>
	<button onclick="javascript:makeConnection()">Click here</button>
	
	
	<p id = "final"></p>

</body>
</html>