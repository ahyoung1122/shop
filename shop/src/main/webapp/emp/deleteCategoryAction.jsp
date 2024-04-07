<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
 <%
 	String filename = request.getParameter("filename");
 	String category = request.getParameter("category");
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String sql = "DELETE FROM category WHERE filename=?";
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, filename);
	
	int row = stmt.executeUpdate();
	//row = 0이면 삭제성공, 0이아니면 실패
	//성공,실패 둘다 goodsList로 response
	if(row == 0){
		System.out.println("goods삭제성공");
		response.sendRedirect("./goodsList.jsp");
	}else{
		System.out.println("goods삭제실패");
		response.sendRedirect("./goodsList.jsp");
	}
 
 
 %>
