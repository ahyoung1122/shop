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
		System.out.println("여기는 commentOne.jsp.id" + id);
	
/* 	//orders테이블에서 상품정보 가져오기 
	HashMap<String,Object> customerComment = OrderGoodsDAO.comment(id);
		String ordersNo1 = (String) customerComment.get("ordersNo");
			int ordersNo = Integer.parseInt(ordersNo1);
				//디버깅
				System.out.println(ordersNo + "customerComment.ordersNo"); */
				
	String goodsTitle = request.getParameter("goodsTitle");
			System.out.println(goodsTitle + "<==후기상품이름");
	
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
		System.out.println(ordersNo + "<==후기상품번호");
		
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
	.comment{
	 color : ivory;
	 -webkit-text-stroke-width: 2px; /* 테두리 두께 */
 	 -webkit-text-stroke-color: black;
	}
	.container{
	margin-top : 20px;
	text-align: center;
	font-family:"CookieRun";
	
	/* 별점 */
	.starpoint_wrap{display:inline-block;}
	.starpoint_box{position:relative;background:url(https://ido-archive.github.io/svc/etc/element/img/sp_star.png) 0 0 no-repeat;font-size:0;}
	.starpoint_box .starpoint_bg{display:block;position:absolute;top:0;left:0;height:18px;background:url(https://ido-archive.github.io/svc/etc/element/img/sp_star.png) 0 -20px no-repeat;pointer-events:none;}
	.starpoint_box .label_star{display:inline-block;width:10px;height:18px;box-sizing:border-box;}
	.starpoint_box .star_radio{opacity:0;width:0;height:0;position:absolute;}
	.starpoint_box .star_radio:nth-of-type(1):hover ~ .starpoint_bg,
	.starpoint_box .star_radio:nth-of-type(1):checked ~ .starpoint_bg{width:10%;}
	.starpoint_box .star_radio:nth-of-type(2):hover ~ .starpoint_bg,
	.starpoint_box .star_radio:nth-of-type(2):checked ~ .starpoint_bg{width:20%;}
	.starpoint_box .star_radio:nth-of-type(3):hover ~ .starpoint_bg,
	.starpoint_box .star_radio:nth-of-type(3):checked ~ .starpoint_bg{width:30%;}
	.starpoint_box .star_radio:nth-of-type(4):hover ~ .starpoint_bg,
	.starpoint_box .star_radio:nth-of-type(4):checked ~ .starpoint_bg{width:40%;}
	.starpoint_box .star_radio:nth-of-type(5):hover ~ .starpoint_bg,
	.starpoint_box .star_radio:nth-of-type(5):checked ~ .starpoint_bg{width:50%;}
	.starpoint_box .star_radio:nth-of-type(6):hover ~ .starpoint_bg,
	.starpoint_box .star_radio:nth-of-type(6):checked ~ .starpoint_bg{width:60%;}
	.starpoint_box .star_radio:nth-of-type(7):hover ~ .starpoint_bg,
	.starpoint_box .star_radio:nth-of-type(7):checked ~ .starpoint_bg{width:70%;}
	.starpoint_box .star_radio:nth-of-type(8):hover ~ .starpoint_bg,
	.starpoint_box .star_radio:nth-of-type(8):checked ~ .starpoint_bg{width:80%;}
	.starpoint_box .star_radio:nth-of-type(9):hover ~ .starpoint_bg,
	.starpoint_box .star_radio:nth-of-type(9):checked ~ .starpoint_bg{width:90%;}
	.starpoint_box .star_radio:nth-of-type(10):hover ~ .starpoint_bg,
	.starpoint_box .star_radio:nth-of-type(10):checked ~ .starpoint_bg{width:100%;}
	
	.blind{position:absolute;clip:rect(0 0 0 0);margin:-1px;width:1px;height: 1px;overflow:hidden;}
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
	<h1 class="comment">후기작성하기</h1>
		<div style="margin-top: 20px; margin-bottom: 20px;">
			<span style="color : orange;">주문 상품</span> : <%=goodsTitle %>
		</div>
			<form method="post" action="./myCommentOneAction.jsp">
				<div>
					<input type="hidden" name="ordersNo" value="<%=ordersNo%>">
				</div>
				<div class="starpoint_wrap">
					<span>만족도</span>
				  <div class="starpoint_box">
				    <label for="starpoint_1" class="label_star" title="0.5"><span class="blind">0.5점</span></label>
				    <label for="starpoint_2" class="label_star" title="1"><span class="blind">1점</span></label>
				    <label for="starpoint_3" class="label_star" title="1.5"><span class="blind">1.5점</span></label>
				    <label for="starpoint_4" class="label_star" title="2"><span class="blind">2점</span></label>
				    <label for="starpoint_5" class="label_star" title="2.5"><span class="blind">2.5점</span></label>
				    <label for="starpoint_6" class="label_star" title="3"><span class="blind">3점</span></label>
				    <label for="starpoint_7" class="label_star" title="3.5"><span class="blind">3.5점</span></label>
				    <label for="starpoint_8" class="label_star" title="4"><span class="blind">4점</span></label>
				    <label for="starpoint_9" class="label_star" title="4.5"><span class="blind">4.5점</span></label>
				    <label for="starpoint_10" class="label_star" title="5"><span class="blind">5점</span></label>
				    <input type="radio" name="starpoint" id="starpoint_1" class="star_radio" value="0.5">
				    <input type="radio" name="starpoint" id="starpoint_2" class="star_radio" value="1">
				    <input type="radio" name="starpoint" id="starpoint_3" class="star_radio" value="1.5">
				    <input type="radio" name="starpoint" id="starpoint_4" class="star_radio" value="2">
				    <input type="radio" name="starpoint" id="starpoint_5" class="star_radio" value="2.5">
				    <input type="radio" name="starpoint" id="starpoint_6" class="star_radio" value="3">
				    <input type="radio" name="starpoint" id="starpoint_7" class="star_radio" value="3.5">
				    <input type="radio" name="starpoint" id="starpoint_8" class="star_radio" value="4">
				    <input type="radio" name="starpoint" id="starpoint_9" class="star_radio" value="4.5">
				    <input type="radio" name="starpoint" id="starpoint_10" class="star_radio" value="5">
				    <span class="starpoint_bg"></span>
				  </div>
				</div>
			<div>
				<textarea rows="5" cols="50" name="content"></textarea>
			</div>
			<button type="submit" class="btn btn-warning">후기제출</button>
		</form>
</div><!-- container마지막 -->

</body>
</html>