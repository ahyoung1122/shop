<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import = "java.net.*" %>
<%@ page import="shop.dao.*" %>

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
//페이징하기
	String category = request.getParameter("category");

	int currentPage = 1;//현재 페이지는 1페이지부터
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage =9;//한페이지에 9개씩 보이게 하기
	
	int startRow = (currentPage -1)*rowPerPage; 
	//첫 화면에 몇번째 게시글이 보이게 할건지 설정하는 값(외우지말고이해하자)
	//만약에 currnetPage가 2라면 2-1 = 1 곱하기 10을 해서 10번째 게시글이 2번페이지의 1번이 된다
	int totalRow = 0;//총게시글
	if(request.getParameter("totalRow") != null){
	    totalRow = Integer.parseInt(request.getParameter("totalRow"));
	}
	
	//lastPage를 구하려면... 맨 마지막 페이지니까 총 게시글totalRow에서 rowPerPage를 나눠줘야함
	int lastPage = totalRow % rowPerPage; 
	//근데 만약에 딱 안떨어지고 몇개가 남는 경우가 있을 수도 있어
	if(totalRow % rowPerPage != 0 ){
	    lastPage = lastPage + 1;
	}
	
	
	System.out.println(totalRow+"");
	//연결해주기
	//
	/* 
	null 이면
	SELECT * FROM goods
	null이 아니면 
	SELECT * FROM goods where category=?
	*/
%>
<!-- Model Layer -->
<%		//카테고리 메서드 호출하기
		ArrayList<HashMap<String, Object>> categoryList = GoodsDAO.category();
		System.out.println(categoryList+"=categoryList");

%>
<%	
//선택 상품 나열 하려면
/* SELECT category, goods_title goodsTitle 
	From goods WHERE category=? */
			
		ArrayList<HashMap<String, Object>>goodsList = GoodsDAO.checkGoodsList(category, startRow, rowPerPage);
	System.out.println(categoryList+"=goodsList");

%>
<%
//'전체'버튼을 누르면 모든 카테고리들의 데이터가 보일 수 있게끔 해주는 쿼리 작성해야함
		ArrayList<HashMap<String, Object>>allGoodsList = GoodsDAO.allGoodsList2(startRow, rowPerPage);
		System.out.println(allGoodsList);
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
   			font-family: "CookieRun";
   			margin: 0px; padding :0px;
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
			    width: 145px; height: 70px;
			    display: block; margin-right: auto; margin-left: 0;
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
			.container{
			text-align: center;
			 }
			.btn{
			 display : flex;
			 justify-content: center;
			}
			a{
			text-decoration: none;
			color : black;
			
			}
			.allAtag{
				border: 2px solid #005766;
				background-color : #489FAE;
				color : white;
				text-align : center;
				padding: 2px;
				margin-right: 10px;
			}
			.headList {
			font-family:"Super Mario 256";
			font-size: 30px;
			text-shadow: -2px 0 #000, 0 2px #000, 2px 0 #000, 0 -2px #000;
			color : #FFE400;
			}
			.headList2 {
			font-family:"Super Mario 256";
			font-size: 30px;
			text-shadow: -2px 0 #000, 0 2px #000, 2px 0 #000, 0 -2px #000;
			color : red;
			}
			
			button{
			border: none;
			padding : 5px;
			margin-rigth : 6px;
			display : plex;
			text-align: center;
			}
			
			
			
		</style>
</head>
<body>
<!-- 맨위 메인메뉴 -->
<div class="header">
	<img src="./img/mario&luigi.png">
	<!-- empMenu.jsp include : 주체는 서버! vs redirect(주체는 클라이언트!) -->
	<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include> <!-- include서버 적을때 조심!! shop부터 시작하지말자! -->
	<!-- 매번 페이지 만들때마다 이 코드 작성해줘서 메뉴창을 위에 띄워두자!^_^-->
	<div><a href="/shop/emp/empLogout.jsp">로그아웃</a></div>
