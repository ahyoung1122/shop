<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<!-- Controller Layer -->
<%
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>

<!-- Model Layer -->
<%
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String sql1 = "select category from category";
	stmt1 = conn.prepareStatement(sql1);
	rs1 = stmt1.executeQuery();
	ArrayList<String> categoryList =
			new ArrayList<String>();
	while(rs1.next()) {
		categoryList.add(rs1.getString("category"));
	}
	// 디버깅
	System.out.println(categoryList);
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>addGoodsForm</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	 <style>
   			*{
   			font-family: "CookieRun"
   			}
   			.header {
			    display: flex; 
			    align-items: center; /* 수직으로 가운데 */
			    justify-content: center; /* 수평으로 가운데 */
			    height: 70px; 
			    background-color: #FF3636;
			}
   			.header a {
			    text-decoration: none;
			    color : white;
			    font-size: 20px;
			  margin-right: 50px;
			}
			.header .hello{
			
			}
			.header img {
			    margin-right: 50px; /* 이미지 오른쪽 여백을 설정하여 링크와 간격을 설정했음. */
			    width: 145px; height: auto;
			    display: block; margin-right: auto; margin-left: 0;
			}
			body{
			text-align: center;
			}
			.container {
			border: 1px
			}
			.box{
			 	display: flex;
			 	text-align: center;
			 	justify-content: center;
			}
		</style>
</head>
<body>
<div class="header">
<img src="./img/marioUnder.png">
<!-- empMenu.jsp include : 주체는 서버! vs redirect(주체는 클라이언트!) -->
<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include> <!-- include서버 적을때 조심!! shop부터 시작하지말자! -->
<!-- 매번 페이지 만들때마다 이 코드 작성해줘서 메뉴창을 위에 띄워두자!^_^-->
<div><a href="/shop/emp/empLogout.jsp">로그아웃</a></div>
</div><!-- header의마지막 -->
	<!-- 페이지 -->
	<div class="main">
		<div class="row">
			<div class="col-2"></div>
			<div class="mt-5 col-8 bg-black border shadow p-3 mb-5 bg-body-tertiary rounded" >
			<h1>상품등록</h1>
				<form method="post" action="/shop/emp/addGoodsAction.jsp"
						enctype = "multipart/form-data">
						<div>
							category :
							<select name="category">
								<option value="">선택</option>
								<%
									for(String c : categoryList) {
								%>
										<option value="<%=c%>"><%=c%></option>
								<%		
									}
								%>
							</select>
						</div>
						<!-- emp_id값은 action쪽에서 세션변수에서 바인딩 -->
						<div>  
							goodsTitle :
							<input type="text" name="goodsTitle">
						</div>
						<div>
							goodsImage : 
							<input type = "file" name = "goodsImg">
						</div>
						<div>
							goodsPrice :
							<input type="number" name="goodsPrice">
						</div>
						<div>
							goodsAmount :
							<input type="number" name="goodsAmount">
						</div>
						<div>
							goodsContent :
							<textarea rows="5" cols="50" name="goodsContent"></textarea>
						</div>
						<div>
							<button type="submit">상품등록</button>
						</div>
				</form>

			</div><!-- col-8마지막 -->
		<div class="col-2"></div>
	</div><!-- row -->
</div><!-- container -->
</body>
</html>
