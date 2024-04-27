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
	ArrayList<HashMap<String,Object>>cartList = 
		OrderGoodsDAO.cartList1(id);

	
	
	System.out.println(cartList + "<==orderListByCustomer.orderList");
	//값들어오는거 확인완료!!
	
	//상품들의 총 가격을 구하려면
	int totalPrice = 0;
    for (HashMap<String, Object> order : cartList) {
        // 각 행의 수량을 가져와서 총 가격에 더함
        int amount = (int) order.get("amount");
        int price = (int) order.get("goodsPrice");
        int goodsPerPrice = amount * price; 
        //상품 하나당 가격계산
        totalPrice = totalPrice + goodsPerPrice;
        //각각 가격을 다 더해주기
    }
	//가격 잘 나오는지 확인	 =>확인완료!!
	System.out.println(totalPrice + "<==orderListCustomer.totalPrice");
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
<div>
	<a href="./customerGoodsList.jsp">상품추가하러가기</a>
</div>
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
							for(HashMap<String,Object>order : cartList ){
						%>
						<tr>
							<td><img src="/shop/upload/<%= order.get("filename")%>"></td>
							<td>
								<%=order.get("goodsTitle")%>
								<!-- hidden으로 goods_no보내주자(총수량 변경때문에 필요함) --><%=(int)order.get("goodsNo")%>
								<input type="hidden" name="goodsNo" value="<%=(int)order.get("goodsNo")%>">
							</td>
							<td><%=order.get("goodsPrice") %></td>
							<td><%=order.get("amount") %></td>
						</tr>
						
						<%
							}
						%>	
						<tr>
							<td colspan="4"> 총 가격 : <%= totalPrice %>원</td>
						</tr>
				</table><br>
					<!-- totalPrice를 넘겨줘야해서 hidden으로 추가  -->
					<input type="hidden" name="totalPrice" value="<%= totalPrice %>">
				<button type="submit"> 구매 </button>
	</form>
</body>
</html>