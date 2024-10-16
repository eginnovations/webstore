<%@page import="com.webstore.core.uriconstants.ProductCartDetails"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="org.json.*"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="org.springframework.http.HttpEntity"%>
<%@ page import="org.springframework.http.HttpHeaders"%>
<%@ page import="org.springframework.http.HttpMethod"%>
<%@ page import="org.springframework.http.MediaType"%>
<%@ page import="org.springframework.web.client.RestTemplate"%>
<%@ page import="org.springframework.web.util.UriComponentsBuilder" %>



<!DOCTYPE html>
<html><head><style type="text/css">@charset "UTF-8";[ng\:cloak],[ng-cloak],[data-ng-cloak],[x-ng-cloak],.ng-cloak,.x-ng-cloak,.ng-hide:not(.ng-hide-animate){display:none !important;}ng\:form{display:block;}</style>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>WebStore</title>

    <!--link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
  	<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.4.0-beta.1/angular.min.js"></script>
  	<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.4.0-beta.1/angular-sanitize.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.0rc1/angular-route.min.js"></script-->
<!--      <link href="https://fonts.googleapis.com/css?family=Lato:400,400i,700,900&display=swap" rel="stylesheet"> -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
		<link rel="shortcut icon" href="favicon.png" type="image/png" sizes="16x16">
  	<script src="lib/jquery.min.js"></script>
  	<script src="lib/bootstrap.min.js"></script>
   <!--  <script src="lib/angular.min.js"></script>
    <script src="lib/angular-sanitize.js"></script>
    <script src="lib/angular-route.min.js"></script>
    -->
    <link rel="stylesheet" href="css/styles.css">

    <!-- <script type="application/javascript" src="js/controller.js"></script> -->
  </head>


<%
	String orderId = null;
	String amount = null;
		
	Object orderIdObj = session.getAttribute("orderId");
	Object amountObj = session.getAttribute("amount");

		
	if(orderIdObj== null) {
        orderId=String.valueOf(ProductCartDetails.getOrderId(100,500));
    }else{
        orderId = String.valueOf(orderIdObj);
    }
    if(amountObj== null){
        amount=String.valueOf(ProductCartDetails.getTotalAmount(200,1500));
    }else{
        amount = String.valueOf(amountObj);
    }
	session.setAttribute("tag", String.valueOf("Order ID : " + orderId) + " | " + String.valueOf("Price : " + amount));
%>
  
  <body ng-app="jvoid" class="ng-scope" style="">
  	<div class="container">
		<jsp:include page="header.jsp"/>
		
		<div class="col-md-12">
		  	<!-- ngView --><div ng-view="" class="ng-scope"><!--
 * jVoiDView product
 * 
 * @author Shajir
 * @version 1.0
 *
 -->

<div class="jumbotron">
	<h2 class="ng-binding pagetitle">
		Payment processed Successfully! 
	</h2 >
	
	<p class="ng-binding">
		<small>Amount Paid is <b><%=amount%> USD</b> for the Order Number: <b><%=orderId%></b>
		</small>
	</p>
	<p>
	<a href="home.jsp" class="btn btn-default">
		<span class="glyphicon-hand-left glyphicon"></span> Continue shopping
	</a>
	</p>
</div>

</div>
</div>
		
		<jsp:include page="footer.jsp"/>
	</div>
</body></html>
<%

session.removeAttribute("orderId");
session.removeAttribute("amount");
ProductCartDetails.setOrderId(0);
ProductCartDetails.setTotalAmount(0);
%>