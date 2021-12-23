<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.io.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Scenario Test</title>
</head>
<body>
<%
/* if(request.getParameter("high")!=null){
	String file = application.getRealPath("/") +"WEB-INF/lib/text.txt";
	PrintWriter outer = response.getWriter();
	response.setContentLengthLong(new File(file).length());
	String content = null;
	try{
		 content = new Scanner(new File(file)).useDelimiter("\\Z").next();
		//outer.print(content);
	}catch(Exception e){
		e.printStackTrace();
	}
	outer.print(content);
	response.addHeader("res", "high");
}
else if(request.getParameter("medium")!=null){
	String file = application.getRealPath("/") +"WEB-INF/lib/text1.txt";
	PrintWriter outer = response.getWriter();
	response.setContentLengthLong(new File(file).length());
	String content = null;
	try{
		 content = new Scanner(new File(file)).useDelimiter("\\Z").next();
		outer.print(content);
	}catch(Exception e){
		e.printStackTrace();
	}
	outer.print(content);
	response.addHeader("res", "medium");
}
else if(request.getParameter("low")!=null){
	String file = application.getRealPath("/") +"WEB-INF/lib/text2.txt";
	PrintWriter outer = response.getWriter();
	response.setContentLengthLong(new File(file).length());
	String content = null;
	try{
		 content = new Scanner(new File(file)).useDelimiter("\\Z").next();
		//outer.print(content);
	}catch(Exception e){
		e.printStackTrace();
	}
	outer.print(content);
	response.addHeader("res", "low");
} */
if(request.getParameter("high")!=null){
	String file = application.getRealPath("/") +"WEB-INF/lib/text.txt";
	response.setContentType("APPLICATION/OCTET-STREAM");   
	  response.setHeader("Content-Disposition","attachment; filename=\"" + file + "\"");
	  java.io.FileInputStream fileInputStream=new java.io.FileInputStream(file);  
      
	  int i;   
	  while ((i=fileInputStream.read()) != -1) {  
	    out.write(i);   
	  }   
	  fileInputStream.close(); 
}
if(request.getParameter("medium")!=null){
	String file = application.getRealPath("/") +"WEB-INF/lib/text1.txt";
	response.setContentType("APPLICATION/OCTET-STREAM");   
	  response.setHeader("Content-Disposition","attachment; filename=\"" + file + "\"");
	  java.io.FileInputStream fileInputStream=new java.io.FileInputStream(file);  
      
	  int i;   
	  while ((i=fileInputStream.read()) != -1) {  
	    out.write(i);   
	  }   
	  fileInputStream.close(); 
}
if(request.getParameter("low")!=null){
	String file = application.getRealPath("/") +"WEB-INF/lib/text2.txt";
	response.setContentType("APPLICATION/OCTET-STREAM");   
	  response.setHeader("Content-Disposition","attachment; filename=\"" + file + "\"");
	  java.io.FileInputStream fileInputStream=new java.io.FileInputStream(file);  
      
	  int i;   
	  while ((i=fileInputStream.read()) != -1) {  
	    out.write(i);   
	  }   
	  fileInputStream.close(); 
}



%>
</body>
</html>