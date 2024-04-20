<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import = "java.net.*" %>

<%
	//인증분기
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>
<%
		String addCategory = request.getParameter("addCategory");

		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int row = 0;
		conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
		
		//INSERT INTO category(category,create_date) VALUES('캘러웨이',NOW());
		
		String sql = "INSERT INTO category(category,create_date) VALUES(?, NOW())";
		stmt = conn.prepareStatement(sql);
			stmt.setString(1, addCategory);
		System.out.println(stmt+"<<==stmt");
	
		
		row = stmt.executeUpdate();
			if(row==1 )
				{
					System.out.println("변경");
					response.sendRedirect("/shop/emp/categoryList.jsp");
				}  
			else 
				{
					System.out.println("변경실패");
					response.sendRedirect("/shop/emp/categoryList.jsp");
				}
			
%>
