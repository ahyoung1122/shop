<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%
	String mail = request.getParameter("mail");
	String pw = request.getParameter("pw");
	String name = request.getParameter("name");
	String birth = request.getParameter("birth");
	String gender = request.getParameter("gender");
	//디버깅
	System.out.println("mail="+mail);
	System.out.println("pw="+pw);
	System.out.println("name="+name);
	System.out.println("birth="+birth);
	System.out.println("gender="+gender);
	
	//db랑 연결시키기
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");

	String sql = "INSERT INTO customer(mail, pw, name, birth, gender, update_date, create_date) VALUES (?, ?, ?, ?, ?, NOW(), NOW())";
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, mail);
	stmt.setString(2, pw);
	stmt.setString(3, name);
	stmt.setString(4, birth);
	stmt.setString(5, gender);
	
	int row = stmt.executeUpdate();

	if(row == 1){
		System.out.println("회원가입 성공");
		response.sendRedirect("./loginForm.jsp");
	}else{
		System.out.println("회원가입 실패");
		response.sendRedirect("./addCustomerForm.jsp");
	}
 
	
/* response.sendRedirect("./loginForm"); 
 */
%>
 
