package com.webstore.order.queue;

import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.Session;

import org.springframework.jms.core.JmsTemplate;
import org.springframework.jms.core.MessageCreator;

public class OrderProducer {

	 private JmsTemplate jmsTemplate;
	    private Destination destination;
	     
	    public JmsTemplate getJmsTemplate() {
	        return jmsTemplate;
	    }
	 
	    public void setJmsTemplate(JmsTemplate jmsTemplate) {
	        this.jmsTemplate = jmsTemplate;
	    }
	     
	    public Destination getDestination() {
	        return destination;
	    }
	 
	    public void setDestination(Destination destination) {
	        this.destination = destination;
	    }
	 
	    public void sendMessage(final String msg) {
	        System.out.println("orderProducer sends " + msg);
	        jmsTemplate.send(destination, new MessageCreator() {
	            public Message createMessage(Session session) throws JMSException {
	                return session.createObjectMessage(msg);
	            }});        
	    }
}
