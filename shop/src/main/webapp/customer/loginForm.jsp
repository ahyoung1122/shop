<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>welcome</h2>
	<form method="post" action="./loginAction.jsp">
			<table>
				<tr>
					<th>ID</th>
					<td><input type="text" name="id"></td>
				</tr>
				<tr>
					<th>PW</th>
					<td><input type="password" name="pw"></td>
				</tr>
			</table>
		<input type="submit" value="로그인">
	</form>
</body>
</html>