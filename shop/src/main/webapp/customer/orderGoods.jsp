<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="shop.dao.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*" %>
<%
	//인증분기
	if(session.getAttribute("CustomerLogin") == null) {
    response.sendRedirect("/shop/customer/customerLoginForm.jsp");
    return;
 }
%>
<%
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
		System.out.println(goodsNo + "<===goodsNo");
	
	
	//login session에서 id값만 가져오기
		HashMap<String, Object> login = (HashMap<String, Object>)(session.getAttribute("CustomerLogin")); 
		String id = (String)(login.get("id"));
		//넘어온건지 확인 => orderListID확인 완료
			System.out.println("여기는 orderGoods2에서 확인하는 " + id);
	//회원정보 customer에서 가져오기
	HashMap<String, String>customerInformation
		=OrderGoodsDAO.customerInfo(id);
	//잘 넘어오는지 확인해보자=>완료
		System.out.println(customerInformation + "<==customerInformation");
		
	//orders 테이블 값 가져오기
		ArrayList<HashMap<String,Object>>ordersList
			= OrderGoodsDAO.ordersList1(id);
	

		
	//테이블값 디버깅하기
		System.out.println(ordersList + "<==orderGoods2.ordersList");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	.container{
	margin-top : 15px;
	text-align: center;
	font-family:"CookieRun";
	}
    img {
       width: 50px;
       height: 50px;
    }
    label{
    margin-bottom: 14px;
    }
    table{
	margin: auto;
	border-collapse: separate; /* 셀 간격을 지정하기 위해 border-collapse 속성을 separate로 설정 */
    border-spacing: 15px;
	}
</style>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function validateForm() {
        var phone = document.getElementById("phone").value;
        var address = document.getElementById("sample6_address").value;
        var detailAddress = document.getElementById("sample6_detailAddress").value;
        
        if (phone.trim() === "" || address.trim() === "" || detailAddress.trim() === "") {
            alert("연락처와 주소를 모두 입력해주세요.");
            return false;
        }
        return true;
    }
</script>
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
<br>
<div class="container">
    <h1>주문내역 작성</h1><br>
    <form method="post" action="orderGoodsAction.jsp" onsubmit="return validateForm()">
        <label for="id">
            id :
        </label>
        <input type="text" id="id" name="id" value="<%=id %>"><br>
        <label for="name">
            성함 :
        </label>
        <input type="text" id="name" name="name" value="<%=customerInformation.get("name")%>"><br>
        <label>
            mail :
        </label>
        <input type="text" id="mail" name="mail" value="<%=customerInformation.get("mail")%>"><br>
        <label for="phone">✔️연락처 : </label>
        <input type="text" id="phone" name="phone" maxLength={13} placeholder="010-XXXX-XXXX"><br>
        <!-- 주소 API -->
        <label>✔️주소 : </label>
        <input type="text" id="sample6_postcode" name="sample6_postcode" placeholder="우편번호">
        <input type="button" class="btn btn-secondary btn-sm" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
        <input type="text" id="sample6_address" name="sample6_address"  placeholder="주소" style="margin-bottom: 7px;"><br>
        <input type="text" id="sample6_detailAddress" name="sample6_detailAddress" placeholder="상세주소">
        <input type="text" id="sample6_extraAddress" name="sample6_extraAddress" placeholder="참고항목">
        <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
        <script>
            function sample6_execDaumPostcode() {
                new daum.Postcode({
                    oncomplete: function(data) {
                        var addr = '';
                        var extraAddr = '';
                        if (data.userSelectedType === 'R') { 
                            addr = data.roadAddress;
                        } else { 
                            addr = data.jibunAddress;
                        }
                        if(data.userSelectedType === 'R'){
                            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                                extraAddr += data.bname;
                            }
                           
                            if(data.buildingName !== '' && data.apartment === 'Y'){
                                extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                            }
                            
                            if(extraAddr !== ''){
                                extraAddr = ' (' + extraAddr + ')';
                            }
                          
                            document.getElementById("sample6_extraAddress").value = extraAddr;
                        
                        } else {
                            document.getElementById("sample6_extraAddress").value = '';
                        }
    
                        document.getElementById('sample6_postcode').value = data.zonecode;
                        document.getElementById("sample6_address").value = addr;
                       
                        document.getElementById("sample6_detailAddress").focus();
                    }
                }).open();
            }
        </script>
        <br>
        <!-- filename, goodsTitle, amount, totalPrice,goodsNo(hidden), 총가격 : totalPrice -->
        <table>
            <tr>
                <td></td>
                <td>상품명</td>
                <td>가격</td>
                <td>수량</td>
            </tr>
            <% for(HashMap<String,Object>order : ordersList){
            		if(order.get("state").equals("결제완료")){
            %>		
	            <tr>
	                <th><img src="/shop/upload/<%= order.get("filename")%>"></th>
	                <th><%= order.get("goodsTitle")%></th>
	                <th><%= order.get("goodsPrice")%>원</th>
	                <th>
	                    <%= order.get("amount")%>개
	                </th>
	            </tr>
            <% 
            		}
           		 }
            %>
        </table>
        <br><button type="submit" class="btn btn-danger btn-sm">결제하기</button>
    </form>
</div>
</body>
</html>