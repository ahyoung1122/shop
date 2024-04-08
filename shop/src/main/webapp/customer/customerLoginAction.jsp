<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.util.*" %>
<%
   if(session.getAttribute("loginCustomer") != null) {
      response.sendRedirect("/shop/customer/goodsList.jsp");
      return;
   }
%>
<%
//id랑 pw가져오기
String id = request.getParameter("id");
String pw = request.getParameter("pw");

System.out.println("id = "+id);
System.out.println("pw = "+pw);

//db랑 연결
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String loginSql = "SELECT id, pw FROM customer";
	   stmt = conn.prepareStatement(loginSql);
	   stmt.setString(1, id);
	   stmt.setString(2, pw);
	   rs = stmt.executeQuery();
	   
		if(rs.next()){  //로그인 성공 하면
			System.out.println("로그인성공");
			response.sendRedirect("/shop/customer/customerGoodsList.jsp");
					
		}else {		// 로그인실패 ->customerLogingForm.jsp
			System.out.println("로그인실패");
			String errMsg =  URLEncoder.encode("아이디와 비밀번호가 잘못되었습니다","utf-8");		
			response.sendRedirect("/shop/customer/customerLogingForm.jsp?errMsg="+errMsg); // 자동으로 로그인페이지로 넘어감
		}
		
		//자원반납
		rs.close();
		stmt.close();
		conn.close();

/*  
if(session.getAttribute("")) */
%>

<!--로그인이 완료되면 고객상품페이지로 이동 response.sendRedirect("./customerGoods.jsp"); -->