<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

int rowPerPage = 8; //한페이지당 9개씩

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
//카테고리 목록sql만들기

	ArrayList<HashMap<String,Object>>categoryList =
	 CustomerGoodsDAO.categoryList1();
	
	System.out.println("categoryList===>"+categoryList);

%>
<%
//category=? query만들기
//선택 상품을 나열하는 것
	String category = request.getParameter("category");

	ArrayList<HashMap<String,Object>>goodsList =
			CustomerGoodsDAO.goodsList1(category,startRow,rowPerPage);


//디버깅
	System.out.println("goodsList===>" + goodsList);
	
%>
<%
//전체 page를 위한sql
	ArrayList<HashMap<String,Object>> allGoodsList
		= CustomerGoodsDAO.allGoodsList1(startRow, rowPerPage);

	System.out.println("allGoodsList==>"+allGoodsList);
%>
<%
//전체페이지의 totalRow랑last페이지를 구하기 위해 query추가

		int totalRow2 = 0;
		int rowPerPage2 = 8;
		int startRow2 = (currentPage-1)*rowPerPage2;
		
		//customerGoodsDAO.
		totalRow2 = CustomerGoodsDAO.totalBtn1();
		//totalRow랑 쿼리문이랑 일치
		
		int lastPage2 = totalRow2 % rowPerPage2;
		System.out.println(lastPage2+"<=lastPage2");

		if(totalRow2 % rowPerPage2 == 0)
			{
				lastPage2 = lastPage2 + 1;
			}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="styles.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<style>
	
	.header{
		text-align : center;
		background-color: #FF2424;
	}
	.main{
		font-family:"CookieRun";
		margin-top: 30px;
		text-align: center;
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
	.title{
	font-family:"Super Mario 256";
	text-align : center;
	font-size: 35px;
	-webkit-text-stroke-width: 1px; /* 테두리 두께 */
    -webkit-text-stroke-color: white; /* 테두리 색상 */
	}
	.goodsList a{
		color : gray;
		text-align : center;
		margin-right: 10px;
	}
	.goodsList a:hover{
		color : black;
	}
	.box {
    width: 1350px;
    margin: 0 auto;
    overflow: hidden;
    padding-top: 10px;
    background-color: white;
    display: flex;
    flex-wrap: wrap;
    justify-content: space-around; /* 필요에 따라 조정 */
	}
	
	.box .goodsimage1 {
	    /* float:left를 제거합니다. */
	    margin-bottom: 30px;
	    padding-bottom: 20px;
	    margin-right: ; /* 필요에 따라 margin-right를 조정하세요 */
	    width: 300px;
	    text-align: center;
	    background-color: white;
	}
	.box .goodsimage1 img{
		width : 200px;
		height : 200px;
	}
	.page{
		text-align: center;
	}
	.page button{
		margin: 10px;
		padding : 5px;
		
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
</div><br>
<!-- 여기까지헤드 -->
<div class="main">
		<div class="title">
			GOODS LIST
		</div>
		<div class="goodsList"><!-- list목록 나열 -->
			<!-- 전체데이터를 나열해줄 수 있는 sql하나 더 만들기 -->
			<a href="/shop/customer/customerGoodsList.jsp?totalRow=<%=totalRow%>">전체</a>
			<%
			//forHashMap으로 카테고리들을 나열시키기
				for(HashMap<String, Object>m : categoryList){
			%>		
				<!--1. category를 m.get으로 가져오기 -->
				<!--2. a태그로 주소만들어주기 -->
			<a href="/shop/customer/customerGoodsList.jsp?goodsNo=<%=(Integer)(m.get("goodsNo"))%>&category=<%=(String)(m.get("category"))%>&totalRow=<%=(Integer)(m.get("cnt"))%>">
				<%=(String)m.get("category") %>
			</a>
			<%
				}
			%>
	</div><br>
	<div class="box">
		<!--1. category=?일때의 나열 sql먼저 작성하고 오자-->
		<!--2. 전체 category값의 sql작성 -->
		<!--3. category == null일때로 나눠줌 -->
		<%
			if(category == null){
				for(HashMap<String, Object> m3 : allGoodsList){
		%>
			<div class="goodsimage1" style ="border: 1px;">
				<div>
					<a href="./customerGoodsOne.jsp?goodsNo=<%=(Integer)(m3.get("goodsNo"))%>">
						<img src="/shop/upload/<%=(String)m3.get("filename")%>">
					</a>
				</div>
				<div> 
					카테고리 : <%=(String)(m3.get("category"))%>
				</div>
					<a href="./customerGoodsOne.jsp?goodsNo=<%=(Integer)(m3.get("goodsNo"))%>">
						<div>
							no : <%=(Integer)(m3.get("goodsNo")) %>
						</div>
					</a>
				<hr>
				
				<div>
					<a href="./customerGoodsOne.jsp?goodsNo=<%=(Integer)(m3.get("goodsNo"))%>">
						이름 : <%=(String)(m3.get("goodsTitle"))%>
					</a>
				</div>
				<div>
					가격 : <%=(Integer)(m3.get("goodsPrice"))%>
				</div>
				<!-- 품절인경우 -->
					<%
						if((Integer)m3.get("goodsAmount") == 0) {
					%>
						<div>
							⚠️품절입니다⚠️
						</div>
					<%
						}
					%>
			</div>
		<%
			}
				}else{ //카테고리 값이 null이 아닌 경우 
					for(HashMap<String, Object> m2 : goodsList){
		%>
			<div class="goodsimage1" style ="border: 1px;">
				<div>
					<a href="./customerGoodsOne.jsp?goodsNo=<%=(Integer)(m2.get("goodsNo"))%>">
						<img src="/shop/upload/<%=(String)m2.get("filename")%>">
					</a>
				</div>
				
				<div> 카테고리 : <%=(String)(m2.get("category"))%></div>
				<a href="./customerGoodsOne.jsp?goodsNo=<%=(Integer)(m2.get("goodsNo"))%>">
				
					<div>no : <%=(Integer)(m2.get("goodsNo")) %></div>
				</a>
				<hr>
				<div>
					<a href="./customerGoodsOne.jsp">
						이름 : <%=(String)(m2.get("goodsTitle"))%>
					</a>
				</div>
				<div>
					가격 : <%=(Integer)(m2.get("goodsPrice"))%>
				</div>
				<!-- 품절인경우 -->
					<%
						if((Integer)m2.get("goodsAmount") == 0) {
					%>
						<div>
							⚠️품절입니다⚠️
						</div>
					<%
						}
					%>
			</div>
		<%			
				}
				}
		%>
	</div>
   <!-- 페이징 버튼 -->
   	<div class="page">
   		<%
		if(category == null){//전체 페이지를 위한 button
		%>
				<%
					if(currentPage >1 || currentPage<lastPage)
					{	
				%>
					<button><a href="./customerGoodsList.jsp?currentPage=1&totalRow2=<%=totalRow2%>">first</a></button>
					<button><a href="./customerGoodsList.jsp?currentPage=<%=currentPage-1%>&totalRow2=<%=totalRow2%>">pre</a></button>
				<%
					}
				%>
				<%
				if(currentPage<lastPage2 || currentPage == lastPage2)
					{
				%>
					<button><a href="./customerGoodsList.jsp?currentPage=<%=currentPage+1%>&totalRow2=<%=totalRow2%>">next</a></button>
					<button><a href="./customerGoodsList.jsp?currentPage=<%=lastPage2%>&totalRow2=<%=totalRow2%>">last</a></button>
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
				<button><a href="./customerGoodsList.jsp?currentPage=1&category=<%=category%>&totalRow=<%=totalRow%>">first</a></button>
				<button><a href="./customerGoodsList.jsp?currentPage=<%=currentPage-1%>&category=<%=category%>&totalRow=<%=totalRow%>">pre</a></button>
			<%
				}
			%>
			<%
			if(currentPage<lastPage || currentPage ==1 )
				{
			%>
				<button><a href="./customerGoodsList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>&totalRow=<%=totalRow%>">next</a></button>
				<button><a href="./customerGoodsList.jsp?currentPage=<%=lastPage%>&category=<%=category%>&totalRow=<%=totalRow%>">last</a></button>
			<%
				}
		}
			%>
   	</div>
	<br><br>

</div><!-- main끝 -->
</body>
</html>