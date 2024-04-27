<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	System.out.println(session.getAttribute("CustomerLogin")+"<==CustomerLogin");
	
%>
<%
	//cart테이블에 추가하기 위한 id가 필요
	//session에서 id만 가져오기로
	HashMap<String, Object> login = (HashMap<String, Object>)(session.getAttribute("CustomerLogin")); 
		String id = (String)(login.get("id"));
		//넘어온건지 확인 =>아이디 넘어오는거 확인완료!!ㅎㅎ
		System.out.println("여기는 Action쪽에서 id확인하는 " + id);
	
	
		
	//넘겨받을 데이터: amount, goodsNo,goodsTitle filename, goodsTitle, goodsPrice 
	int amount = Integer.parseInt(request.getParameter("amount"));
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	String filename = request.getParameter("filename");
	String goodsTitle = request.getParameter("goodsTitle");
	int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
	
	//디버깅
	System.out.println("customerGoodsACtion.amount=>"+amount);
	System.out.println("customerGoodsACtion.goodsNo=>" + goodsNo);
	System.out.println("customerGoodsACtion.filename=>" + filename);
	System.out.println("customerGoodsACtion.goodsTitle=>" + goodsTitle);
	System.out.println("customerGoodsACtion.goodsPrice=>" + goodsPrice);
	//디버깅 다 들어온거 확인 완료!!^_^!!
	
	int row = OrderGoodsDAO.addCart(id, goodsTitle, goodsNo, goodsPrice, filename, amount);
	System.out.println(row+"<===row값임");//1 들어오는거 확인
	
	if(row == 1){
		System.out.println("추가완료");
			response.sendRedirect("./orderListByCustomer.jsp?goodsNo="+goodsNo);
	}else{
		System.out.println("추가실패");
		response.sendRedirect("./customerGoodsOne.jsp?goodsNo="+goodsNo);
	}
	//order테이블에 데이터 들어온거까지 확인완료
	
	
	
%>
<!-- orderListByCustomer.jsp -->
