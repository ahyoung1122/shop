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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<style>
	img 
	{
		width : 100px;
		height: 100px;
	}
	.header{
		text-align : center;
		background-color: #FF2424;
	}
	.header a{
		font-size: 26px;
		font-family:"Super Mario 256";
		-webkit-text-stroke-width: 2px; /* 테두리 두께 */
 		-webkit-text-stroke-color: black; /* 테두리 색상 */
	}
	a{
		text-decoration: none;
		margin-right: 15px;
		color : gray;
	}
	a:hover{
		color : black;
	}
	.include{
		font-family:"CookieRun";
		float: right;
		margin-right: 30px;
	}
	.container{
	margin-top : 15px;
	text-align: center;
	font-family:"CookieRun";
	}
	table{
	margin: auto;
	border-collapse: separate; /* 셀 간격을 지정하기 위해 border-collapse 속성을 separate로 설정 */
    border-spacing: 15px;
	}
</style>
</head>
<body>
<div class="header">
		<a href="./customerMainPage.jsp">
			<span style="color :#E52521;">S</span><span style="color:#049CD8">U</span><span style="color:#FBD000">P</span><span style="color:#049CD8">E</span><span style="color : #43B047">R</span>
			<br>
			<span style="color:#049CD8">M</span><span style="color : #43B047">A</span><span style="color:#FBD000">R</span><span style="color :#E52521;">I</span><span style="color : #43B047">O</span>
		</a>
</div>
<div class="include">
	<jsp:include page="/customer/inc/customerMenu.jsp"></jsp:include> 
</div>
<a href="./customerGoodsList.jsp">상품추가하러가기</a>
<div class="container">
	<form method="post" action="./orderGoods.jsp">
			<h1>CART</h1>
				<table>
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
				<button type="submit" class="btn btn-secondary btn-sm"> 구매 </button>
				
				<%
					for (HashMap<String, Object> order : cartList) {
					    int cartNo = (int) order.get("cartNo");
					    // ordersNo를 사용하여 원하는 작업 수행
					    System.out.println("주문 번호: " + cartNo);}
				%>
	</form>
</div>
<div class="bottom" style="height: 50px; color : gray">

</div>
</body>
</html>