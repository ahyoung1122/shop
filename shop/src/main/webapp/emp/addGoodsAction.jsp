<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import = "java.sql.*" %>
<!-- Controller Layer -->
<%
	request.setCharacterEncoding("UTF-8");
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>
<!-- Session설정값 : 입력시 로그인 emp의 emp_id값이 필요해서... -->
<%
	HashMap<String,Object> loginMember 
		= (HashMap<String,Object>)(session.getAttribute("loginEmp"));
	
%>
<!-- Model Layer -->
<%
	String category = request.getParameter("category");
	String goodsTitle = request.getParameter("goodsTitle");
	int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
	int goodsAmount = Integer.parseInt(request.getParameter("goodsAmount"));
	String goodsContent = request.getParameter("goodsContent");
	//디버깅
	System.out.println(category);
	System.out.println(goodsTitle);
	System.out.println(goodsPrice);
	System.out.println(goodsAmount);
	System.out.println(goodsContent);
		
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");

	/*INSERT INTO 
	goods(goodsTitle, goodsPrice, goodsAmount, goodsContent) 
	VALUES (?,?,?,?)*/
	
	String sql = "INSERT INTO goods(category, emp_id, goods_title , goods_price , goods_amount , goods_content , update_date, create_date) VALUES(?, 'admin', ?, ?, ?, ?, NOW(),NOW())";
		stmt = conn.prepareStatement(sql);
	
		stmt.setString(1, category);	
		stmt.setString(2, goodsTitle);
		stmt.setInt(3, goodsPrice);
	   	stmt.setInt(4, goodsAmount);
	   	stmt.setString(5, goodsContent);
	   	//디버깅 확인
	   	System.out.println(stmt+"=stmt");
	   	int row = 0;
	   	row = stmt.executeUpdate();
%>

<!-- Controller Layer -->
<%
// 성공했을때는 response.sendRedirect("/shop/emp/goodsList.jsp"); 
// 실패했을때는 response.sendRedirect("/shop/emp/goodsList.jsp");
//클라이언트 기준으로


    if(row == 1) {
        System.out.println("입력성공");
        response.sendRedirect("/shop/emp/goodsList.jsp");
    } else {
        System.out.println("입력실패");
        response.sendRedirect("/shop/emp/goodsList.jsp");
    }

%>
   
