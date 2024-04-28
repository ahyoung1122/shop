<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import = "shop.dao.*" %>
<%@ page import = "java.sql.*" %>
<%
	
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
		System.out.println(ordersNo + "<==ordersListStatejsp.ordersNo");
	String state = request.getParameter("state");
		System.out.println(state + "<==ordersListStatejsp.state");
		//디버깅 들어오는거 까지 확인햇음.
		
		//업데이트문연결
		
	int orders = OrderGoodsDAO.updateState(state, ordersNo);
		System.out.println(orders + "orders임");
		//1들어온거 확인
		
	if(orders == 1){//업데이트성공
		response.sendRedirect("./ordersList.jsp");
	}else{
		response.sendRedirect("./ordersList.jsp");
	}
%>

