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
	//총 가격 request하기
	String totalPrice = request.getParameter("totalPrice");
		System.out.println(totalPrice + "<==여기까지는 나옴");
		
	int allPrice = Integer.parseInt(totalPrice);
	//값넘어오는지 확인
	//앞에서 hidden으로 값을 보내주니까 넘어왔음.
		System.out.println(allPrice + "<==orderGoods.allPrice");
	
	//login session에서 id값만 가져오기
	HashMap<String, Object> login = (HashMap<String, Object>)(session.getAttribute("CustomerLogin")); 
	String id = (String)(login.get("id"));
	//넘어온건지 확인 => orderListID확인 완료
		System.out.println("여기는 orderGoods에서 확인하는 " + id);
	
	//customer테이블에서 이름이랑, mail값 가져와서 기본으로 넣어주기
	HashMap<String, String>customerInformation
		=OrderGoodsDAO.customerInfo(id);
	//잘 넘어오는지 확인해보자=>완료
		System.out.println(customerInformation + "<==customerInformation");
	
	//orders테이블에서 어떤상품 구매했는지 보여주기
	ArrayList<HashMap<String,Object>>orderGoodsList
		= OrderGoodsDAO.orderGoods(id);
		//값 들어온지 확인=>완료
		System.out.println(orderGoodsList + "<==orderGoods.orderGoodsList");
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
img 
	{
		width : 50px;
		height: 50px;
	}
</style>
</head>
<body>
		<div class="container">
		<h1>주문내역 작성</h1>
			<form method="post" action="orderGoodsAction.jsp">
				<label for="id">
					id : 
				</label>
					<input type="text" id = "id" name="id" value="<%=id %>"><br>
				<label for="name">
					성함 : 
				</label>
					<input type="text" id="name" name="name" value="<%=customerInformation.get("name")%>"><br>
				<label>
					mail : 
				</label>
					<input type="text" id="mail" name="mail" value="<%=customerInformation.get("mail")%>"><br>
				<lable for="phone">연락처 : </lable>
					<input type="text" maxLength={13} placeholder="010-XXXX-XXXX"><br>
				<label for="address">주소 : </label>
					<input type="text" id="address" name="address"><br>
				<label for="goods">
					상품 : 
				</label><br>
					<%
						for(HashMap<String,Object>order : orderGoodsList){
					%>	
						<td><img src="/shop/upload/<%= order.get("filename")%>"></td>
						<td><%=order.get("goodsTitle")%></td>
						<td><%=order.get("goodsPrice") %>원</td><br>
					<%
						}
					%>
				
				<label>총 가격 : <%=allPrice %>원</label>
				<br><button type="submit">결제하기</button>
			</form>
	
	</div>
</body>
</html>