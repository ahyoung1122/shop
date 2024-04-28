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
	img{
	height: 300px;
	width: 200px;
	margin-left: 30px;
	margin-top: 30px;
	}
	.main{
	 text-align: center;
	 font-family: "CookieRun"
	}
	.goodsImg img
	{
		width : 300px;
		height : 300px;
		/* border: 3px solid red; */ /* 테두리 색상을 할건지 말건지는 조금 고민해보고 결정해야겠음. */
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
		<a href="/shop/customer/customerMainPage.jsp">
			<span style="color :#E52521;">S</span><span style="color:#049CD8">U</span><span style="color:#FBD000">P</span><span style="color:#049CD8">E</span><span style="color : #43B047">R</span>
			<br>
			<span style="color:#049CD8">M</span><span style="color : #43B047">A</span><span style="color:#FBD000">R</span><span style="color :#E52521;">I</span><span style="color : #43B047">O</span>
		</a>
</div>
<div class="include">
<jsp:include page="/customer/inc/customerMenu.jsp"></jsp:include> 
</div>s
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
			<!-- 넘길 데이터 : amount, goodsNo, filename, goodsTitle, goodsPrice -->
			<form method="post">
				수량 : <input type="number" name = "amount" value="1" style="width: 50px" min="1">
				<input type="hidden" name ="goodsNo" value="<%=goodsNo%>">
				<input type="hidden" name ="filename" value="<%=filename%>">
				<input type="hidden" name ="goodsTitle" value="<%=goodsTitle %>">
				<input type="hidden" name ="goodsPrice" value="<%=goodsPrice %>">
				<button type="submit" name="orderList" formaction="/shop/customer/customerGoodsCart.jsp?goodsNo=<%=goodsNo%>">🛒</button>
				<button type="submit" name="orderList" formaction="/shop/customer/customerGoodsBuyAction.jsp?goodsNo=<%=goodsNo%>">구매하기</button>
			</form>
		</div>
		<br>
			<div>
				<span>상품소개</span>
			</div>
			<br>
			<div>		
					<%=goodsContent %>
			</div>
	</div><!-- container의 마지막 -->

</div><!-- main끝 -->
<div class="bottom" style="height: 50px; color : gray">

</div>
</body>
</html>