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
	<link rel="shortcut icon" href="">
  	<script src="lib/jquery.min.js"></script>
  	<script src="lib/bootstrap.min.js"></script>
    
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
	
	<script language="javascript">
		function callSynchronousAjax() {
		  var xhr = new XMLHttpRequest();
		  xhr.open("GET", "addressvalidationservice?sleepTime=3000&downloadBytes=0", false);
		  alert("1 Synchronous Ajax call sent successfully");
		  xhr.send(null);
		}
	</script>

  </head>

  
  <body ng-app="jvoid" class="ng-scope" style="" onload="javascript:callSynchronousAjax()">
  	<div class="container">
		<jsp:include page="header.jsp"/>
		<div>
			<form class="form-signin">
			  <div class="text-left mb-4">   
					</br></br>
					<h1 class="h3 mb-3 font-weight-normal">Synchronous Ajax Call</h1>
			  </div>
			</form>
		</div>
		<jsp:include page="footer.jsp"/>
	</div>	
  </body>
  </html>
