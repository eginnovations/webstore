<!DOCTYPE html>
<html>
<head>
<style type="text/css">@charset "UTF-8";[ng\:cloak],[ng-cloak],[data-ng-cloak],[x-ng-cloak],.ng-cloak,.x-ng-cloak,.ng-hide:not(.ng-hide-animate){display:none !important;}ng\:form{display:block;}</style>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>WebStore</title>
	
	
<!--     <link href="https://fonts.googleapis.com/css?family=Lato:400,400i,700,900&display=swap" rel="stylesheet"> -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
	<link rel="shortcut icon" href="">
  	<script src="lib/jquery.min.js"></script>
  	<script src="lib/bootstrap.min.js"></script>
	
</head>
<body>
<div><h1>There are three scenarios which of Bandwidth Consumption.</h1>
</div>
	<div><h3>High bandwidth consumption</h3>
		<form action="scenarioTest.jsp" method="post">
   			<p>Click on the button below to simulate high bandwidth consumption</p>
    		<input type="submit" name="high" value="high"/>
    	</form>
	</div>
	<div><h3>Medium bandwidth consumption</h3>
		<form action="scenarioTest.jsp" method="post">
   			<p>Click on the button below to simulate medium bandwidth consumption</p>
    		<input type="submit" name="medium" value="medium"/>
    	</form>
	</div>
	<div><h3>Low bandwidth consumption</h3>
		<form action="scenarioTest.jsp" method="post">
   			<p>Click on the button below to simulate low bandwidth consumption</p>
    		<input type="submit" name="low" value="low"/>
    	</form>
	</div>
</body>


</html>