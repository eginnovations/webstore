package com.webstore.core.engine.web.jms;

import java.util.Properties;

import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.DeliveryMode;
import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.MessageProducer;
import javax.jms.QueueSession;
import javax.jms.Session;
import javax.jms.TextMessage;

import org.apache.activemq.ActiveMQConnectionFactory;

import com.webstore.core.engine.web.props.EnginePropertyReader;

public class OrderProcessingImpl {

	public void pushIntoQueue(Object jsonObject) {
		Connection connection = null;
		QueueSession session = null;
		try {
			EnginePropertyReader engineProps = new EnginePropertyReader();
			Properties jmsProps = engineProps.getEnginePropsObj();
			 String queueUrl = jmsProps.getProperty("ACTIVE_MQ_URL");
			 String queueName = jmsProps.getProperty("ACTIVE_QUEUE_NAME");
			 String sleepActivate = jmsProps.getProperty("ACTIVE_MQ_SLOW_METHOD_ACTIVATE");
			 String sleepTimeString = jmsProps.getProperty("ACTIVE_MQ_SLOW_METHOD_TIME");
			 
			 boolean activateSleep = Boolean.parseBoolean(sleepActivate);
			 long sleepTime = Long.parseLong(sleepTimeString);
			 if (activateSleep) {
				Thread.sleep(sleepTime);
			 }
			 ConnectionFactory connectionFactory = new ActiveMQConnectionFactory(queueUrl);
	         // Create a Connection
	         connection = connectionFactory.createConnection();
	         connection.start();
	         // Create a Session
	         session = (QueueSession) connection.createSession(false, Session.AUTO_ACKNOWLEDGE);

	         // Create the destination (Topic or Queue)
	         Destination destination = (Destination) session.createQueue(queueName);
	         
	         // Create a MessageProducer from the Session to the Topic or Queue
	         MessageProducer producer = (MessageProducer) session.createProducer(destination);
	         producer.setDeliveryMode(DeliveryMode.NON_PERSISTENT);
	         // Create a text messages
	         TextMessage message = session.createTextMessage(jsonObject.toString());
	         // Tell the producer to send the message
	         producer.send(message);
	         System.out.println("Message : "+ message  +" send to Queue "+queueName);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				connection.close();
			} catch (JMSException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}

