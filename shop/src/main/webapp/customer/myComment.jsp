<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*" %>
<%
//로그인 인증분기

if(session.getAttribute("CustomerLogin") == null) {
    response.sendRedirect("/shop/customer/customerLoginForm.jsp");
    return;
 }

%>
<%
	HashMap<String, Object> login = (HashMap<String, Object>)(session.getAttribute("CustomerLogin")); 
	String id = (String)(login.get("id"));
	//id확인 
		System.out.println("여기는 myComment.jsp.id" + id);

		ArrayList<HashMap<String,Object>> commentList
			=	CommentDAO.commentList1(id);
		
		//디버깅해서 확인
		System.out.println(commentList + "<===여기 comment출력확인");
	
	
	//코멘트 추가한거 가져오기
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myComment</title>
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
	.box{
		margin-top: 30px;
		display: flex;
   		justify-content: center;
		
	}
	.box table td {
    border: 2px solid black; /* 점선 스타일을 설정합니다 */
    padding: 10px; /* 셀 내부 여백을 설정합니다 */
}
	
	.container{ 
	margin-top : 20px;
	text-align: center;
	font-family:"CookieRun";
	}
	img{
	height: 70px;
	width : 70px;
	}

	/* 별점 */
	.starpoint_wrap {
    display: inline-block;
    position: relative;
	}
	
	.starpoint_box {
	    position: relative;
	    background: url(https://ido-archive.github.io/svc/etc/element/img/sp_star.png) 0 0 no-repeat;
	    width: 100px; /* 별점 이미지의 가로 크기에 맞추어 조절하세요 */
	    height: 20px; /* 별점 이미지의 세로 크기에 맞추어 조절하세요 */
	    z-index: 1; /* 별점 이미지를 배경보다 위로 올립니다. */
	}
	
	.starpoint_bg {
	    display: block;
	    position: absolute;
	    top: 0;
	    left: 0;
	    height: 100%;
	    background: url(https://ido-archive.github.io/svc/etc/element/img/sp_star.png) 0 -20px no-repeat;
	    pointer-events: none;
	    width: 100%;
	    z-index: -1; /* 배경 이미지를 별점 이미지 아래로 내립니다. */
	}
	
	.starpoint_fill {
	    position: absolute;
	    top: 0;
	    left: 0;
	    height: 100%;
	    width: 0; /* 초기 너비는 0으로 설정 */
	    background: url(https://ido-archive.github.io/svc/etc/element/img/sp_star.png) 0 0 no-repeat;
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
<div class="container">
	<h1>내 후기</h1>
				<%
					for(HashMap<String,Object> m : commentList){
				%>	
				<div class="box">
					<table border="1">
						<tr>
							<td rowspan="3"><img src="/shop/upload/<%= m.get("filename")%>"></td>
							<td> 작성일 : <%=m.get("updateDate")%></td>
						</tr>
						<tr>
							<td>
								만족도 : <div class="starpoint_wrap">
		                    		<div class="starpoint_box">
		                       		 <div class="starpoint_bg"></div>
		                       		 <div class="starpoint_fill" style="width: <%= (double)m.get("starPoint") * 10 %>"></div>
		                    		</div>
		                		</div>
							</td>
						</tr>
						<tr>
							<td> 후기 : <%=m.get("content")%></td>
						</tr>
					</table>
				</div>
				<%
					}
				%>
		
</div><!-- container마지막 -->
</body>
</html>