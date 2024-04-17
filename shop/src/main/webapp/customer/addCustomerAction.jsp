<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "shop.dao.*" %>
<%
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String mail = request.getParameter("mail");
	String name = request.getParameter("name");
	String birth = request.getParameter("birth");
	String gender = request.getParameter("gender");
	//디버깅
	System.out.println("id="+id);
	System.out.println("pw="+pw);
	System.out.println("mail="+mail);
	System.out.println("name="+name);
	System.out.println("birth="+birth);
	System.out.println("gender="+gender);
	
	int row = CustomerDAO.addCustomer(id,pw,mail,name,birth,gender);

	if(row == 1){
		System.out.println("회원가입 성공");
		response.sendRedirect("./customerLoginForm.jsp");
	}else{
		System.out.println("회원가입 실패");
		response.sendRedirect("./addCustomerForm.jsp");
	}
 
	
/* response.sendRedirect("./loginForm"); 
 */
%>
 
