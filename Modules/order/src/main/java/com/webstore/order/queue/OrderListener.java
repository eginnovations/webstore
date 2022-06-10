package com.webstore.order.queue;

import javax.jms.Message;
import javax.jms.MessageListener;
import javax.jms.TextMessage;

import org.springframework.jms.annotation.EnableJms;



@EnableJms
public class OrderListener implements MessageListener{
	

	
	@Override
	public void onMessage(Message message) {
		 try {
			if(message instanceof TextMessage) {
				 TextMessage tmessage = (TextMessage) message;
				 System.out.println(" retrived message : "+tmessage.getText());
				
			}
         } catch (Exception e) {
             e.printStackTrace();
         }
	}
	

	
}
