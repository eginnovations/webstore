<%@page import="com.webstore.core.engine.web.jms.OrderProcessingImpl"%>
<%@page import="com.webstore.core.uriconstants.ProductCartDetails"%>
<%@ page import="org.json.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.text.*"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="org.springframework.http.HttpEntity"%>
<%@ page import="org.springframework.http.HttpHeaders"%>
<%@ page import="org.springframework.http.HttpMethod"%>
<%@ page import="org.springframework.http.MediaType"%>
<%@ page import="org.springframework.web.client.RestTemplate"%>
<%@ page import="org.springframework.web.util.UriComponentsBuilder"%>
<%@ page import="com.webstore.core.uriconstants.ServerUris"%>
<%@ page import="com.webstore.core.uriconstants.URIConstants"%>

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


%>


<!DOCTYPE HTML>
<html>
<head>
<style type="text/css">
@charset "UTF-8";

[
ng\:cloak
]
,
[
ng-cloak
]
,
[
data-ng-cloak
]
,
[
x-ng-cloak
]
,
.ng-cloak
,
.x-ng-cloak
,
.ng-hide
:not
 
(
.ng-hide-animate
 
){
display
:
 
none
 
!
important
;


}
ng\:form {
	display: block;
}
</style>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>WebStore</title>


<link rel="stylesheet" href="css/bootstrap.min.css">
	<link rel="shortcut icon" href="favicon.png" type="image/png" sizes="16x16">
<script src="lib/jquery.min.js"></script>
<script src="lib/bootstrap.min.js"></script>

