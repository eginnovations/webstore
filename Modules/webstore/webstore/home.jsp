<%@ page import="org.json.*"%>
<%@ page import="org.springframework.http.HttpEntity"%>
<%@ page import="org.springframework.http.HttpHeaders"%>
<%@ page import="org.springframework.http.HttpMethod"%>
<%@ page import="org.springframework.http.MediaType"%>
<%@ page import="org.springframework.web.client.RestTemplate"%>
<%@ page import="org.springframework.web.util.UriComponentsBuilder" %>
<%@ page import="com.webstore.core.uriconstants.*" %>
<%@ page import="java.text.DecimalFormat" %>

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
    <link rel="stylesheet" href="slider/sliderResponsive.css">
		<link rel="shortcut icon" href="favicon.png" type="image/png" sizes="16x16">
  	<script src="lib/jquery.min.js"></script>
  	<script src="lib/bootstrap.min.js"></script>
  	<script src="slider/sliderResponsive.js"></script>
    <!-- <script src="lib/angular.min.js"></script>
    <script src="lib/angular-sanitize.js"></script>
    <script src="lib/angular-route.min.js"></script>
	 -->
    
    <link rel="stylesheet" href="css/styles.css">

    <!-- <script type="application/javascript" src="js/controller.js"></script> -->
    <!-- <script charset='UTF-8' type='text/javascript'> window['egrum-start_time'] = newDate().getTime(); window['Site_Name'] = '57affa47-5754-492b-8463-56a1dce7ab4f-1574516423978'; window['beacon-url'] = 'https://apm.eginnovations.com'; </script> <script src='https://apm.eginnovations.com/rumcollector/egrum.js' async> </script>  -->
  </head>
  
  <body class="ng-scope">
  	<div class="container">
		<jsp:include page="header.jsp"/>
		<div >
			<!--slider-->
			<div class="slider" id="slider1" style="margin-bottom:20px;">
    <!-- Slides -->
    <div style="background-image:url(slider/slider/image2.jpg)"></div>
    <div style="background-image:url(slider/slider/image1.jpg)"></div>
    <div style="background-image:url(slider/slider/image3.jpg)"></div>
    <!-- The Arrows -->
    <i class="left" class="arrows" style="z-index:2; position:absolute;"><svg viewBox="0 0 100 100"><path d="M 10,50 L 60,100 L 70,90 L 30,50  L 70,10 L 60,0 Z"></path></svg></i>
    <i class="right" class="arrows" style="z-index:2; position:absolute;"><svg viewBox="0 0 100 100"><path d="M 10,50 L 60,100 L 70,90 L 30,50  L 70,10 L 60,0 Z" transform="translate(100, 100) rotate(180) "></path></svg></i>
    <!-- Title Bar -->
    <span class="titleBar">
       <h1 class="ng-binding">Products</h1>
    </span>
</div>
<!-- end slider-->
			<!-- <h1>{{detTitle}}</h1>--->
		</div>
		
