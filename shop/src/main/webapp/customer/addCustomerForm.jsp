<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="shop.dao.*" %>

<%
		Connection conn = DBHelper.getConnection();

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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<title>addCustomerForm</title>
<Style>
	*{
   	font-family: "CookieRun" 
   	}
   	a{
   	text-decoration: none;
   	color : white;
   	background-color : green;
   	}
	body{
	text-align: center;
	}
	.box{
 	display: flex;
 	text-align: center;
 	justify-content: center;
	}
	.join{
	font-size :	40px;
	color:red;
	font-family:"Super Mario 256";
	-webkit-text-stroke-width: 4px; /* 테두리 두께 */
    -webkit-text-stroke-color: black; /* 테두리 색상 */
	}
	button{
	border: ; /* 테두리 없음 */
    background-color: transparent; /* 배경색 없음 */
	}
	.img{
    display: flex;
    align-items: center; /* 수직 중앙 정렬 */
    justify-content: center; /* 수평 중앙 정렬 */
 	height: 100px; width: 222px;
   	background-image: url(./img/pinokio2.png);
	background-size: cover; /* 이미지를 화면에 꽉 차도록 조정합니다. */
	margin: auto; /* 가운데 정렬을 위한 추가 */
	}
</Style>
</head>
<body>
<div class="container">
	<div class="row">
		<div class="col-2"></div>
			<div class="mt-5 col-8 bg-black border shadow p-3 mb-5 bg-body-tertiary rounded">
				<div style="text-align: left;"><a href="./customerLoginForm.jsp">login Page돌아가기</a></div>
					<div class="img"></div>
					<h3 class="join">JOIN</h3><hr>
	
					<!-- id확인 form -->
					<form method="post" action="./checkIdAction.jsp">
						<div>
							ID확인
							<input type="text" name="id" value=<%=id%>>
						<button type="submit">중복확인</button>
						</div>
					</form><hr>
					<!-- 확인form종료 -->
				<form method="post" action="/shop/customer/addCustomerAction.jsp">
					<div class="box">
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
												<%=msg %>
							</td>
								</tr>
					
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
					</div><!-- box끝 --><br>
					<button type="submit">제출</button>
				</form>
			</div><!-- col-8마지막 -->
		<div class="col-2"></div>
	</div>
</div><!-- container -->
</body>
</html>