<!DOCTYPE html>
<html><head><style type="text/css">@charset "UTF-8";[ng\:cloak],[ng-cloak],[data-ng-cloak],[x-ng-cloak],.ng-cloak,.x-ng-cloak,.ng-hide:not(.ng-hide-animate){display:none !important;}ng\:form{display:block;}</style>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>WebStore</title>
<!--       <link href="https://fonts.googleapis.com/css?family=Lato:400,400i,700,900&display=swap" rel="stylesheet"> -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
		<link rel="shortcut icon" href="favicon.png" type="image/png" sizes="16x16">
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

  </style>
  </head>

<body  class="ng-scope">
  	<div class="container">
		<jsp:include page="header.jsp"/>
		
		<div class="" style="display:none">
			<h1 class="ng-binding">&nbsp;&nbsp;</h1>
		</div>
		<div>
			<form class="form-signin formcenter" action="signup.jsp" method="POST">
				<legend class="productTitle">Sign Up Form</legend>
				
				<div class="row">
					<div class="large-12 columns">
						<label>Name<span style="color:red">*</span>:</label>
						<input type="text" placeholder="" name="firstName" id="firstName" style="width:100%" required/>
						<span style="color:red"></span>
					</div>
				</div><br>
				<div class="row">
					<div class="large-12 columns">
						<label>Email Address<span style="color:red">*</span>:</label>
						<input type="email" placeholder="user@domain.com" name="email" id="email" style="width:100%" ng-model="user.email" required/>
						<span style="color:red" ng-show="signup_form.email.$dirty && signup_form.email.$invalid">
						</span>
					</div>
				</div><br>
				<!--<div class="row">
				<div class="large-12 columns">
					<label>Password<span style="color:red">*</span>:</label>
		    		<input type="password" placeholder="********" name="password" id="inputPassword" size="40" ng-model="user.password" ng-minlength=5 required/>
		    		<span style="color:red" ng-show="signup_form.pass.$dirty && signup_form.pass.$invalid">
					</span>
		    	</div>
		    	</div><br> 
				<div class="row">
					<span ng-show="signup_form.pass.$dirty && signup_form.pass.$invalid">
						<div class="checkbox">
							<label>
							<input type="checkbox" value="remember-me"> Remember me </label>
						</div>
					</span>
				</div><br> -->
				<div class="row">
				<button class="btn btn-primary btn-lg btn-block" type="submit" style="width:100%">Submit</button>
				</div><br>
		  </form>
		  </div>

		<jsp:include page="footer.jsp"/>
	  </div> 
  </body>
</html>

