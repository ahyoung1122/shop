<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import = "shop.dao.*" %>

 <%
 
 //인증분기
   if(session.getAttribute("loginEmp") == null) {
      response.sendRedirect("/shop/emp/empLoginForm.jsp");
      return;
   }
 %>
 <%
 //db랑 연결
 	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
 	String goodsNo1 = request.getParameter("goodsNo");
 	int goodsNo = Integer.parseInt(goodsNo1);
 	
 	
 	System.out.println("goodsNo="+goodsNo);
	
	String sql = "DELETE FROM goods WHERE goods_no=?";
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1, goodsNo);
	
	int row = stmt.executeUpdate();
	//row = 0이면 삭제성공, 0이아니면 실패
	//성공,실패 둘다 goodsList로 response */
	if(row == 0){
		System.out.println("goods삭제성공");
		response.sendRedirect("./goodsList.jsp?goodsNo=?&category=?&totalRow=?");
	}else{
		System.out.println("goods삭제실패");
		response.sendRedirect("./goodsList.jsp");
	}
 
 %>
