<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>

<%
   HashMap<String,Object> customerLogin
      = (HashMap<String,Object>)(session.getAttribute("CustomerLogin"));
	System.out.println(customerLogin);	
%>
	
	<a href="./customerPage.jsp?id=<%=(String)(customerLogin.get("id"))%>">
		<%=(String)(customerLogin.get("id"))%>님
	</a>
	<a href="./customerMainPage.jsp">
		HOME
	</a>
	
	<a href="./customerGoodsList.jsp">
		GOODS
	</a>
	
	<a href="/shop/customer/customerLogout.jsp">
		LogOut
	</a>

