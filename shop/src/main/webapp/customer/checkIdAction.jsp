<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ page import="java.sql.*" %>
<%
Class.forName("org.mariadb.jdbc.Driver");
Connection conn = null;
PreparedStatement stmt = null;
ResultSet rs = null;
conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");

String mail = request.getParameter("mail");

String sql = "select mail from customer where mail=?";
// 결과가 있으면 이미 이 날짜에 일기가 있다=>이 날짜로는 입력불가!!
stmt = conn.prepareStatement(sql);
stmt.setString(1, mail);

rs = stmt.executeQuery();
if(rs.next()){
	//이 메일 사용 불가능(현재 존재함)
	response.sendRedirect("./addCustomerForm.jsp?mail="+mail+"&mailCheck=F");
}else { 
	//이 메일 사용가능
	response.sendRedirect("./addCustomerForm.jsp?mail="+mail+"&mailCheck=T");
	
}

%>