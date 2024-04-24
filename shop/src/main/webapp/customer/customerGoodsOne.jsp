<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="shop.dao.*" %>
<%
    //인증분기 
    	//여기서 이해가 안가면 customerLoginAction쪽으로 가서 확인해봐라
    	if(session.getAttribute("CustomerLogin") == null) {
    	   response.sendRedirect("/shop/customer/customerLoginForm.jsp");
    	   return;
    	}
%>
<%
		int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
		///goodsList에서 goodsNo를 가져옴
			
		HashMap<String,Object>goodsList = CustomerGoodsDAO.goodsOne(goodsNo);
		//해쉬맵으로 받아서
		//여기서 하나씩 뽑아주기
		
		// 필요한 모든 값을 가져오기 + 디버깅까지 해서 값들어오는지 확인
		String filename = (String)goodsList.get("filename");
			System.out.println(filename+"<===filename");
		
		String goodsTitle = (String)goodsList.get("goodsTitle");
			System.out.println(goodsTitle+"<===goods_title");
		
		int goodsPrice = (int)goodsList.get("goodsPrice");
			System.out.println(goodsPrice+"<===goods_price");
		
		String goodsContent = (String)goodsList.get("goodsContent");
			System.out.println(goodsContent+"<===goodsContent");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<style>
	*{
		font-family: "CookieRun";
		margin: 0px; padding :0px;
	}
	a{
		text-decoration: none;
		color : black;
	}
.header {
		height: 70px;
		background-color: #FF3636;
		position: relative;		
		}
.header img{
	height : 70px;
	width: 150px;
}
.header a{
	font-size: 25px;
	color : ivory;
	position: relative;
    right: 30px;
}
.main{
 text-align: center;
}
.goodsImg img
{
	width : 300px;
	height : 300px;
	/* border: 3px solid red; */ /* 테두리 색상을 할건지 말건지는 조금 고민해보고 결정해야겠음. */
}
.goods{
	display: flex;
 	text-align: center;
 	justify-content: center;
}
span{
 font-size: 22px;
 font-weight: 50px;
 margin: 25px;
}
button{
	background-color: green;
	color : ivory;
	padding : 4px;
}
</style>
</head>
<body>
<div class="header">
	<img src="./img/marioUnder.png">
	<a href="/shop/customer/customerLoginForm.jsp">
		LogOut
	</a>
	<jsp:include page="/customer/inc/customerMenu.jsp"></jsp:include> 
</div><!-- header의마지막 -->
<div class="main">
	<div class ="container">
		<div style="height: 60px;"></div><!-- 상품이랑 header부분이랑 좀 띄워야할거같아서 만들었음 -->
		<div class="goodsImg">
			<img src="/shop/upload/<%= filename%>">
		</div>
		<br>
		<div class="goods">	
			<table>
				<tr>
					<td><span> 제목</span></td>
					<td><%=goodsTitle %></td>
				</tr>
				<tr>
					<td><span>가격</span></td>
					<td><%=goodsPrice %></td>
				</tr>
			</table>
		</div>
		<br>
			<div>
				<span>상품소개</span>
			</div>
			<br>
			<div>		
				<%=goodsContent %>
			</div>
		<br>
		<div>
			<!-- 넘길 데이터 : amount, goodsNo, filename, goodsTitle, goodsPrice -->
			<form method="post" action="/shop/customer/customerGoodsAction.jsp?goodsNo=<%=goodsNo%>">
				<input type="number" name = "amount" style="width: 50px"> <br>
				<input type="hidden" name ="goodsNo" value="<%=goodsNo%>">
				<input type="hidden" name ="filename" value="<%=filename%>">
				<input type="hidden" name ="goodsTitle" value="<%=goodsTitle %>">
				<input type="hidden" name ="goodsPrice" value="<%=goodsPrice %>">
				<button type="submit" name="orderList">주문하기</button>
			</form>
		
		</div>
	</div><!-- container의 마지막 -->
</div><!-- main끝 -->
</body>
</html>