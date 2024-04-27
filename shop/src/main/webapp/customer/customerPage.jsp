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


	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container">
		<h1>MY PAGE</h1>
			<div class="my">
				<table border="1">
					<tr>
						<th>성함</th>
						<th>mail</th>
						<th>성별</th>
						<th>생일</th>
					</tr>
					<tr>
						<td><%=customerInfo.get("name") %></td>
						<td><%=customerInfo.get("mail") %></td>
						<td><%=customerInfo.get("gender") %></td>
						<td><%=customerInfo.get("birth") %></td>
					</tr>
				</table>
				<form method = "post" action="./pwHistory.jsp">
					<label>아이디 : </label>
						<input 
							type = "text"
							name = "id"
							value = "<%=id%>"><br>
					<lable>비밀번호</lable>
						<input
							 type="password" 
							 name="pw"
							 value="<%=pw%>">
					<button>비밀번호 변경</button>
						<!-- 비밀번호 변경 완료했을때 뜨는 알림 -->
						<div style="font-size: 11px; color : gray;">
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
						
					</form>
			</div>
			<!-- 여기서부터는 고객 주문정보 -->
			<div>
				<table border="1">
				<p>주문배송조회</p>
					<tr>
						<td colspan="4">
							상품정보
						</td>
						<td>
							진행상태
						</td>
					</tr>
					<tr>
						<td colspan="5">
							주문번호 : 
							주문일자 : 
						</td>
					</tr>
					
					<tr>
						<th>상품그림</th>
						<th>상품명</th>
						<th>가격</th>
						<th>수량</th>
						<th>state</th>
					</tr>
				</table>
			</div>
			
		
	</div>
</body>
</html>