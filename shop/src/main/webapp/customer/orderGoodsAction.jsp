<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*" %>
<%
//인증분기 
if(session.getAttribute("CustomerLogin") == null) 
	{    
	    response.sendRedirect("/shop/customer/customerLoginForm.jsp");
	    return;
 	}
	//로그인값 잘 넘어오는지 확인
	System.out.println(session.getAttribute("CustomerLogin") + "<==orderGoodsAction에서 확인");
%>
<%
HashMap<String, Object> login = (HashMap<String, Object>)(session.getAttribute("CustomerLogin")); 
String id = (String)(login.get("id"));
	// 추가된 주문자 정보 customer테이블에 넣기 //주소는 api값이 넘어오질 않으니까일단 보류
	String phone = request.getParameter("phone");
		System.out.println(phone + "<===orderGoodsAction.phone");
	
	//update문으로 customer정보 추가
	int row = CustomerDAO.addInfo(phone, id);
		System.out.println(row + "<==orderGoodsAction.row");
		//들어오는거 확인
	
		if(row == 1)//성공
			{
				System.out.println("추가성공");
				response.sendRedirect("./customerPage.jsp");
			}else
				{
				System.out.println("추가실패");
				response.sendRedirect("./orderGoods.jsp");
				}

%>
