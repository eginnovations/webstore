package com.webstore.order.queue;

import java.io.IOException;

import javax.jms.Message;
import javax.jms.MessageListener;
import javax.jms.TextMessage;

import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jms.annotation.EnableJms;

import com.webstore.order.model.CartItem;
import com.webstore.order.model.CheckoutOrder;
import com.webstore.order.model.CheckoutOrderAddress;
import com.webstore.order.model.CheckoutOrderItem;
import com.webstore.order.service.CheckoutOrderAddressService;
import com.webstore.order.service.CheckoutOrderItemService;
import com.webstore.order.service.CheckoutOrderService;
import com.webstore.order.utils.Utilities;

@EnableJms
public class OrderListener implements MessageListener{
	
	@Autowired
	private CheckoutOrderService checkoutOrderService;
	
	@Autowired
	private CheckoutOrderAddressService checkoutOrderAddressService;
	
	@Autowired
	private CheckoutOrderItemService checkoutOrderItemService;
	
	public void setCheckoutOrderService(CheckoutOrderService checkoutOrderService){
		this.checkoutOrderService = checkoutOrderService;
	}

	public void setCheckoutOrderAddressService(CheckoutOrderAddressService checkoutOrderAddressService) {
		this.checkoutOrderAddressService = checkoutOrderAddressService;
	}

	public void setCheckoutOrderItemService(CheckoutOrderItemService checkoutOrderItemService) {
		this.checkoutOrderItemService = checkoutOrderItemService;
	}

	@Override
	public void onMessage(Message message) {
		 try {
			if(message instanceof TextMessage) {
				 TextMessage tmessage = (TextMessage) message;
			 	 JSONObject json = new JSONObject(tmessage);
				 addAddress(json);
			}
         } catch (Exception e) {
             e.printStackTrace();
         }
	}
	
