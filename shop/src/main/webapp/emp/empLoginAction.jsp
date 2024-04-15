<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.util.*" %>
<%@ page import = "shop.dao.*" %>
<%
   //0. 로그인 인증 분기 : 세션변수 이름 - loginEmp
/*    String loginEmp = (String)(session.getAttribute("loginEmp"));
   System.out.println(loginEmp + "<<==loginEmp"); */
   //  loginForm페이지는 로그아웃상태에서만 출력되는 페이지
   if(session.getAttribute("loginEmp") != null) {
      response.sendRedirect("/shop/emp/empList.jsp");
      return;
   }
//(사라질것) 1.controller
   String empId = request.getParameter("empId");
   String empPw = request.getParameter("empPw");
   
   //2.model
  	HashMap<String, Object>loginEmp = EmpDAO.empLogin(empId, empPw);
   
   //1.controller
	if(loginEmp == null){  // 로그인 실패
		System.out.println("로그인실패");
		String errMsg =  URLEncoder.encode("아이디와 비밀번호가 잘못되었습니다","utf-8");		
		response.sendRedirect("/shop/emp/empLoginForm.jsp?errMsg="+errMsg); // 자동으로 로그인페이지로 넘어감
				
	}else {		// 로그인실패
		System.out.println("로그인성공");
		session.setAttribute("loginEmp", loginEmp);	
		response.sendRedirect("/shop/emp/empList.jsp");
	}

%>