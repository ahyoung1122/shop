<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import = "java.net.*" %>
<%@ page import="shop.dao.*" %>

<%
	//인증분기
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>
<%
		String category = request.getParameter("category");

		int list = EmpCategoryDAO.categoryList(category);
		
		if(list == 1)
			{
				response.sendRedirect("/shop/emp/categoryList.jsp");
			}
		else
			{
				response.sendRedirect("/shop/emp/categoryList.jsp");
			}
%>
