<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.util.*"%>
<%@ page import = "java.util.*"%>


<%!

static class Constants {
	public static final String SYNC_OBJECT = new String("sync");
}

static class BlockedThreadService  {
	
	private boolean running = false;
	
	public void start() {
		ObjectManager.last = false;
		DbConnection.finish1 = false;
		ObjectManager db1 = new ObjectManager();
		try
		{
			Thread.sleep(2000);
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		DatabaseConnectorThread db = new DatabaseConnectorThread();
		System.out.println("INFO : "+new java.util.Date() +" : Started BLOCKED demo ...");
		this.running = true;
	}

	public void stop() {
		ObjectManager.last = true;
		DbConnection.finish1 = true;
		System.out.println("INFO : "+new java.util.Date() +" : Stopped BLOCKED demo ... ");
		this.running = false;
	}

	public String getName() {
		return "Blocked";
	}
	

	public boolean isRunning() {
		return this.running;
	}

	public void updateStatus(HashMap<String, String> statusMap) {
		if(this.running) {
			statusMap.put("blockedStatus", "newstatus");
			statusMap.put("blockedStopDisabled", "");
			statusMap.put("blockedStartDisabled", "disabled");
		}
		else {
			statusMap.put("blockedStatus", "newnotrunning2");
			statusMap.put("blockedStopDisabled", "disabled");
			statusMap.put("blockedStartDisabled", "");
		}
	}
}


static class DbConnection
{
	public static boolean finish1 = false;

	public static String sync = "test";
	public void getConnection()
	{
		synchronized (Constants.SYNC_OBJECT)
		{
			long l = 0L;
			while (!finish1)
			{
				try 
				{
					Thread.sleep(3600);
				}
				catch (Exception ex) 
				{
					ex.printStackTrace();
				}
			}
		}
	}
}


static class DatabaseConnectorThread extends Thread
{

	public DatabaseConnectorThread()
	{
		this.setName("DatabaseConnectorThread");
		start();
	}
	public void run ()
	{
		PoolManager pm = new PoolManager();
		pm.getConnectionPool();
	}

}


static class PoolManager
{

	public void getConnectionPool()
	{
		DbConnection db = new DbConnection();
		db.getConnection();
	}
}


static class ObjectManager extends Thread
{
	public static boolean last = false;
	//public static String mysync = "test";
	public ObjectManager()
	{
		this.setName("ObjectManagerThread");
		start();
	}


	public void run ()
	{
		synchronized (Constants.SYNC_OBJECT)
		{
			long l = 0L;
			while (!last)
			{
				try
				{
					Thread.sleep(3600);
				}
				catch (Exception ex) 
				{
					ex.printStackTrace();
				}
			}
		}
	}

}

BlockedThreadService blockedThreadService = new BlockedThreadService();

%>

<html>
  <head>
    <title>Blocked Thread</title>
  </head>
  <body>
	<h1 style="text-align:center">Blocked Thread Demo</h1>

<%
	
	String actionString = request.getParameter("action");
	String status = "";
	if(actionString!=null){
		//out.println("actionString is :"+actionString);
		if(actionString.equalsIgnoreCase("start")){
			blockedThreadService.start();
			status = "Blocked Thread(s) are created !!!";
		}
		else if(actionString.equalsIgnoreCase("stop")){
			blockedThreadService.stop();
			status = "All Blocked Thread(s) are stopped !!!";
		}
	}

	String context = request.getContextPath();
	String startUrl = context+"/BlockedDemo.jsp?action=start";
	String stopUrl = context+"/BlockedDemo.jsp?action=stop";

%>
	<table align="center" border="1" cellpadding="1" cellspacing="1" style="width:500px">
		<tbody>
			<tr>
				<td rowspan="2" style="text-align:center; width:150px">Blocked Threads</td>
				<td style="text-align:center; width:149px">
					<button type = "button" onclick = "location.href='<%=startUrl%>'"> Start </button></td>
				<td style="text-align:center; width:188px">
					<button type = "button" onclick = "location.href='<%=stopUrl%>'"> Stop </button></td>
			</tr>
			<tr>
				<td colspan="2" rowspan="1" style="text-align:center;width:194px">&nbsp;<%=status%></td>
			</tr>
		</tbody>
	</table>

	<p>&nbsp;</p>
  </body>
</html>
