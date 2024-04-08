<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
//address중복을 확인하는 쿼리 작성

		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;
		conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/diary", "root", "java1234");
		
		String id = request.getParameter("id"); //mail값 가져오기
		if(id == null){//갔다가 돌아오면 null값이 아니겠지? 
			id = " ";
			
		}
		
		String idCheck = request.getParameter("idCheck");
		
		//System.out.println(ck);
		
		if(idCheck == null){
			idCheck= "";
		}
		
		String msg =" ";
		if(idCheck.equals("T")){
			msg = "사용가능한 ID입니다";
		}else if(idCheck.equals("F")){
			msg = "이미 존재합니다 다른ID를 입력하세요";
		}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addCustomerForm</title>
</head>
<body>
	<h1>회원가입</h1>
	<!-- id확인 form -->
	<form method="post" action="./checkIdAction.jsp">
		<div>
			ID확인
			<input type="text" name="id" value=<%=id%>>
		</div>
		<button type="submit">중복확인</button>
	</form>
	<!-- 확인form종료 -->
	<form method="post" action="/shop/customer/addCustomerAction.jsp">
		<table>
				<tr>
					<td><label for="id">ID</label></td>
					<td>
					<%
						if(idCheck.equals("T")){
							%>
								<input value="<%=id%>" type="text" name="id" readonly="readonly">
							<%			
									}else{
								%>
										<input value=" " type="text" name ="id" readonly="readonly">
								<%		
									}
								%>
			</td>
				</tr>
			</form>
				<tr>
					<td><label for="password">pw</label></td>
					<td><input type="password" name="pw" id="password"></td>
				</tr>
				<tr>
					<td><label for="mail">mail</label></td>
					<td><input type="text" name="mail" id="mail"></td>
				</tr>
				<tr>
					<td><label for="name">이름</label></td>
					<td><input type="text" name="name" id="name"></td>
				</tr>
				<tr>
					<td><label for="birth">생년월일</label></td>
					<td><input type="date" name="birth" id="birth"></td>
				</tr>
				<tr>
					<td><label for="gender">성별</label></td>
					<td>
						<select id = "gender" name="gender">
							<option value="F">여성</option>
							<option value="M">남성</option>
						</select>
					</td>
				</tr>
		</table>
	<button type="submit">회원가입 완료</button>
	</form>
</body>
</html>