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
	System.out.println("여기는 orderGoods에서 확인하는 " + id);
	String filename = request.getParameter("filename");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		<div class="container">
		<h1>주문내역 작성</h1>
			<form method="post" action="orderGoodsAction.jsp">
				<label for="id">id : </label>
					<input type="text" id = "id" name="id" value="<%=id %>"><br>
				<label for="name">성함 : </label>
					<input type="text" id="name" name="name"><br>
				<lable for="phone">연락처 : </lable>
					<input type="number" maxLength={13} placeholder="010-XXXX-XXXX"><br>
				<label for="address">주소 : </label>
					<input type="text" id="address" name="address"><br>
				<label for="goods">상품 : </label>
					<%=filename %>
				
			
				<br><button type="submit">주문완료</button>
			</form>
	
	</div>
</body>
</html>