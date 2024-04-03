<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import = "java.net.*" %>
    <!-- Controller Layer -->
    <%
   //0. 로그인 인증 분기 : 세션변수 이름 - loginEmp
/*    String loginEmp = (String)(session.getAttribute("loginEmp"));
   System.out.println(loginEmp + "<<==loginEmp"); */
   //  loginForm페이지는 로그아웃상태에서만 출력되는 페이지
   if(session.getAttribute("loginEmp") == null) {
      response.sendRedirect("/shop/emp/empLoginForm.jsp");
      return;
   }
%>
<%
//요청분기

	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	String category = request.getParameter("category");
	/* 
	null 이면
	SELECT * FROM goods
	null이 아니면 
	SELECT * FROM goods where category=?
	*/

%>
<!-- Model Layer -->
<%
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;
		conn = DriverManager.getConnection(
				"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
		
		String sql1 = "select category, count(*) cnt from goods group by category order by category asc";
		stmt1 = conn.prepareStatement(sql1);
		rs1 = stmt1.executeQuery();
		ArrayList<HashMap<String, Object>> categoryList =
				new ArrayList<HashMap<String, Object>>();
		while(rs1.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("category", rs1.getString("category"));
			m.put("cnt", rs1.getInt("cnt"));
			categoryList.add(m);
		}
		// 디버깅
		System.out.println(categoryList);
%>
<%	
//선택 상품 나열 하려면
/* SELECT category, goods_title goodsTitle 
	From goods WHERE category=? */
		PreparedStatement stmt2 = null;
		ResultSet rs2 = null;
		
		String sql2 = "SELECT category, goods_title goodsTitle, goods_price goodsPrice FROM goods WHERE category=? order by goods_price asc;";
		stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1, category);
		rs2 = stmt2.executeQuery();
		
		ArrayList<HashMap<String, Object>> goodsList = new ArrayList<HashMap<String, Object>>();
		//카테고리랑, 굿즈 타이틀,가격(쇼핑몰처럼 나열)
		while(rs2.next()) {
			HashMap<String, Object> m2 = new HashMap<String, Object>();
			m2.put("category", rs2.getString("category"));
			m2.put("goodsTitle", rs2.getString("goodsTitle"));
			m2.put("goodsPrice", rs2.getInt("goodsPrice"));
			goodsList.add(m2);
		}
		
		//확인하기
		System.out.println(goodsList);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>goodsList</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	 <style>
   			*{
   			font-family: "CookieRun"
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
<!-- 맨위 메인메뉴 -->
<div>
	<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
</div>

<div>
	<a href="/shop/emp/addGoodsForm.jsp">상품등록</a>
</div>
	<!-- 페이지 -->
	<div class="container">
		<div class="row">
			<div class="col-2"></div>
			<div class="mt-5 col-8 bg-black border shadow p-3 mb-5 bg-body-tertiary rounded" >
			<div>
			<!-- 서브메뉴 카테고리별 상품리스트 -->
				<a href="/shop/emp/goodsList.jsp">전체</a>
				<%
					for(HashMap m : categoryList){
				%>
					<a href="/shop/emp/goodsList.jsp?category=<%=(String)(m.get("category"))%>">
						<%=(String)(m.get("category")) %>
						<%=(Integer)(m.get("cnt")) %>
					</a>
				<%
					}
				%>
			</div>
			<div>상품리스트</div><!-- 상품 나열하는 부분 -->
				<div class ="box">
					<table border ="1">
						 <tr>
							<th>Category</th>
							<th>goodsTitle</th>
							<th>goodsPrice</th>
						</tr>
						<%
							for(HashMap m2 : goodsList){
						%>
						<tr>
							<td>
								<div></div>
								<%=(String)(m2.get("category")) %>
							</td>
							<td>
								<%=(String)(m2.get("goodsTitle"))%>
							</td>
							<td>
								<%=(Integer)(m2.get("goodsPrice")) %>
							</td>
							
						</tr>
						<%		
								}
						%>
					</div>
				</table>
			</div><!-- col-8마지막 -->
		<div class="col-2"></div>
	</div><!-- row -->
</div><!-- container -->
</body>
</html>