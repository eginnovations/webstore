package com.online.payment.gateway;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class paymentController {
	
	public static int counter = 0;

	@RequestMapping("/visagecard/submitpayment")
	public String visaPaymentGateway() {
		try {
			Thread.sleep(1500);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		return "Success ! redirecting...";
	}

	//@RequestMapping("/master")
	//public String masterPaymentGateway() {
	//	try {
	//		Thread.sleep(20000);
	//	} catch (InterruptedException e) {
	//		e.printStackTrace();
	//	}
	//	System.out.println("called /master from paymentController - gateway");
	//	return "Could not get a timely response from the payment gateway!";
	//}

	// @RequestMapping("/masterfulcardpaymentgateway")
    // public ResponseEntity<?> masterPaymentGateway() {
		// if(counter >= 0 && counter < 5) {
			// ++counter;
			// try {
				// Thread.sleep(20000);
			// } catch (InterruptedException e) {
				// e.printStackTrace();
			// }
			// return new ResponseEntity<>("Could not get a timely response from the payment gateway!", HttpStatus.OK);
		// } else if (counter>=5 && counter<10) {
			// ++counter;
			// try {
				// Thread.sleep(10000);
			// } catch (InterruptedException e) {
				// e.printStackTrace();
			// }
			// return new ResponseEntity<>("Could not get a timely response from the payment gateway!", HttpStatus.INTERNAL_SERVER_ERROR);
		// } 
		// counter = 0;
		// try {
			// Thread.sleep(20000);
		// } catch (InterruptedException e) {
			// e.printStackTrace();
		// }
		// return new ResponseEntity<>("Could not get a timely response from the payment gateway!", HttpStatus.OK);
	// }
	
	@RequestMapping("/mastercard")
	@ResponseStatus(code=HttpStatus.INTERNAL_SERVER_ERROR,reason="Could not get a timely response from the payment gateway!")
	public String masterCardPaymentGateway() {
		try {
			Thread.sleep(10000);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		System.out.println("called /mastercard from masterCardPaymentGateway - gateway");
		return "Could not get a timely response from the payment gateway!";
	}
}
