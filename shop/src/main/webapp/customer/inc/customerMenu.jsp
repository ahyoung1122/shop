<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>

<%
   HashMap<String,Object> customerLogin
      = (HashMap<String,Object>)(session.getAttribute("CustomerLogin"));
	System.out.println(customerLogin);	
%>

      <a href="/customer/customerPage.jsp?id=<%=(String)(customerLogin.get("id"))%>">
      	<%=(String)(customerLogin.get("id"))%>님
      </a>
      <a href="./orderListByCustomer.jsp">CART</a>
