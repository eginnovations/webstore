package com.eg.receiver;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.ObjectOutputStream;
import java.util.Scanner;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Podupload
 */
@WebServlet("/podupload")
public class Podupload extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Podupload() {
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
		// TODO Auto-generated method stub
		System.out.println("received");
		ServletContext context = getServletContext();
		String fullPath = context.getRealPath("//WEB-INF//lib//text1.txt");
		System.out.println(fullPath);
		String content = new Scanner(new File(fullPath)).useDelimiter("\\Z").next();
		System.out.println("content read");
		ServletOutputStream sos = response.getOutputStream();
		BufferedOutputStream out = new BufferedOutputStream(sos);
//		ObjectOutputStream out = new ObjectOutputStream(sos);
		out.write(content.getBytes());
		out.flush();
		out.close();

	}

}
