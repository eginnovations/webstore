package com.webstore.quote.queue;

import javax.jms.Message;
import javax.jms.MessageListener;

// EnableJms
public class OrderListener implements MessageListener{

	@Override
	public void onMessage(Message message) {
		 try {
             System.out.println("received: " + message);
         } catch (Exception e) {
             e.printStackTrace();
         }
	}
}
