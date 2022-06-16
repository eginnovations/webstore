package com.eg.podcommunication;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileWriter;
import java.net.*;

/**
 * Servlet implementation class Podcommunication
 */
@WebServlet("/Podcommunication")
public class Podcommunication extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Podcommunication() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("Request Received, waiting for data download");
		BufferedReader bufferedReader = null;
		StringBuffer readingDataStrBfr = new StringBuffer();
		try {
			HttpURLConnection connection = null;
			String str = "test";
//			String urlString = "http://172.16.14.128:8080/ReceiverService/podupload";
			String urlString = "http://customer:80/ReceiverService/podupload";
			URL postUrl = new URL(urlString);
			System.out.println(postUrl);
			connection = (HttpURLConnection) postUrl.openConnection();
			connection.setRequestMethod("POST");
//			bufferedReader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
//			String strbuffrRdrData = null;
//			while ((strbuffrRdrData = bufferedReader.readLine()) != null) {
//				readingDataStrBfr.append(strbuffrRdrData);
//			}
			PrintWriter out = response.getWriter();
			int responseCode = connection.getResponseCode();
			out.println("responseCode is : " + responseCode);
			String data = null;
			String tempStr = null;
			if (responseCode == 200) {
//				out.println(readingDataStrBfr);
				System.out.println("connection was successful");
				BufferedInputStream bis = null;
				try {
					bis = new BufferedInputStream(connection.getInputStream());
					if(connection.getInputStream() == null) {
						System.out.println("input Stream is null");
					}
					if (bis != null) {
						byte[] contents = new byte[1024];

						int bytesRead = 0;
						String strFileContents; 
						while((bytesRead = bis.read(contents,0,1024)) != -1) { 
						    tempStr += new String(contents, 0, bytesRead);              
						}
					}
					ServletContext context = getServletContext();
					String fullPath = context.getRealPath("//WEB-INF//lib//text1.txt");
					File file = new File(fullPath);
					FileWriter fileWriter = new FileWriter(file);
					fileWriter.write(tempStr);
					fileWriter.flush();
					fileWriter.close();
					System.out.println("check message");
				} catch (Exception ee) {
					System.out.println("exception");
					ee.printStackTrace();
				}
			} else {
				out.println("connection not made");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
