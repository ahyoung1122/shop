<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.*"%>

<%
	HashMap<String,Object> loginMember 
		= (HashMap<String,Object>)(session.getAttribute("loginEmp"));
	
%>
<div>
	<a href="/shop/emp/empList.jsp">사원관리</a>
	<!-- category CRUD -->
	<a href="/shop/emp/categoryList.jsp">카테고리관리</a>
	<a href="/shop/emp/goodsList.jsp">상품관리</a><!-- empList에 갖다 붙일거임 include기술! -->
	<span class = "hello">
		<!-- 개인정보 수정을 할 수 있다. -->
		<a href="/shop/emp/empOne.jsp" style="color : white;"><!-- 세션에 있는 id를 통해서 개인정보를 입력,수정 -->
			<%=(String)(loginMember.get("empName"))%>님 welcome
		</a> 
	</span>
</div>