</div><!-- header의마지막 -->
	<!-- 페이지 -->
	<div class="main">
		<div class="container">
			<div class="subList">
				<br><span class="headList">GOODS </span><span class="headList2"> LIST</span><br>
			<!-- 서브메뉴 카테고리별 상품리스트 --><!-- 전체 카테고리를 더한 값을 가져와야함 -->
				<a href="/shop/emp/goodsList.jsp?totalRow=<%=totalRow%>" class="allAtag">전체</a>
				<%
					for(HashMap<String, Object> m : categoryList){
				%>
					<a href="/shop/emp/goodsList.jsp?goodsNo=<%=(Integer)(m.get("goodsNo"))%>&category=<%=(String)(m.get("category"))%>&totalRow=<%=(Integer)(m.get("cnt"))%> " class="allAtag">
						<%=(String)(m.get("category")) %>
					<%-- 	<%=(Integer)(m.get("cnt")) %> --%>
					</a>
				<%
					}
				%>
			</div>
			<a href="/shop/emp/addGoodsForm.jsp">추가</a>
		</div>
	<div class="box">
			<%
				if(category == null){ //카테고리값이 null이면 메인페이지로 전체 목록이 다 보이게끔!
					for(HashMap<String, Object> m3 : allGoodsList){
			%>
				<div class="goodsimage1" style ="border: 1px;">
					<div>
						<img src="/shop/upload/<%=(String)m3.get("filename")%>">
					</div>
						<div>카테고리 : <%=(String)(m3.get("category")) %></div>
						<div>no : <%=(Integer)(m3.get("goodsNo")) %></div>
						<div>남은수량 : <%=(Integer)(m3.get("goodsAmount"))%></div><hr>
						<div>이름 : <%=(String)(m3.get("goodsTitle"))%></div>
						<div>가격 : <%=(Integer)(m3.get("goodsPrice")) %></div>
						<div><!-- 삭제버튼 만들기 -->	
							<button style="background-color: green;">
	                        	<a style="color : white;" href="./deleteCategoryAction.jsp?goodsNo=<%=(Integer)(m3.get("goodsNo"))%>&category=<%=(String)(m3.get("category"))%>&totalRow=<%=totalRow%>">삭제</a>
	                        </button>
               		</div>
				</div>
			<%
					}
				}else{
					for(HashMap<String, Object> m2 : goodsList){
			 %>
				<div class="goodsimage1" style ="border: 1px;">
					<div>
						<img src="/shop/upload/<%=(String)m2.get("filename")%>">
					</div>
					<div>카테고리 : <%=(String)(m2.get("category")) %></div>
					<div>no : <%=(Integer)(m2.get("goodsNo")) %></div>
					<div>남은수량 : <%=(Integer)(m2.get("goodsAmount"))%></div><hr>
					<div>이름 : <%=(String)(m2.get("goodsTitle"))%></div>
					<div>가격 : <%=(Integer)(m2.get("goodsPrice")) %></div>
					<div><!-- 삭제버튼 만들기 -->	
						<button style="background-color: green;">
                        	<a style="color : white;" href="./deleteCategoryAction.jsp?goodsNo=<%=(Integer)(m2.get("goodsNo"))%>&category=<%=(String)(m2.get("category"))%>&totalRow=<%=totalRow%>">삭제</a>
                        </button>
               		</div>
				</div>
			<%
					}
				}
			%>
	</div>
		<%
		if(category == null){//전체 페이지를 위한 button
		%>
				<%
					if(currentPage >1)
					{	
				%>
					<button><a href="./goodsList.jsp?currentPage=1&totalRow=<%=totalRow%>">first</a></button>
					<button><a href="./goodsList.jsp?currentPage=<%=currentPage-1%>&totalRow=<%=totalRow%>">pre</a></button>
				<%
					}
				%>
				<%
				if(currentPage<lastPage || currentPage ==1 )
					{
				%>
					<button><a href="./goodsList.jsp?currentPage=<%=currentPage+1%>&totalRow=<%=totalRow%>">next</a></button>
					<button><a href="./goodsList.jsp?currentPage=<%=lastPage%>&totalRow=<%=totalRow%>">last</a></button>
				<%
					}
			%>
		<%
		//맨 처음if구문 끝나는 지점
		}else{//category=?일때의 button을 생성
		%>
			<%
				if(currentPage >1)
				{	
			%>
				<button><a href="./goodsList.jsp?currentPage=1&category=<%=category%>&totalRow=<%=totalRow%>">first</a></button>
				<button><a href="./goodsList.jsp?currentPage=<%=currentPage-1%>&category=<%=category%>&totalRow=<%=totalRow%>">pre</a></button>
			<%
				}
			%>
			<%
			if(currentPage<lastPage || currentPage ==1 )
				{
			%>
				<button><a href="./goodsList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>&totalRow=<%=totalRow%>">next</a></button>
				<button><a href="./goodsList.jsp?currentPage=<%=lastPage%>&category=<%=category%>&totalRow=<%=totalRow%>">last</a></button>
			<%
				}
		}
			%>
	<br><br>
</div><!-- main -->

</body>
</html>