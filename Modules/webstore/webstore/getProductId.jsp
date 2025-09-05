<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.json.*"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="org.springframework.http.HttpEntity"%>
<%@ page import="org.springframework.http.HttpHeaders"%>
<%@ page import="org.springframework.http.HttpMethod"%>
<%@ page import="org.springframework.http.MediaType"%>
<%@ page import="org.springframework.web.client.RestTemplate"%>
<%@ page import="org.springframework.web.util.UriComponentsBuilder" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Properties" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.FileNotFoundException" %>


<!DOCTYPE html>
<html><head><style type="text/css">@charset "UTF-8";[ng\:cloak],[ng-cloak],[data-ng-cloak],[x-ng-cloak],.ng-cloak,.x-ng-cloak,.ng-hide:not(.ng-hide-animate){display:none !important;}ng\:form{display:block;}</style>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Get Product Id</title>

    <!--link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
  	<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.4.0-beta.1/angular.min.js"></script>
  	<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.4.0-beta.1/angular-sanitize.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.0rc1/angular-route.min.js"></script-->
<!--      <link href="https://fonts.googleapis.com/css?family=Lato:400,400i,700,900&display=swap" rel="stylesheet"> -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
	<link rel="shortcut icon" href="">
  	<script src="lib/jquery.min.js"></script>
  	<script src="lib/bootstrap.min.js"></script>
   <script>
   </script>
   
    <link rel="stylesheet" href="css/styles.css">

	<style>

.row {
	margin-right: 0px;
	margin-left: 0px;
}

input[type=radio], input[type=checkbox] {
	margin: 0px 0 0;
	line-height: normal;
}

.loading {
	padding: 6px 10px 6px 42px;
	background-image: url("image/preloader_light.gif");
	background-repeat: no-repeat;
	background-position: 6px 7px;
	
	cursor: wait;
	border-width: 0px;
	background-color: #ffffff;
	color: #0e0e0e;
	font-size: 12px;
}

.noloading {
	
	background-repeat: no-repeat;
	background-position: 6px 7px;
	cursor: wait;
	border-width: 0px;
	color: #0e0e0e;
	font-size: 12px;
}

.tick {
	background-position: -96px 0 !important;
	background: url('image/new-status-icon.png') no-repeat top left;
	background-position-x: left;
	background-position-y: top;
	width: 24px !important;
	height: 24px !important;
	margin-bottom: 5px !important;
	margin-right: 5px !important;
	min-width: 24px;
	vertical-align: top;
}

.cross {
	/*float: right;*/
	display:inline-block;
	
	background-position: -157px -145px;
	width: 27px;
	height: 27px;
	background-image: url("image/eg_app_menu_sprite.png");
	list-style: none;
	font-family: calibri;
	font-size: 14px;
	line-height: normal;
	font-weight: 400;
	font-style: normal;
	color: #1a1a1a;
	margin-right:10px;
	min-width: 27px;
	background-repeat: no-repeat;
}
.form-signin {
  width: 100%;
  max-width: 275px;
  padding: 15px;
  margin: auto;
}

.form-heading {
    margin-top: 120px;
    margin-left: 300px;
}

.form-label-group {
  position: relative;
  margin-bottom: 1rem;
}

.form-label-group > input,
.form-label-group > label {
  height: 4.125rem;
  padding: .75rem;
}

.form-label-group > label {
  position: absolute;
  top: 0;
  left: 0;
  display: block;
  width: 100%;
  margin-bottom: 0; /* Override default `<label>` margin */
  line-height: 1.5;
   color: #d4d4d4;
  pointer-events: none;
  cursor: text; /* Match the input under the label */
  border: 1px solid transparent;
  border-radius: .25rem;
  transition: all .1s ease-in-out;
}

.form-label-group input::-webkit-input-placeholder {
  color: transparent;
}

.form-label-group input:-ms-input-placeholder {
  color: transparent;
}

.form-label-group input::-ms-input-placeholder {
  color: transparent;
}

.form-label-group input::-moz-placeholder {
  color: transparent;
}

.form-label-group input::placeholder {
  color: transparent;
}

.form-label-group input:not(:placeholder-shown) {
  padding-top: 1.25rem;
  padding-bottom: .25rem;
}

.form-label-group input:not(:placeholder-shown) ~ label {
  padding-top: .25rem;
  padding-bottom: .25rem;
  font-size: 12px;
  color: #d4d4d4;
}

/* Fallback for Edge
-------------------------------------------------- */
@supports (-ms-ime-align: auto) {
  .form-label-group > label {
    display: none;
  }
  .form-label-group input::-ms-input-placeholder {
    color: #777;
  }
}

/* Fallback for IE
-------------------------------------------------- */
@media all and (-ms-high-contrast: none), (-ms-high-contrast: active) {
  .form-label-group > label {
    display: none;
  }
  .form-label-group input:-ms-input-placeholder {
    color: #777;
  }
}
	</style>


  </head>

  
  <body ng-app="jvoid" class="ng-scope" style="">
  	<div class="container">
		<jsp:include page="header.jsp"/>
<div>
  <div class="form-heading">
    <h1 class="h3 mb-3 font-weight-normal">MySQL Slow Query</h1>
    <p>
<%
	// String jdbcUrl = "jdbc:mysql://192.168.8.94:3306/petclinic";
	// String driverClass = "com.mysql.jdbc.Driver";
	// String username = "root";
	// String password = "root";
	// String query = "select id from vets";

	//out.println("<br> <br> <h1>MySQL Database Call .....</h1>");
	
	Connection connection = null;
	Properties props = readPropertyFile();
	String jdbcUrl  = props.getProperty("url");
	String driverClass  = props.getProperty("driverClassName");
	String username  = props.getProperty("username");
	String password  = props.getProperty("password");
	// String query = "select id from discount_coupons where sleep(00.50)";
	String query = "select id from category_products where sleep(00.50)";
	
	out.println("<br> <br> Query : " + query);
	out.println("<br> <br> jdbcUrl : " + jdbcUrl);
	out.println("<br> <br> driverClass : " + driverClass);
	//out.println("<br> <br> username : " + username);
	//out.println("<br> <br> password : " + password);
	
	ResultSet resultSet = null;
	try {
			Class.forName(driverClass);
			connection = DriverManager.getConnection(jdbcUrl,username,password);
				PreparedStatement pstmt = connection.prepareStatement(query);
				resultSet = pstmt.executeQuery();
		} catch (Exception e) {
			e.printStackTrace();
			out.println("<br> <br> Exception : " + e);
		}
		finally{
			if (connection != null) {
					connection.close();
				}
		}
		try{
		  Thread.sleep(1*1000); // 1 secs
	  }
	  catch(Exception e)
		{}
	out.println("<br> <br> MySQL Connection Object :"+connection +" <br> <br> Result Set ::"+resultSet+"<br> <br>");
	
	
	
	
	
%>
<%!
public Properties readPropertyFile() {
		Properties props = null;
		String propFileName = "db.properties";
		try {
			props = new Properties();
			InputStream inputStream = getClass().getClassLoader().getResourceAsStream(propFileName);
			if (inputStream != null) {
				props.load(inputStream);
			}
		}catch(Exception e) {
			System.out.println("property file '" + propFileName + "' not found in the classpath");
			e.printStackTrace();
		}
		return props;
	}
%>
	
	
	</p>
  </div>
</div>
		<jsp:include page="footer.jsp"/>
	</div>
  </body>
  </html>
<%

session.removeAttribute("orderId");
session.removeAttribute("amount");
session.removeAttribute("tag");
%>