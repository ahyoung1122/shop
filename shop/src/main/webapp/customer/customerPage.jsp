<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="shop.dao.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*" %>
<%
//로그인 인증분기

if(session.getAttribute("CustomerLogin") == null) {
    response.sendRedirect("/shop/customer/customerLoginForm.jsp");
    return;
 }

%>
<%
	//login session에서 id값,pw값 가져오기
	HashMap<String, Object> login = (HashMap<String, Object>)(session.getAttribute("CustomerLogin")); 
		String id = (String)(login.get("id"));
		String pw = (String)(login.get("pw"));
		//넘어온건지 확인 => orderListID확인 완료
			System.out.println("여기는 customerPage에서 확인하는 " + id);
			System.out.println("여기는 customerPage에서 확인하는 " + pw);
	//customer 개인정보 가져오기
	HashMap<String,Object>customerInfo
		= CustomerDAO.customerPage(id);
	//값 들어가는지 확인 ->확인완료!~
	System.out.println(customerInfo + "<==customerPage.jsp");
	//비밀번호 변경완료 메세지
	String msg = (String) session.getAttribute("msg");
		System.out.println(msg + "<이게 알림메세지");
		
	//주문확인을 위해 ordersTable이랑 연결
	
	ArrayList<HashMap<String,Object>>orderList
		=	OrderGoodsDAO.ordersList1(id);
		//디버깅
		System.out.println(orderList + "<==customerPage.orderList");


	
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
	width: 50px;
	height: 50px;
	}
	.container{
	margin-top : 15px;
	text-align: center;
	font-family:"CookieRun";
	}
	.my table{
	margin: auto;
	border-collapse: separate; /* 셀 간격을 지정하기 위해 border-collapse 속성을 separate로 설정 */
    border-spacing: 15px;
	}
	.allTd{
	 font-size: 25px; 
	 color : #EDA900;
	 -webkit-text-stroke-width: 1px; /* 테두리 두께 */
 	 -webkit-text-stroke-color: black; /* 테두리 색상 */
	}
	.myPage{
	 color : ivory;
	 -webkit-text-stroke-width: 2px; /* 테두리 두께 */
 	 -webkit-text-stroke-color: black;
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
</div><br>
<div class="container">
		<h1 class ="myPage">MY PAGE</h1><br>
			<form method = "post" action="./pwHistory.jsp">
					
					아이디 : <input 
							type = "text"
							name = "id"
							value = "<%=id%>"><br><br>
					
					비밀번호 : <input
							 type="password" 
							 name="pw"
							 value="<%=pw%>">
					<button class="btn btn-secondary btn-sm">비밀번호 변경</button>
						<!-- 비밀번호 변경 완료했을때 뜨는 알림 -->
						<div style="font-size: 14px; color : balck;">
							<%
								if(msg == null){
							%>
							<%		
								}else{
							%>
									<p><%=msg %></p>
							<%
								}
							%>
						</div>
				</form><br>
			<div class="my">
				<table border="1">
					<tr class="allTd">
						<td><strong>NAME</strong></td>
						<td><strong>mail</strong></td>
						<td><strong>GENDER</strong></td>
						<td><strong>BIRTH</strong></td>
						<td><strong>MyOrder</strong></td>
					</tr>
					<tr>
						<td><%=customerInfo.get("name") %></td>
						<td><%=customerInfo.get("mail") %></td>
						<td><%=customerInfo.get("gender") %></td>
						<td><%=customerInfo.get("birth") %></td>
						<td>
							<a class="btn btn-warning" href="./myComment.jsp" role="button">
								내 후기
							</a>
						</td>
					</tr>
				</table>
			</div>
			<!-- 여기서부터는 고객 주문정보 -->
			<div class="my">	<hr>		
				<h4>주문배송조회</h4>
					<%
						for(HashMap<String,Object>m : orderList ){
					%>
					
									주문번호 : <%=m.get("ordersNo") %>
									주문일자 : <%=m.get("createDate") %>
								
						<table border="1">
								<th colspan="4">
									상품정보
								</th>
								<th>
									진행상태
								</th>
							</tr>	
							<tr>
								<td>
									<img src="/shop/upload/<%=m.get("filename")%>">
								</td>
								<td>
									<%=m.get("goodsTitle")%>
								</td>
								<td>
									<%=m.get("goodsPrice")%>원
									<%=m.get("amount")%>개
								</td>
								<td>총 <%=m.get("totalPrice")%>원</th>
								<td style="color:orange;"><%=m.get("state")%></th>
							</tr>
						</table>
					<%
						}
					%>
			</div>
	</div>
<div class="bottom" style="height: 50px; color : gray">

</div>
</body>
</html>