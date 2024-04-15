<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="shop.dao.*" %>
    <%//active랑 empId가져오기
    String active = request.getParameter("active");
    String empId = request.getParameter("empId");
    //디버깅
    //System.out.println(active);
    //System.out.println(empId);
	
    
    EmpDAO.modifyEmpActive(active, empId);
	response.sendRedirect("/shop/emp/empList.jsp");
	
		
	
	
	//active가 on인 경우랑 off인 경우 나눠서 분기
	

	
    %>