	public void addAddress(JSONObject jsonParams){
		//{"cartId":1,"user":{"firstName":"Harry","lastName":"Matt","company":"Schogini","emailAddress":"test@schogini.com"},"billing":{"address":"PTP - 292","streetAddress2":"PTP Nagar","city":"Trivandrum","state":"Kerala","zip":"695038","country":"India","telephone":"1234567890","fax":"0123456789"},"shipping":{"address":"Ship PTP - 292","streetAddress2":"Ship PTP Nagar","city":"Trivandrum","state":"Kerala","zip":"695038","country":"India","telephone":"1234567890","fax":"0123456789"},"checkoutMethod":"COD","checkoutComment":"New comment"}
		
		int cartId = -1;
		JSONObject user = null;
		int userId = -1;
		JSONObject billing = null;
		JSONObject country = null;
		JSONObject shipping = null;
		String checkoutMethod = null;
		String checkoutComment = null;
		JSONObject cartObj = null;
		JSONArray cartItems = null;
		System.out.println("JVoidOrderController.addAddress(  jsonParams  ) ===============> "+jsonParams.toString());
		try {
			cartId = jsonParams.getInt("cartId");
			user = jsonParams.getJSONObject("user");
			userId = user.getInt("id");
			//userId = jsonParams.getInt("userId");
			billing = jsonParams.getJSONObject("billing");
			country = billing.getJSONObject("country");
			shipping = jsonParams.getJSONObject("shipping");
			checkoutMethod = jsonParams.getString("checkoutMethod");
			try {
				checkoutComment = jsonParams.getString("checkoutComment");
			} catch (Exception e) {
				checkoutComment = "No Comments";
			}
			cartObj = jsonParams.getJSONObject("cart");
			cartItems = cartObj.getJSONArray("items");
			
			/*Iterator itr = cartItemObj.keys();
			cartItems = new JSONArray();
			while (itr.hasNext()){
			    String key = (String) itr.next();
			    if(key.equals("total")) {
			    	continue;
			    }
			    cartItems.put(cartItemObj.getJSONObject(key));
			}*/
		} catch (JSONException e) {
			e.printStackTrace();
		}
		
		CheckoutOrder checkoutOrder = new CheckoutOrder();
		checkoutOrder.setStatus("Payment Complete");
		checkoutOrder.setCheckoutMethod(checkoutMethod);
		checkoutOrder.setCheckoutComment(checkoutComment);
		checkoutOrder.setCreatedAt(Utilities.getCurrentDateTime());
		checkoutOrder.setUpdatedAt(Utilities.getCurrentDateTime());
		checkoutOrder.setCustomerId(userId);
		this.checkoutOrderService.addCheckoutOrder(checkoutOrder);
		
		int insertedOrderId = checkoutOrder.getId();
		
		try {
			CheckoutOrderAddress checkoutOrderAddress = new CheckoutOrderAddress();
			checkoutOrderAddress.setOrderId(insertedOrderId);
			
			checkoutOrderAddress.setFirstname(user.getString("firstName"));
			checkoutOrderAddress.setLastname(user.getString("lastName"));
			checkoutOrderAddress.setCompany(user.getString("company"));
			checkoutOrderAddress.setEmail(user.getString("email"));
			
			checkoutOrderAddress.setAddressType("billing");
			checkoutOrderAddress.setStreet(billing.getString("address")+","+billing.getString("address2"));
			checkoutOrderAddress.setCity(billing.getString("city")+","+billing.getString("state"));
			checkoutOrderAddress.setCountryId(country.getString("code"));
			checkoutOrderAddress.setPostcode(billing.getString("zip"));
			checkoutOrderAddress.setTelephone(billing.getString("phone"));
			checkoutOrderAddress.setFax(billing.getString("fax"));
		
			checkoutOrderAddress.setCreatedAt(Utilities.getCurrentDateTime());
			checkoutOrderAddress.setUpdatedAt(Utilities.getCurrentDateTime());
			
			this.checkoutOrderAddressService.addCheckoutOrderAddress(checkoutOrderAddress);
			
			checkoutOrderAddress = null;
			checkoutOrderAddress = new CheckoutOrderAddress();
			checkoutOrderAddress.setOrderId(insertedOrderId);
			
			checkoutOrderAddress.setFirstname(user.getString("firstName"));
			checkoutOrderAddress.setLastname(user.getString("lastName"));
			checkoutOrderAddress.setCompany(user.getString("company"));
			checkoutOrderAddress.setEmail(user.getString("email"));
			
			checkoutOrderAddress.setAddressType("shipping");
			checkoutOrderAddress.setStreet(shipping.getString("address")+","+shipping.getString("address2"));
			checkoutOrderAddress.setCity(shipping.getString("city")+","+shipping.getString("state"));
			checkoutOrderAddress.setCountryId(country.getString("code"));
			checkoutOrderAddress.setPostcode(shipping.getString("zip"));
			checkoutOrderAddress.setTelephone(shipping.getString("phone"));
			checkoutOrderAddress.setFax(shipping.getString("fax"));
			
			checkoutOrderAddress.setCreatedAt(Utilities.getCurrentDateTime());
			checkoutOrderAddress.setUpdatedAt(Utilities.getCurrentDateTime());
			
			this.checkoutOrderAddressService.addCheckoutOrderAddress(checkoutOrderAddress);
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		///////ADDING ORDER ITEMS////////
		for(int i=0; i<cartItems.length(); i++) {
			CartItem cartItem = new CartItem();
			System.out.println("cartItems :"+cartItems +" cartItems.Size :"+cartItems.length());
			try {
				ObjectMapper mapper = new ObjectMapper();
				try {
					System.out.println("i  :"+i+"  "+cartItems.toString());
					String jsonString = cartItems.getJSONObject(i).toString();
					System.out.println("i  :"+i+" jsonString "+jsonString);
					cartItem = mapper.readValue(jsonString, CartItem.class);
					System.out.println("i  :"+i+" cartItem.toString():  "+cartItem.toString());
					//cartItem = mapper.readValue(cartItemObj.getString("items").toString(), CartItem.class);
				} catch (JsonParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (JsonMappingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			CheckoutOrderItem orderItem = new CheckoutOrderItem();
			orderItem.setOrderId(insertedOrderId);
			orderItem.setCreatedAt(Utilities.getCurrentDateTime());
			orderItem.setUpdatedAt(Utilities.getCurrentDateTime());
			orderItem.setParentId(cartId);
			
			orderItem.setProductId(cartItem.getProductId());
			orderItem.setAttributeId(cartItem.getAttributeId());
			orderItem.setStoreId(cartItem.getStoreId());
			orderItem.setIsVirtual(cartItem.getIsVirtual());
			orderItem.setSku(cartItem.getSku());
			orderItem.setName(cartItem.getName());
			orderItem.setDescription(cartItem.getDescription());
			orderItem.setFreeShipping(cartItem.getFreeShipping());
			orderItem.setQuantity(cartItem.getQuantity());
			orderItem.setPrice(cartItem.getPrice());
			orderItem.setBasePrice(cartItem.getBasePrice());
			orderItem.setRowTotal(cartItem.getRowTotal());
			orderItem.setBaseRowTotal(cartItem.getBaseRowTotal());
			orderItem.setRowWeight(cartItem.getRowWeight());
			orderItem.setProductType(cartItem.getProductType());
			
			this.checkoutOrderItemService.addCheckoutOrderItem(orderItem);
		}
		///////ADDING ORDER ITEMS////////
		
		JSONObject jsonObj = new JSONObject();
		try {
			jsonObj.put("orderId", insertedOrderId);
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
