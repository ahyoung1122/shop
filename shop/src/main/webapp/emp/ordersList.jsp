<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.util.*" %>
<%@ page import = "shop.dao.*" %>
<%
	// 인증분기	 : 세션변수 이름 - loginEmp
	/* String loginEmp = (String)(session.getAttribute("loginEmp")); */
	if(session.getAttribute("loginEmp") == null) {
		String errMsg = URLEncoder.encode("잘못된 접근입니다. 로그인 먼저해주세요","utf-8");
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>
<%

	// request 분석
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage =10;
	int startRow = (currentPage-1) * rowPerPage;
	
	//페이징 모듈
	int totalRow = EmpDAO.customerPage();

	int lastPage = totalRow / rowPerPage;
	if(totalRow % rowPerPage != 0) {
		lastPage = lastPage + 1;
	   }
%>
<!-- Model Layer -->
<%	
	//ordersTable에서 고객주문목록 불러오기
	ArrayList<HashMap<String,Object>>orders
			= CustomerDAO.orderList1();
	//디버깅
	System.out.println(orders + "ordersList.orders");
	//디버깅 확인 완료!
%>

<!-- View Layer -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>empList</title>
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
			    width: 145px; height: 70px;
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
			a{
			text-decoration: none;
			color : orange;
			}
			button a{
			color :black;
			}
		</style>
</head>
<body>
<div class="header">
<img src="./img/mario&luigi.png">
<!-- empMenu.jsp include : 주체는 서버! vs redirect(주체는 클라이언트!) -->
<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include> <!-- include서버 적을때 조심!! shop부터 시작하지말자! -->
<!-- 매번 페이지 만들때마다 이 코드 작성해줘서 메뉴창을 위에 띄워두자!^_^-->
<div><a href="/shop/emp/empLogout.jsp">로그아웃</a></div>
</div><!-- header의마지막 -->
<div class="container">
		<div class="row">
			<div class="col-2"></div>
			<div class="mt-5 col-8 bg-black border shadow p-3 mb-5 bg-body-tertiary rounded" >
				<h1>고객주문 관리</h1>
					<a class="btn btn-warning" href="./allCommentList.jsp" role="button">
						전체후기보기
					</a>
						<div class="box">
							<table border ="1">
								<tr>
									<th>주문번호</th>
									<th>고객ID</th>
									<th>성함</th>
									<th>연락처</th>
									<th>상품</th>
									<th>총가격</th>
									<th>구매일</th>
									<th>배송관리</th>
								</tr>
								<%
									for(HashMap<String,Object> m : orders){
								%>
										<tr>
											<td><%=m.get("ordersNo")%></td>
											<td><%=m.get("id")%></td>
											<td><%=m.get("name")%></td>
											<td><%=m.get("phone")%></td>
											<td><%=m.get("goodsTitle")%></td>
											<td><%=m.get("totalPrice")%></td>
											<td><%=m.get("createDate")%></td>
											<td>
												<form method="post" action="./ordersListState.jsp?ordersNo=<%=(Integer)(m.get("ordersNo"))%>">
													<select name="state">
														<option value="<%=(String)(m.get("state"))%>"><%=(String)(m.get("state"))%></option>
														<option value="결제완료">결제완료</option>
														<option value="배송중">배송중</option>
														<option value="배송완료">배송완료</option>
													</select>
													<button type="submit">변경</button>
												</form>
											</td>
											
										</tr>
									
								<%
									}
								%>
							</table>
						</div>
							<div><%=currentPage%></div><!-- 현재 페이지를 나타냄 -->
							<div><!-- 이전,다음 버튼 만들기 -->
								<%
									if(currentPage >1)
									{	
								%>
									<button><a href="./customerList.jsp?currentPage=1">처음</a></button>
									<button><a href="./customerList.jsp?currentPage=<%=currentPage-1%>">이전</a></button>
								<%
									}
								%>
								<%
								if(currentPage<lastPage || currentPage ==1 )
									{
								%>
									<button><a href="./customerList.jsp?currentPage=<%=currentPage+1%>">다음</a></button>
									<button><a href="./customerList.jsp?currentPage=<%=lastPage%>">마지막</a></button>
								<%
									}
								%>
							</div>
			</div><!-- col-8마지막 -->
		<div class="col-2"></div>
	</div><!-- row -->
</div><!-- container --> 

</body>
</html>
