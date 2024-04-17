<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ page import="java.sql.*" %>
  <%@ page import="shop.dao.*" %>
<%
String id = request.getParameter("id");

boolean idcheck = CustomerDAO.checkId(id);
//가능하면 CustomerDAO.checkId(id)안에 있는 
//+변수의 이름은 사용하지 않는것이 바람직하다.
if(idcheck == false){
	response.sendRedirect("./addCustomerForm.jsp?id="+id+"&idCheck=F");
	System.out.println("사용불가능");
	System.out.println("false일때==>"+idcheck);
}else{
	response.sendRedirect("./addCustomerForm.jsp?id="+id+"&idCheck=T");
	System.out.println("사용가능");
	System.out.println("true일때==>"+idcheck);
}


%>