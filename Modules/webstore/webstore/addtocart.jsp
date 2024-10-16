<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="org.json.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.text.*"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="org.springframework.http.HttpEntity"%>
<%@ page import="org.springframework.http.HttpHeaders"%>
<%@ page import="org.springframework.http.HttpMethod"%>
<%@ page import="org.springframework.http.MediaType"%>
<%@ page import="org.springframework.web.client.RestTemplate"%>
<%@ page import="org.springframework.web.util.UriComponentsBuilder" %>


<%@ page import="com.webstore.core.uriconstants.*" %>




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
<!--      <link href="https://fonts.googleapis.com/css?family=Lato:400,400i,700,900|Playfair+Display&display=swap" rel="stylesheet"> -->
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
<%!

	public void logDebug(String type, String entity, String msg)
	{
		String logDateAndTime;
		PrintWriter logWriter = null;
		String log;
	
		java.util.Date date = new java.util.Date();
		logDateAndTime = getDateAndTime(date);

		 try
        {
//            System.setProperty("app.log.path", "E://server.log");
            String ss = System.getProperty("app.log.path");
            if (ss == null ||  ss.length() <= 0) {
                ss = "/opt/egapp/logs/server.log";
            }
            System.out.println("Log path: "+ss);
            logWriter = new PrintWriter(new FileWriter(ss, true));
        }
        catch (Exception e)
        {
            System.err.println("Cannot open log file ");
            e.printStackTrace();
        }
		log =
			new String(logDateAndTime + " " + type + " " + entity + " " + msg);
		if(logWriter != null) {
			logWriter.println(log);
			logWriter.close();
		}
	}

	private String getDateAndTime(java.util.Date d)
	{
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		return (sdf.format(d));
	}


	public int addtocart(int productId, HttpSession sessionObj) {
		int result = -1;
		try{
			RestTemplate restTemplate = new RestTemplate();
			HttpHeaders headers = new HttpHeaders();
			headers.set("Accept", MediaType.APPLICATION_JSON_VALUE);

			Integer cartIdObj = (Integer)sessionObj.getAttribute("cartId");
			int cartId = -1;
			if(cartIdObj != null){
				cartId = cartIdObj.intValue();
			}
			JSONObject jsonObj = new JSONObject();
			try {
				jsonObj.put("cartId", cartId);
				jsonObj.put("productId", productId);
				jsonObj.put("attributeId", 1);
				jsonObj.put("quantity", 1);
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			//System.out.println("param jsonObj=>"+jsonObj.toString());
			
			UriComponentsBuilder builder = UriComponentsBuilder.fromHttpUrl(ServerUris.QUOTE_SERVER_URI+URIConstants.ADD_PRODUCT_TO_CART)
					.queryParam("params", jsonObj);	
			HttpEntity<?> entity = new HttpEntity<>(headers);
			//System.out.println(" storing the product details in Quote server using URL  : " + builder.toString());
			HttpEntity<String> returnString = restTemplate.exchange(builder.build().toUri(), HttpMethod.GET, entity, String.class);
			JSONObject returnJsonObj = null;
			try {
				returnJsonObj = new JSONObject(returnString.getBody());
			} catch (JSONException e) {
				e.printStackTrace();
			}
			if(returnJsonObj!=null){
				result = returnJsonObj.getInt("cartId");
			}
			//System.out.println("INFO  CART-ACTION-ADD  There is an item added cart. ProductID = "+productId);
			//logDebug("INFO", "CART-ACTION-ADD", "There is an item added cart. ProductID = "+productId);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return result;
	}


%>
<%

	boolean flag = false;
	String productID = request.getParameter("productId");
	int product_id = -99;
	if(productID == null || productID.length() <= 0){
		response.sendRedirect("home.jsp?feedback=provideid");
	}
	product_id = Integer.parseInt(productID);

	// ---------------
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
		
		UriComponentsBuilder builder = UriComponentsBuilder.fromHttpUrl(ServerUris.PRODUCT_SERVER_URI+URIConstants.GET_PRODUCT).queryParam("params", jsonObj);	
		HttpEntity<?> entity = new HttpEntity<>(headers);
		//System.out.println(" getting the product details from Product server using URL  : " + builder.toString());
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
		JSONObject productJObj = productJArr.getJSONObject(0);

		String productName = productJObj.getString("name");

				logDebug("INFO", "| Item added to cart |", "ProductID:"+productID+" | ProductDescription:"+productName);

		String description = productJObj.getString("description");
		String country = productJObj.getString("country");
		String imageName = productJObj.getString("image");
		String visibilityString = productJObj.getString("visibility");
		int stock = productJObj.getInt("stock");
		int price = productJObj.getInt("price");
		int discount = productJObj.getInt("price") + 10;
		String status = productJObj.getString("status");
		String skuString = productJObj.getString("sku");
		String urlKeyString = productJObj.getString("urlKey");
		String type = productJObj.getString("type");
		if(type == null || type.equalsIgnoreCase("null")) type = "Product";
		
		int cartId = addtocart(product_id, session);
		if(cartId >= 0){
			session.setAttribute("cartId", cartId);
		}
	
%>
  
  <body class="ng-scope" style="">
  	<div class="container">
		<jsp:include page="header.jsp"/>
		
		<div class="col-md-12">
		  	<!-- ngView --><div ng-view="" class="ng-scope">


<div class="row"  style="margin:20px 0px;">
	<div class="col-md-5" style="text-align:center">
		<img ng-src="image/<%=imageName%>" alt="image" style="width:60%;border:#f0ad4e 1px solid;padding:5px;" src="image/<%=imageName%>">
		
	</div>

	<div class="col-md-5">
		<h3 class="ng-binding productName"><%=productName%></h3>
		<p>
		<fieldset class="rating">
		<input type="radio" id="star5" name="rating" value="5" /><label class = "full" for="star5" title="Awesome - 5 stars"></label>
		<input type="radio" id="star4half" name="rating" value="4 and a half" /><label class="half" for="star4half" title="Pretty good - 4.5 stars"></label>
		<input type="radio" id="star4" name="rating" value="4" /><label class = "full" for="star4" title="Pretty good - 4 stars"></label>
		<input type="radio" id="star3half" name="rating" value="3 and a half" /><label class="half" for="star3half" title="Meh - 3.5 stars"></label>
		<input type="radio" id="star3" name="rating" value="3" /><label class = "full" for="star3" title="Meh - 3 stars"></label>
		<input type="radio" id="star2half" name="rating" value="2 and a half" /><label class="half" for="star2half" title="Kinda bad - 2.5 stars"></label>
		<input type="radio" id="star2" name="rating" value="2" /><label class = "full" for="star2" title="Kinda bad - 2 stars"></label>
		<input type="radio" id="star1half" name="rating" value="1 and a half" /><label class="half" for="star1half" title="Meh - 1.5 stars"></label>
		<input type="radio" id="star1" name="rating" value="1" /><label class = "full" for="star1" title="Sucks big time - 1 star"></label>
		<input type="radio" id="starhalf" name="rating" value="half" /><label class="half" for="starhalf" title="Sucks big time - 0.5 stars"></label>
		</fieldset> <div style="float:left;margin: 6px;">| <a href="#">Be the first to write a review</a> | <a href="#">Read Reviews</a></div>
		<div style="clear:both"></div>
		<p>
		<p class="ng-binding description"><%=description%></p>
		<ol style="text-align:left;padding: 0px;list-style: none;text-align: left;margin: 25px 0px;">			
			<li><strong>Manufacturer</strong> : <%=country%></li>
			<li><strong>Item Code </strong> : <%=skuString%></li>
			<li><strong>Condition</strong> : <%=status%></li>
			<li><strong>Availble units in stock </strong> : <%=stock%></li>
		</ol>
		
		<h4 class="ng-binding"><span class="current-price" style="font-size:3rem"><sup>&#36;</sup><%=price%></span><span>&#36;<s style=""><%=discount%></s></span> | <span style="color:red">save:20%</span></h4>
		<p>
			<span class="text-success glyphicon glyphicon-ok btn btn-large"></span> <b class="text-success">Added To Cart </b>&nbsp;&nbsp;
			<a href="viewcart.jsp" class="btn btn-success btn-res" style="margin-bottom:5px">
				<span class="glyphicon-hand-right glyphicon"></span>View Cart
			</a> 
			<a href="home.jsp" class="btn btn-default btn-res" style="margin-bottom:5px">
				<span class="glyphicon-hand-left glyphicon"></span> back
			</a>
			<input type="hidden" value="<%=cartId%>" name="cardId">
		</p>

	</div>
</div></div>
		</div>
		<div style="clear:both"></div>
		<jsp:include page="footer.jsp"/>
	</div>
</body></html>