<%@ page import="org.json.*"%>
<%@ page import="java.util.*"%>
<%
		/* try{
			Random random = new Random();
			int min = 2000;
			int max = 2500;
			int randomNumber = random.nextInt(max + 1 - min) + min;
			//out.println(randomNumber);
			 Thread.sleep(randomNumber);
		}
		catch(Exception ex){

		} */
		JSONObject obj =(JSONObject)request.getSession().getAttribute("CustomerObj");
		System.out.println("************** obj" +obj);
		String firstName = "Sign Up | Sign In"; 
		
		if(obj!=null){
			try{
				firstName = obj.getString("firstName");
			}catch(Exception e){
				e.printStackTrace();
			}
			
		}
		//out.println()
        String email = (String) session.getAttribute("email");
		// out.println(email);
		if(email == null){
			// out.println("Inside ====>>  ");
			response.sendRedirect("home.jsp");
		}


		
		
 %>
 
 <!-- RUM Header -->
 <!--EG_RUM_SCRIPT-->

<!-- <script charset='UTF-8' type='text/javascript'>
window['egrum-start_time'] = new Date().getTime();
window['Site_Name'] = 'e2033f64-c6e1-44b7-89f1-f56e04c9af15-1636439915919';
window['beacon-url'] = 'https://apm.eginnovations.com';
if(!window['egrum-config']) window['egrum-config'] = {}; (function (config) {config.capture = { jsError:true, resourceDetails:true, ajax:true, ajaxCorrelation:false, fetch:false, spa:false, overwriteBtmUName:true, excludeURLPattern:'none', ajaxExcludeURLPattern:'none', includeURLPattern:'*'}; config.username ={ username_enabled:true, selectortype:'xpath', selectoridorpath:'//*[@id="username"]', selectorindex:1};})(window['egrum-config']);
</script>
<script src='https://apm.eginnovations.com/rumcollector/egrum.js' async> </script> -->
 
