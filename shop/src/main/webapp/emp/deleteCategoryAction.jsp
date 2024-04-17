<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import = "shop.dao.*" %>

 <%
 
 //인증분기
   if(session.getAttribute("loginEmp") == null) {
      response.sendRedirect("/shop/emp/empLoginForm.jsp");
      return;
   }
 %>
 <%
 //db랑 연결
 	String goodsNo1 = request.getParameter("goodsNo");
 	int goodsNo = Integer.parseInt(goodsNo1);
 	System.out.println("goodsNo="+goodsNo);
 	
 	int row = GoodsDAO.deleteCategoryGoods(goodsNo);

	if(row == 0){
		System.out.println("goods삭제성공");
		response.sendRedirect("./goodsList.jsp?goodsNo=?&category=?&totalRow=?");
	}else{
		System.out.println("goods삭제실패");
		response.sendRedirect("./goodsList.jsp");
	}
 
 %>
