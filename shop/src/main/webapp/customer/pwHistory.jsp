<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "shop.dao.*" %>
<%@ page import="java.util.*" %>
<%	//로그인 인증 분기
	System.out.println(session.getAttribute("CustomerLogin")+"<==CustomerLogin");
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
		System.out.println("여기는 pwHistory에서 확인하는 " + id);
		System.out.println("여기는 pwHistory에서 확인하는 " + pw);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	현재 비밀번호 : 
		<input type="password" name="pw" value="<%=pw%>">
	<form method="post" action="pwHistoryAction.jsp">
		비밀번호를 변경하시겠어요??
		<input type="password" name="newPw">
			<button type="submit">변경</button>
	</form>

</body>
</html>