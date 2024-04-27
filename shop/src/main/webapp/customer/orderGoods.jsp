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
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
    img {
        width: 50px;
        height: 50px;
    }
</style>
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
<div class="container">
    <h1>주문내역 작성</h1>
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
        <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
        <input type="text" id="sample6_address" placeholder="주소"><br>
        <input type="text" id="sample6_detailAddress" placeholder="상세주소">
        <input type="text" id="sample6_extraAddress" placeholder="참고항목">
        
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
        <table border="1">
            <tr>
                <td></td>
                <td>상품명</td>
                <td>가격</td>
                <td>수량</td>
            </tr>
            <% for(HashMap<String,Object>order : ordersList){ %>
            <tr>
                <th><img src="/shop/upload/<%= order.get("filename")%>"></th>
                <th><%= order.get("goodsTitle")%></th>
                <th><%= order.get("goodsPrice")%>원</th>
                <th>
                    <%= order.get("amount")%>개
                </th>
            </tr>
            <% } %>
        </table>
        <br><button type="submit">결제하기</button>
    </form>
</div>
</body>
</html>