<script>

	function paymentMethod(val) {
		document.getElementById('visastatus').innerHTML="";
		document.getElementById('masterstatus').innerHTML="";
		document.getElementById('loading-master').style.display = "none";
		document.getElementById('loading-visa').style.display = "none";
		var url = "";
		var request = new XMLHttpRequest();
		if (val == "visagepayment") {
			document.getElementById('loading-visa').style.display = "block";
		} else {
			document.getElementById('loading-master').style.display = "block";
		}

		// var url = "payment?gateway="+val;
		var url = "makepayment?gateway="+val;
		request.open("GET",encodeURI(url));
		request.onreadystatechange = function() {

			if (val == "visagepayment") {
				document.getElementById('loading-visa').style.display = "none";
			} else {
				document.getElementById('loading-master').style.display = "none";
			}

			if (this.readyState === 4 && (this.status === 200||this.status === 408||this.status === 500)) {
			
			<%JSONObject customerObj = (JSONObject) request.getSession().getAttribute("CustomerObj");
			
			if (customerObj == null || customerObj.equals("null")) {
				response.sendRedirect("signin.jsp");
				return;
			}
			System.out.println("I am inside this #### ");
			String lastName = customerObj.getString("lastName");
			if (lastName == null || lastName.equalsIgnoreCase("null"))
				lastName = "";
			String country = customerObj.getString("country");
			country = country.replace("\\", "");
			JSONObject countryJObj = new JSONObject(country);
			country = countryJObj.getString("name");
			String gender = customerObj.getString("gender");
			String city = customerObj.getString("city");
			String prefix = customerObj.getString("prefix");
			String postalCode = customerObj.getString("postalCode");
			String streetAddress1 = customerObj.getString("streetAddress1");
			if (streetAddress1 == null || streetAddress1.equalsIgnoreCase("null"))
				streetAddress1 = "";
			String taxNumber = customerObj.getString("taxNumber");
			String streetAddress2 = customerObj.getString("streetAddress2");
			if (streetAddress2 == null || streetAddress2.equalsIgnoreCase("null"))
				streetAddress2 = "";
			String dateOfBirth = customerObj.getString("dateOfBirth");
			String streetAddress3 = customerObj.getString("streetAddress3");
			if (streetAddress3 == null || streetAddress3.equalsIgnoreCase("null"))
				streetAddress3 = "";
			String firstName = customerObj.getString("firstName");
			String phone = customerObj.getString("phone");
			String middleName = customerObj.getString("middleName");
			int id = customerObj.getInt("id");
			String state = customerObj.getString("state");
			state = state.replace("\\", "");
			JSONObject stateJObj = new JSONObject(state);
			state = stateJObj.getString("name");
			String fax = customerObj.getString("fax");
			String email = customerObj.getString("email");
			int customerGroup = customerObj.getInt("customerGroup");
			String company = customerObj.getString("company");
			JSONObject cartItems = (JSONObject) session.getAttribute("cartItems");

			Integer cartIdObj = (Integer) session.getAttribute("cartId");
			int cartId = -1;
			if (cartIdObj != null) {
				cartId = cartIdObj.intValue();
			}

			JSONObject userJObj = new JSONObject();
			userJObj.put("id", id);
			userJObj.put("firstName", firstName);
			userJObj.put("lastName", lastName);
			userJObj.put("company", company);
			userJObj.put("email", email);

			JSONObject billingJObj = new JSONObject();
			billingJObj.put("address", streetAddress1);
			billingJObj.put("address2", streetAddress2);
			billingJObj.put("city", city);
			billingJObj.put("state", stateJObj);
			billingJObj.put("country", countryJObj);
			billingJObj.put("zip", postalCode);
			billingJObj.put("phone", phone);
			billingJObj.put("fax", fax);

			JSONObject result = new JSONObject();
			result.put("cartId", cartId);
			//remove it when using jboss server
			//result.put("cart", cartItems);
			//result.put("user", userJObj);
			//result.put("billing", billingJObj);
			//result.put("shipping", billingJObj);
			//result.put("checkoutMethod", "COD");

			session.removeAttribute("cartItems");
			System.out.println("result : "+result);
			int orderId = 0;
			double totalAmount = 0;
			String tag = "0 | 0";
			
			System.out.println(" After Success message from quote ");
			OrderProcessingImpl orderProcessingImpl = new OrderProcessingImpl();
			orderProcessingImpl.pushIntoQueue(result);
			
			try {

				totalAmount = result.getJSONObject("cart").getInt("total");
				System.out.println("totalAmount : "+totalAmount);
				RestTemplate restTemplate = new RestTemplate();
				HttpHeaders headers = new HttpHeaders();
				headers.set("Accept", MediaType.APPLICATION_JSON_VALUE);
				
				UriComponentsBuilder builder = UriComponentsBuilder.fromHttpUrl(ServerUris.QUOTE_SERVER_URI+URIConstants.CHECKOUT_CART).queryParam("params", result);
				HttpEntity<?> entity = new HttpEntity<>(headers);
				HttpEntity<String> returnString = restTemplate.exchange(builder.build().toUri(), HttpMethod.GET, entity, String.class);
				System.out.println(" Quote  Url returnString "+returnString);
				JSONObject returnJsonObj = null;
				returnJsonObj = new JSONObject(returnString.getBody());
				String responseStr = "";
				if (returnJsonObj.getString("result").equals("Success")) {
					
					//UriComponentsBuilder builder1 = UriComponentsBuilder.fromHttpUrl(ServerUris.ORDER_SERVER_URI + URIConstants.ADD_ORDER).queryParam("params", jsonParams);
					//HttpEntity<?> entity1 = new HttpEntity<>(headers);
					//System.out.println("Order Uri = "+UriComponentsBuilder.fromHttpUrl(ServerUris.ORDER_SERVER_URI + URIConstants.ADD_ORDER).queryParam("params", jsonParams).build().toUri());
					//HttpEntity<String> returnString1 = restTemplate.exchange(builder1.build().toUri(), HttpMethod.GET,entity1, String.class);
					//responseStr = returnString1.getBody();
				}
				
				JSONObject orderJobj = new JSONObject(responseStr);
				orderId = orderJobj.getInt("orderId");
				if(orderId == 0) {
		            orderId=ProductCartDetails.getOrderId(100,500);
		        }else{
		            orderId = orderJobj.getInt("orderId");
		        }
		        if(totalAmount == 0){
		            totalAmount=ProductCartDetails.getTotalAmount(200,1500);
		        }
				tag = String.valueOf("Order ID : " + orderId) + " | " + String.valueOf("Price : " + totalAmount);
				
				session.setAttribute("tag", tag);
				session.setAttribute("orderId", String.valueOf(orderId));
				session.setAttribute("amount", String.valueOf(totalAmount));
				System.out.println("INFO CHECKOUT-ACTION-SUCCESS  Cart items are checked out successfully !!!");
				//logDebug("INFO", "CHECKOUT-ACTION-SUCCESS", "Cart items are checked out successfully !!!");
				logDebug("INFO", "| Checkout success |", " TransactionValue:$"+totalAmount+" | OrderID:"+orderId);
			} catch (Exception e) {
				e.printStackTrace();
			}
			session.removeAttribute("billingDetails");
			session.removeAttribute("cartId");
			%>
			if (val == "visagepayment") {
				document.getElementById('visastatus').innerHTML = "<div style='display: flex;'><div class='tick'></div><div style='display:inline-block'>"+ this.responseText + "</div></div>";
				document.getElementById("signup_form").submit();
			} else {
				document.getElementById('masterstatus').innerHTML = "<div style='display: flex;'><div class='cross'></div><div style='display:inline-block;width:90%'>"+ this.responseText + "</div></div>";
			}

			}
		};
		request.send();
	}
