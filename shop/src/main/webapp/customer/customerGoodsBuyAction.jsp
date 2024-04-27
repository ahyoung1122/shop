<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*" %>
<%
//로그인인증
if(session.getAttribute("CustomerLogin") == null) 
	{    
	    response.sendRedirect("/shop/customer/customerLoginForm.jsp");
	    return;
 	}
	//로그인값 잘 넘어오는지 확인
	System.out.println(session.getAttribute("CustomerLogin")+"<==CustomerLogin");
%>
<%
	//orders테이블에 추가하기 위한 id가 필요
	//session에서 id만 가져오기로
	HashMap<String, Object> login = (HashMap<String, Object>)(session.getAttribute("CustomerLogin")); 
		String id = (String)(login.get("id"));
		//넘어온건지 확인 =>확인완료!
		System.out.println("여기는 buyAction쪽에서 id확인하는 " + id);
	
	//goodsOne 페이지에서 form태그 안에 있는 값들 가져오기
	//넘겨받을 데이터: amount, goodsNo,goodsTitle filename, goodsTitle, goodsPrice 
	int amount = Integer.parseInt(request.getParameter("amount"));
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	String filename = request.getParameter("filename");
	String goodsTitle = request.getParameter("goodsTitle");
	int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
	
	int totalPrice = amount * goodsPrice;
	//디버깅
	System.out.println("customerGoodsBuyAction.amount=>"+amount);
	System.out.println("customerGoodsBuyAction.goodsNo=>" + goodsNo);
	System.out.println("customerGoodsBuyAction.filename=>" + filename);
	System.out.println("customerGoodsBuyAction.goodsTitle=>" + goodsTitle);
	System.out.println("customerGoodsBuyAction.goodsPrice=>" + goodsPrice);
	//값 들어오는거 확인완료
	
		//orderGoodsDAO에서 orders테이블에 추가하는 쿼리 작성
		//연결하기
		int row = OrderGoodsDAO.addOrders(
				id, goodsTitle, goodsNo, goodsPrice, filename, amount, totalPrice);
			//디버깅
			System.out.println(row + "<==customerGoodsBuyAction.order");
			//1들어오는거 확인완료!	
		if(row == 1)
			{
				System.out.println("상품추가완료");
				response.sendRedirect("./orderGoods.jsp?goodsNo="+goodsNo);
					
		    
			}else
				{
					System.out.println("상품이 추가되지 않았습니다.");
					response.sendRedirect("./orderGoodsOne.jsp?goodsNo="+goodsNo);
				}
		
%>