<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*" %>
<%	//로그인 인증 분기
    if(session.getAttribute("loginCustomer") != null) {
    	   response.sendRedirect("/shop/customer/customerLoginAction.jsp");
    	   return;
    	}
%>
<%
//카테고리 목록sql만들기
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	conn = DriverManager.getConnection(
	"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String categorySql = "select goods_no goodsNo, category, count(*) cnt from goods group by category order by category desc";
	stmt = conn.prepareStatement(categorySql);
	rs = stmt.executeQuery();
	ArrayList<HashMap<String, Object>> categoryList = 
	new ArrayList<HashMap<String, Object>>();
	while(rs.next()){//우선 goodsNo, category만 나열
		HashMap<String, Object> m = new HashMap<String, Object>();
		m.put("goodsNo", rs.getInt("goodsNo"));
		m.put("category", rs.getString("category"));
		m.put("cnt", rs.getInt("cnt"));
		categoryList.add(m);	
	}
	System.out.println(categoryList+"=categoryList");

%>
<%
//category=? query만들기
//선택 상품을 나열하는 것
/* SELECT category, goods_no, goods_title, filename, 
goods_price, create_date from goods 
WHERE category=? ORDER BY create_date desc*/

		String category = request.getParameter("category");
		
		PreparedStatement stmt2 = null;
		ResultSet rs2 = null;
		
		String categorySql2 = "SELECT category,goods_no goodsNo, goods_title goodsTitle, filename, goods_price goodsPrice, create_date createDate FROM goods WHERE category=? order by create_date desc";
		stmt2 = conn.prepareStatement(categorySql2);
		stmt2.setString(1, category);
		rs2 = stmt2.executeQuery();
		
		ArrayList<HashMap<String, Object>> goodsList = new ArrayList<HashMap<String, Object>>();
		while(rs2.next()){
			HashMap<String, Object> m2 = new HashMap<String, Object>();
			m2.put("category", rs2.getString("category"));
			m2.put("goodsNo", rs2.getInt("goodsNo"));
			m2.put("goodsTitle", rs2.getString("goodsTitle"));
			m2.put("filename", rs2.getString("filename"));
			m2.put("goodsPrice", rs2.getString("goodsPrice"));
			m2.put("createDate", rs2.getString("createDate"));
			
			goodsList.add(m2);
			
		}
	//디버깅
	System.out.println(goodsList+"=goodsList");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<style>
	*{
	font-family: "CookieRun";
	margin: 0px; padding :0px;
	}
	a{
	text-decoration: none;
	color : black;
	}
.header {
		height: 70px;
		background-color: #FF3636;
		display : flex;
		
		}
.header img{
height : 70px;
width: 150px;
}
.box {
width: 1350px;
margin : 0 auto;
overflow : hidden;
padding-top: 10px;
background-color: white;
}
.box .goodsimage1 {
float : left;
margin-left : 100px;
margin-bottom : 30px;
padding-bottom : 20px;
margin-right: ; /* 적절한 오른쪽 여백 추가 */
width: 300px; /* 적절한 너비 설정 */
text-align : center;
background-color: white;
}
.box .goodsimage1 img{
width : 200px;
height : 200px;
}
</style>
</head>
<body>
<div class="header">
	<img src="./img/marioUnder.png">
	<div><a href="/shop/customer/customerLogout.jsp">로그아웃</a></div>
</div><!-- header의마지막 -->
<div class="main">
	<div class="goodsList"><!-- list목록 나열 -->
		<span>LIST</span><br>
			<!-- 전체데이터를 나열해줄 수 있는 sql하나 더 만들기 -->
			<a href="">전체</a>
			<%
			//forHashMap으로 카테고리들을 나열시키기
				for(HashMap<String, Object>m : categoryList){
			%>		
				<!--1. category를 m.get으로 가져오기 -->
				<!--2. a태그로 주소만들어주기 -->
				<a href="/shop/customer/customerGoodsList.jsp?goodsNo=<%=(Integer)(m.get("goodsNo"))%>&category=<%=(String)(m.get("category"))%>">
					<%=(String)m.get("category") %>
				</a>
			<%
				}
			%>
	</div>
	<div class="box">
		<!-- category=?일때의 나열 sql먼저 작성하고 오자-->
			<%
			for(HashMap<String, Object> m2 : goodsList){
			%>
			<div class="goodsimage1" style ="border: 1px;">
				<div>
					<img src="/shop/upload/<%=(String)m2.get("filename")%>">
				</div>
				<div> 카테고리 : <%=(String)(m2.get("category"))%></div>
				<div>no : <%=(Integer)(m2.get("goodsNo")) %></div>
				<hr>
				<div>이름 : <%=(String)(m2.get("goodsTitle"))%></div>
			
			</div>
			<%
			}
			%>
	</div>


</div><!-- main끝 -->
</body>
</html>