</script>
<link rel="stylesheet" href="css/styles.css">


<!--  <script type="application/javascript" src="js/controller.js"></script> -->
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
	border-radius: 15px 15px 15px 15px !important;
	cursor: wait;
	border-width: 0px;
	background-color: #ffffff;
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
	min-width: 24px;
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


</style>
</head>

<body class="ng-scope" style="">
	<div class="container">
		<jsp:include page="header.jsp" />

		<div class="col-md-12" style="background: #fff;">
			<!-- ngView -->
			<div ng-view="" class="ng-scope">

				<div style="margin-top: 10px">
					<form name="signup_form" action="success.jsp" id="signup_form"
						method="POST">
						<fieldset>
							<table class="table"><tr>
							<td>
								<legend class="pagetitle">Billing-Address</legend>
								<span><%=streetAddress1%></span><br> <span><%=streetAddress2%>,
										<%=streetAddress3%></span><br> <span><%=city%></span><br> <span
										ng-show="isSStatesDisplay"><%=state%></span><br
										ng-show="isSStatesDisplay"> <span><%=country%></span><br>
									<span><%=postalCode%></span><br> <span>Phone: <%=phone%></span><br>
									<span>Fax: <%=fax%></span><br>
							</td>
							<td>							
								<legend class="pagetitle">Shipping-Address</legend>
									<span><%=streetAddress1%></span><br> <span><%=streetAddress2%>,
										<%=streetAddress3%></span><br> <span><%=city%></span><br> <span
										ng-show="isSStatesDisplay"><%=state%></span><br
										ng-show="isSStatesDisplay"> <span><%=country%></span><br>
									<span><%=postalCode%></span><br> <span>Phone: <%=phone%></span><br>
									<span>Fax: <%=fax%></span><br>
								
							</td>
							</tr></table>
						</fieldset>
					</form>
					<table style="width:100%">
						<tr>
							<td><legend class="pagetitle">Payment Method</legend></td>
						</tr>
						
						<tr>
							<td style="padding-bottom:20px"><button id="visa" name="visa" class="btn btn-success btn-lg radius paymentbtn" style="min-width: 200px" ng-disabled="" onclick="javascript:paymentMethod('visagepayment')">&nbsp;&nbsp;<b>Pay Using Visage Card   </b></button>
							<div style="display:inline-block;vertical-align: middle;"><div class="loading" id="loading-visa" style="position: relative;display:none">Submitting Payment Details to Gateway...</div> <div id="visastatus" class="msgstyle"></div></div>
							</td>
							
						</tr>
						
						<tr>
							<td><button id="master" name="master" class="btn btn-danger btn-lg  radius paymentbtn" style="min-width: 200px" onclick="javascript:paymentMethod('masterfulcardpayment')" ng-disabled="">&nbsp;&nbsp;<b>Pay Using Masterful Card</b></button><div style="display:inline-block;vertical-align: middle;"><div class="loading" id="loading-master" style="position: relative;display:none">Submitting Payment Details to Gateway...</div><div id="masterstatus" class="msgstyle"><div style='display:flex; justify-content: center;'></div></div></div></td>
							
						</tr>
						<tr><td><br></td></tr>
					</table>
				</div>
			</div>
		</div>
		<jsp:include page="footer.jsp" />
</body>
</html>