<%
	
	// CPU - HIKE
	
	/* try {
	
	boolean keepLooping = true;
	
	long timeStart = System.currentTimeMillis();
	
	// Continuous while loop to consume high CPU
	
	while(keepLooping){
	
	long timeNow = System.currentTimeMillis();
	
	// Release the while loop after 80 seconds ...
	
	if((timeNow - timeStart) >= (80 * 1000) ){
	
	keepLooping = false;
	
	}
	
	}
	
	}
	
	catch (Exception e){} */

		String catId = request.getParameter("cat");
		/*String productDomainUri = "http://"+"products.apm.eginnovations.com"+":4040";
		String PRODUCT_SERVER_URI = productDomainUri + "/products";
		String GET_PRODUCTS_BY_CATEGORY = "/catalog/categoryproduct";
		String GET_PRODUCT = "/catalog/product";*/
		
		int product_id = -1;
		

		String urlString = ServerUris.PRODUCT_SERVER_URI+URIConstants.GET_PRODUCT;
		if(catId!=null && catId.length() > 0){
			urlString = ServerUris.PRODUCT_SERVER_URI+URIConstants.GET_PRODUCTS_BY_CATEGORY;
				product_id = Integer.parseInt(catId);
		}
	
		RestTemplate restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.set("Accept", MediaType.APPLICATION_JSON_VALUE);

		JSONObject jsonObj = new JSONObject();    
		try {
			jsonObj.put("id", product_id);
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("url String = "+urlString);
		UriComponentsBuilder builder = UriComponentsBuilder.fromHttpUrl(urlString).queryParam("params", jsonObj);	
		HttpEntity<?> entity = new HttpEntity<>(headers);
		System.out.println("urlString Url = "+UriComponentsBuilder.fromHttpUrl(urlString).queryParam("params", jsonObj).build().toUri());
		HttpEntity<String> returnString = restTemplate.exchange(builder.build().toUri(), HttpMethod.GET, entity, String.class);
		
		JSONObject returnJsonObj = null;
		try {
			returnJsonObj = new JSONObject(returnString.getBody());
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//----
		if(returnJsonObj == null){
			response.sendRedirect("home.jsp?feedback=invalidid");
		}
		
		// out.println("returnJsonObj :"+returnJsonObj.toString());
		JSONArray productJArr = returnJsonObj.getJSONArray("products");
		int size = productJArr.length();

%>
		<div class="row">
<%
		
		for(int i=0;i<size;i++){
			JSONObject productJObj = productJArr.getJSONObject(i);
			int productId = productJObj.getInt("id");
			String productName = productJObj.getString("name");
			if(productName.length() > 16){
				productName = productName.substring(0,16);
			}
			String description = productJObj.getString("description");
			if(description.length() > 150){
				description = description.substring(0,150);
			}
			String country = productJObj.getString("country");
			String imageName = productJObj.getString("image");
			String visibilityString = productJObj.getString("visibility");
			int stock = productJObj.getInt("stock");
			int price = productJObj.getInt("price");
			int discount = productJObj.getInt("price") + 10;
			int save = discount - price;
			double priceVl=new Integer(price).doubleValue();
			double discVl=new Integer(discount).doubleValue();
			double calDiscount = (100.0 - ((priceVl/discVl) * 100.0));
	
			DecimalFormat df = new DecimalFormat("0.00");
			String calDiscountStr=df.format(calDiscount);
			String status = productJObj.getString("status");
			String skuString = productJObj.getString("sku");
			String urlKeyString = productJObj.getString("urlKey");
			String type = productJObj.getString("type");
			
			
%>
		<div class="col-sm-6 col-md-3 ng-scope" style="padding-bottom: 15px" ng-repeat="product in products">
			<div class="thumbnail" style="height:450px;">
				<div style="height:150px;text-align:center;line-height:150px;">
				<img ng-src="image/<%=imageName%>" alt="image" style="max-width:167px;max-height:167px;" src="image/<%=imageName%>">
				</div>
				<div class="caption">
					<h3 class="ng-binding productTitle"><%=productName%></h3>
					<p class="ng-binding description"><%=description%></p>
					<p class="ng-binding price"><span class="current-price"><sup>&#36;</sup><%=price%></span><span>&#36;<s style=""><%=discount%></s></span> | <span>save: <%=calDiscountStr%>% </span> </p>
					<p class="ng-binding">Available <%=stock%> units in stock</p>
					<p class="button-placeholder">
						<a href="addtocart.jsp?productId=<%=productId%>" class="btn btn-primary add-cart" style="left:100%; top:100%"> 
						<span class="glyphicon glyphicon-info-sign"></span> Add to Cart </a>
						<a href="viewcart.jsp" class="btn btn-default" style="left:100%; top:100%"> 	<span class="glyphicon-hand-right glyphicon"></span> View Cart
						</a>
					</p>
				</div>
			</div>
		</div>
<%
		}
%>
		</div>
		
		<!--<div class="footer pull-right" class="footer">-->
		<!--<div class="footer">
			<p>&copy; eG Java APM 2018</p>
		</div>-->
		<jsp:include page="footer.jsp"/>
	</div>
    <script>
$(document).ready(function() {
  
  $("#slider1").sliderResponsive({
  // Using default everything
     slidePause: 5000,
     fadeSpeed: 800,
     autoPlay: "on",
     showArrows: "off", 
     hideDots: "on", 
     hoverZoom: "on", 
     titleBarTop: "off"
  });
  
 
  
}); 
</script>
 </body>
 </html>
