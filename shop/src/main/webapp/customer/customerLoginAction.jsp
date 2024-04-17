<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.util.*" %>
<%@ page import = "shop.dao.*" %>
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

	HashMap<String, Object>CustomerLogin = CustomerDAO.LoginCustomer(id, pw);
	
	if(CustomerLogin == null){  // 로그인 실패
		System.out.println("로그인실패");
		String errMsg =  URLEncoder.encode("아이디와 비밀번호가 잘못되었습니다","utf-8");		
		response.sendRedirect("/shop/customer/customerLoginForm.jsp?errMsg="+errMsg); // 자동으로 로그인페이지로 넘어감
				
	}else {		// 로그인실패
		System.out.println("로그인성공");
		session.setAttribute("CustomerLogin", CustomerLogin);	
		response.sendRedirect("/shop/customer/customerGoodsList.jsp");
	}
	/* 
	//if(rs.next()){  //로그인 성공 하면
		System.out.println("로그인성공");
		response.sendRedirect("/shop/customer/customerGoodsList.jsp");
				
	}else {		// 로그인실패 ->customerLogingForm.jsp
		System.out.println("로그인실패");
		String errMsg =  URLEncoder.encode("아이디와 비밀번호가 잘못되었습니다","utf-8");		
		response.sendRedirect("/shop/customer/customerLogingForm.jsp?errMsg="+errMsg); // 자동으로 로그인페이지로 넘어감
	} */

%>

<!--로그인이 완료되면 고객상품페이지로 이동 response.sendRedirect("./customerGoods.jsp"); -->