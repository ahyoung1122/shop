<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*" %>
<%
	//인증분기
	if(session.getAttribute("CustomerLogin") == null) {
    response.sendRedirect("/shop/customer/customerLoginForm.jsp");
    return;
 }

%>
<%	
	HashMap<String, Object> login = (HashMap<String, Object>)(session.getAttribute("CustomerLogin")); 
	String id = (String)(login.get("id"));
	//넘어온건지 확인 => orderListID확인 완료
	System.out.println("여기는 orderList쪽에서 id확인하는 " + id);
	
	
	//DAO페이지랑 sql연결 시켜주기
	ArrayList<HashMap<String,Object>>orderList = 
		OrderGoodsDAO.orderList1(id);
	
	System.out.println(orderList + "<==orderListByCustomer.orderList");
	//값들어오는거 확인완료!!
		
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	img 
	{
		width : 100px;
		height: 100px;
	}
</style>
</head>
<body>
	<form method="post" action="./orderGoods.jsp">
		<h1>CART</h1>
			<table border="1">
				<tr>
					<td></td>
					<td>상품명</td>
					<td>가격</td>
					<td>수량</td>
				</tr>
					<%
						for(HashMap<String,Object>order : orderList ){
					%>
					<tr>
						<td><img src="/shop/upload/<%= order.get("filename")%>"></td>
						<td><%=order.get("goodsTitle")%></td>
						<td><%=order.get("goodsPrice") %></td>
						<td><%=order.get("amount") %></td>
					</tr>
					
					<%
						}
					%>
			</table>
			<button type="submit"> 구매 </button>
	</form>
</body>
</html>