<%-- 
    String scriptContent = System.getenv("MY_SCRIPT"); // ENV variable
    if (scriptContent != null && !scriptContent.isEmpty()) {
--%>
    <!--
    <script>
        <%= scriptContent %>
    </script>
    -->
<%-- } --%>

 
 		<div class="col-md-12 header">
			<h1 class="text-muted"><a href="home.jsp"><img src="image/bigstore-logo.png" alt="bigstore"/><span style="display:none">WebStore</span></a></h1>
			<div ng-controller="navigationController" class="ng-scope">
				<ul class="nav nav-pills pull-left">
					<li><a href="home.jsp">Home</a></li>
					<li><a href="viewcart.jsp">Cart</a></li>
					<li class="dropdown-mainmenu">
						<a href="category.jsp" >Categories<span class="caret"></span></a>
			    		<ul class="dropdown-menu multi-level ng-binding" role="menu" aria-labelledby="dropdownMenu" ng-bind-html="htmlString">
							<li class="dropdown-submenu">
								<a href="home.jsp?cat=1">Books</a>
								<ul class="dropdown-menu">
									<li><a href="home.jsp?cat=2">Fiction</a></li>
									<li><a href="home.jsp?cat=3">Non-fiction</a></li>
								</ul>
							</li>
							<li class="dropdown-submenu">
								<a href="home.jsp?cat=4">Electronics</a>
								<ul class="dropdown-menu"><li><a href="home.jsp?cat=5">Mobile</a></li>
									<li><a href="home.jsp?cat=6">Mobile Accessories</a></li>
								</ul>
							</li>							
							<li class="dropdown-submenu">
								<a href="home.jsp?cat=19">Baby &amp; Kids</a>
								<ul class="dropdown-menu">
									<li><a href="home.jsp?cat=20">Kids Footwear</a></li>
									<li><a href="home.jsp?cat=21">Kids Clothing</a></li>
									<li><a href="home.jsp?cat=22">Toys</a></li>
									<li><a href="home.jsp?cat=23">Baby Care</a></li>
								</ul>
							</li>
						</ul>
					</li>
					<li class="dropdown-mainmenu">
						<a href="category.jsp" >Demo Scenarios<span class="caret"></span></a>
			    		<ul class="dropdown-menu multi-level ng-binding" role="menu" aria-labelledby="dropdownMenu" ng-bind-html="htmlString">
							<li class="dropdown-submenu">
								<a href="home.jsp?cat=25">Frontend</a>
								<ul class="dropdown-menu">
									<li><a href="home.jsp?">Excessive Image Resources</a></li>
									<li class="dropdown-submenu">
										<a href="home.jsp?cat=26">Ajax</a>
										<ul class="dropdown-menu">
											<li><a href="syncajax.jsp">Synchronous Ajax</a></li>
											<li><a href="manyajax.jsp">Fast & Parallel Ajax</a></li>
											<!--<li><a href="uncachedajax.jsp">Un Cached Ajax</a></li>-->
											<li><a href="heavycontentajax.jsp">Heavy Response Content</a></li>
										</ul>
									</li>
								</ul>
							</li>			
							<li class="dropdown-submenu">
								<a href="home.jsp?cat=25">Backend</a>
								<ul class="dropdown-menu">
								<li class="dropdown-submenu">
										<a href="home.jsp?cat=26">Java/JVM</a>
										<ul class="dropdown-menu">
											<li><a href="hicpu.jsp?">High CPU</a></li>
											<li><a href="slowPojo.jsp">Slow Java Method</a></li>
											<li><a href="deadloack.jsp">Thread Deadlock</a></li>
											<li><a href="highGcThread.jsp">High GC (garbage collection)</a></li>
										</ul>
									</li>
									<li class="dropdown-submenu">
										<a href="home.jsp?cat=26">SQL</a>
										<ul class="dropdown-menu">
											<!--<li><a href="excessiveSql.jsp">Excessive SQL (N+1 anti-pattern)</a></li>-->
											<!--<li><a href="tablelock.jsp">Table Lock</a></li>-->
											<li><a href="sqlTableException.jsp">SQL Table Exception</a></li>
											<li><a href="sqlSlowQuery.jsp">SQL Slow Query</a></li>
										</ul>
									</li>
									<li class="dropdown-submenu">
										<a href="home.jsp?cat=26">Web/Servlet Container</a>
										<ul class="dropdown-menu">
											<!--<li><a href="connectionPool.jsp">Connection Pool (DataSource) Exhaustion</a></li>
											<li><a href="threadpoollow.jsp">Thread Pool Exhaustion</a></li>
											<li><a href="ejbpoollow.jsp">EJB Pool Exhaustion</a></li>
											<li><a href="jmsQueue.jsp">JMS queue is clogged</a></li>-->
											<li><a href="servletprocessing.jsp">Servlet Processing Issues</a></li>
										</ul>
									</li>
									<li class="dropdown-submenu">
										<a href="home.jsp?cat=26">Network</a>
										<ul class="dropdown-menu">
											<!--<li><a href="excessiveSql.jsp">Excessive SQL (N+1 anti-pattern)</a></li>-->
											<li><a href="heavyPayload.jsp">Heavy Payload (Request)</a></li>
										</ul>
									</li>
								</ul>
							</li>
											
						</ul>
					</li>
					
				<!--	<%if(firstName.equals("Sign In") || firstName.length() == 0){%>
						  <li ng-hide="logined"><a href="signin.jsp" ng-click="signInButton()"><%= firstName %></a></li> 
						  <li ng-hide="logined"><a href="NewUser.jsp" ng-click="signInButton()">SignUp</a></li> 
						  
					<%}
					else {%>
						<li ng-hide="logined"><a href=""> Hi <span id="username"> <%= firstName %></span></a></li>
						<li><a href="logout.jsp">Logout</a></li>
					<% } %>
					-->	
					
				</ul>
				<div style="float:right" class="userblock">
					<%if(firstName.equals("Sign Up | Sign In") || firstName.length() == 0){%>
						  <div ng-hide="logined"><a href="NewUser.jsp" ng-click="signInButton()">Sign Up</a> <span style="color:#fff;">|</span> <a href="signin.jsp" ng-click="signInButton()">Sign In</a></div>  
					<%}
					else {%>
						<div ng-hide="logined" style="color:#fff;"><span style="color:#fff;padding:5px;">Hi</span><a  id="username" href=""><%= firstName %></a> | <a href="logout.jsp">Logout</a></div>
					<% } %>
				
				</div>
				<div style="clear:both"></div>
				<div class="modal fade ng-scope" title="WebStore Sign In" visible="showModal"><div class="modal-dialog"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button><h4 class="modal-title ng-binding">WebStore Login</h4></div><div class="modal-body" ng-transclude="">
				    <form role="form" class="ng-pristine ng-valid ng-scope">
						<div class="form-group">
							<label for="email">Email address</label>
							<input type="email" class="form-control" id="email" placeholder="Enter email">
						</div>
						<div class="form-group">
						  	<label for="password">Password</label>
						  	<input type="password" class="form-control" id="password" placeholder="Password">
						</div>
						<div class="form-group">
						  	<a ng-click="forgetPassWordAction()">Forget password?</a>
						</div>
						<button type="submit" class="btn btn-default" ng-click="submitAction()">Submit</button>
						<button type="submit" class="btn btn-default pull-right" ng-click="signupAction()">Sign Up</button>
				    </form>
				</div></div></div></div>
				
				<div class="modal fade ng-scope" title="Reset password" visible="showModalpass"><div class="modal-dialog"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button><h4 class="modal-title ng-binding">Reset password</h4></div><div class="modal-body" ng-transclude="">
				    <form role="form" class="ng-pristine ng-valid ng-scope">
						<div class="form-group">
							<label for="email">Email address</label>
							<input type="email" class="form-control" id="emailpass" placeholder="Enter email">
						</div>
		
						<button type="submit" class="btn btn-default" ng-click="submitEmailAction()">Submit</button>
				    </form>
				</div></div></div></div>
			</div>

		</div>