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
	//주문 처리하면서 해야할것 정리
	//// 장바구니에 담긴 상품 정보 가져오기
	//장바구니에 담긴 정보를 =>ordersTable에 추가하기
	
	
	// 주문자 정보 가져오기
	String id = request.getParameter("id");
		System.out.println(id + "<===orderGoodsAction.id");
	String name = request.getParameter("name");
		System.out.println(name + "<===orderGoodsAction.name");
	String mail = request.getParameter("mail");
		System.out.println(mail + "<===orderGoodsAction.mail");
	String phone = request.getParameter("phone");
		System.out.println(phone + "<===orderGoodsAction.phone");
	String address = request.getParameter("address");
		System.out.println(address + "<===orderGoodsAction.address");
	
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
		System.out.println(goodsNo + "<==orderGoodsAction.goodsNo");
	
		//...이거 왜 값이 하나만 들어오지? sql로 값을 한번 받아봐야겠음.. ;..
%>
