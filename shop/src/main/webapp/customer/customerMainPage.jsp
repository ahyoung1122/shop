<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.util.*" %>
<%@ page import = "shop.dao.*" %>
<%	//로그인 인증 분기
	System.out.println(session.getAttribute("CustomerLogin")+"<==CustomerLogin");
    if(session.getAttribute("CustomerLogin") == null) {
    	   response.sendRedirect("/shop/customer/customerLoginForm.jsp");
    	   return;
    	}
%>
<%
//페이징 하기 currentPage, rowPerPage, totalRow, startRow, lastPage
//현재페이지
int currentPage = 1;

if(request.getParameter("currentPage") != null)
	{
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}

int rowPerPage = 6; //한페이지당 9개씩

int totalRow = 0; //전체Row

if(request.getParameter("totalRow") != null)
	{
		totalRow = Integer.parseInt(request.getParameter("totalRow"));
	}

int startRow = (currentPage-1)*rowPerPage; //각 페이지의 첫번째 Row

int lastPage = totalRow % rowPerPage;

if(totalRow % rowPerPage == 0)//혹시 페이지가 안떨어지는 경우를 대비해서 추가하는 코드
	{
		lastPage = lastPage + 1;
	}
//디버깅
System.out.println(totalRow + "==>totalRow");

%>
<%
//전체 page를 위한sql
	ArrayList<HashMap<String,Object>> allGoodsList
		= CustomerGoodsDAO.allGoodsList1(startRow, rowPerPage);

	System.out.println("allGoodsList==>"+allGoodsList);
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HOME</title>
<link rel="stylesheet" href="styles.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<style>
	.header{
		text-align : center;
		background-color: #FF2424;
	}
	.header a{
		font-size: 26px;
		font-family:"Super Mario 256";
		-webkit-text-stroke-width: 2px; /* 테두리 두께 */
 		-webkit-text-stroke-color: black; /* 테두리 색상 */
	}
	a{
		text-decoration: none;
		margin-right: 15px;
		color : gray;
	}
	a:hover{
		color : black;
	}
	.include{
		font-family:"CookieRun";
		float: right;
		margin-right: 30px;
	}
	.mainPoster img{
	height: 350px;
	width: 890px;
	}
	.mainPoster{
	margin-top: 10px;
	display: flex;
	justify-content: center;
	}
	.subPoster{
	display: flex;
	justify-content: center;
	}
	.subPoster img{
	height: 400px;
	width: 250px;
	margin-right: 10px;
	}
	.news
	{
	margin-top: 30px;
	text-align: center;
	font-family:"CookieRun";
	font-size: 25px;
	font-weight: bold;
	}
	.movie{
	margin-top: 10px;
	text-align: center;
	font-family:"CookieRun";
	font-size: 25px;
	font-weight: bold;
	}
	.movie a{
	text-align: center;
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
		<a href="./customerMainPage.jsp">
			<span style="color :#E52521;">S</span><span style="color:#049CD8">U</span><span style="color:#FBD000">P</span><span style="color:#049CD8">E</span><span style="color : #43B047">R</span>
			<br>
			<span style="color:#049CD8">M</span><span style="color : #43B047">A</span><span style="color:#FBD000">R</span><span style="color :#E52521;">I</span><span style="color : #43B047">O</span>
		</a>
		
</div>
<div class="include">
<jsp:include page="/customer/inc/customerMenu.jsp"></jsp:include> 
</div>
	<p class="news">🎮MARIO NEWS🎮</p>
	<div class="mainPoster">
		<img src="./img/mariodon.png" class="poster">
		<img src="./img/10mario.png" class="poster">
		
	</div>

	<p class="movie">⭐MARIO MOVIE⭐</p>
	<div class="subPoster">
		<img src="./img/mario.png">
		<img src="./img/marioposter.png">
		<img src="./img/marioposter2.png">
		<img src="./img/marioposter3.png">
	</div>
	<p class="movie">
		MARIO GOODS<br>
		<a href="./customerGoodsList.jsp">쇼핑하러가기</a>
	</p>
		<div class="box">
			<%
					for(HashMap<String, Object> m3 : allGoodsList){
			%>
				<div class="goodsimage1" style ="border: 1px;">
					<div>
						<a href="./customerGoodsOne.jsp?goodsNo=<%=(Integer)(m3.get("goodsNo"))%>">
							<img src="/shop/upload/<%=(String)m3.get("filename")%>">
						</a>
					</div>
				</div>
			<%
				}
			%>
		</div>
<div class="bottom" style="height: 50px; color : gray">
	made by 임아영 
</div>
</body>
</html>