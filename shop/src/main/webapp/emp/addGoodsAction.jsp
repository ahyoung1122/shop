<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
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
	String empId = request.getParameter("empId");
	String goodsTitle = request.getParameter("goodsTitle");
	int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
	int goodsAmount = Integer.parseInt(request.getParameter("goodsAmount"));
	String goodsContent = request.getParameter("goodsContent");
	
	Part part = request.getPart("goodsImg");
	String originalName = part.getSubmittedFileName();
	//원본이름에서 확장자만 분리
	int dotIdx = originalName.lastIndexOf(".");
	String ext = originalName.substring(dotIdx);
	System.out.println(dotIdx);
	System.out.println(ext);
	
	UUID uuid = UUID.randomUUID();//uuid안에서 생성되는 글자는 절대!!! 중복될 수 없음!!
	//단점은 4자마다 작대기가 잇음...ㅎ 좀 불편하면 작대기 지워버리면됨.
	String filename = uuid.toString().replace("-","" );//"-를 삭제하는 코드"
	filename= filename + ext;
	
	//디버깅
	System.out.println(category);
	System.out.println(goodsTitle);
	System.out.println(filename);
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
	
	String sql = "INSERT INTO goods(category, emp_id, goods_title, filename, goods_price, goods_amount, goods_content, update_date, create_date) VALUES(?, 'admin',?, ?, ?, ?, ?, NOW(),NOW())";
	stmt = conn.prepareStatement(sql);
	
		stmt.setString(1, category);	
		stmt.setString(2, empId);	
		stmt.setString(3, goodsTitle);
		stmt.setString(4, filename);
		stmt.setInt(5, goodsPrice);
	   	stmt.setInt(6, goodsAmount);
	   	stmt.setString(7, goodsContent);
	   	//디버깅 확인
	   	System.out.println(stmt+"=stmt");
	   	int row = 0;
	   	row = stmt.executeUpdate();
	   	
	   	if(row ==1){	//insert성공하면 업로드
	   		//part ->1.is ->2.os ->3.빈파일
	   		//1.
	   		InputStream is = part.getInputStream();
	   		//3+2.
	   		String filePath = request.getServletContext().getRealPath("upload");
	   		File f = new File(filePath, filename); //빈파일 
	   		OutputStream os = Files.newOutputStream(f.toPath()); // os+file
	   		is.transferTo(os);
	   		//클래스 이름으로 호출해서 static메소드임.
	   		
	   		os.close();
	   		is.close();
	   	}
	   	
	/*    	if(row == 0){ //insert실패 -> 파일업로드 진행X
	   		return;
	   	} */
	
		//이미지 삭제하는방법
		/* 	File df = new File(filePath, rs.getString("filename"));
	 	df.delete()
		 */
	 	/* 삭제하는것보다 덮어쓰기 하는걸로 하면될듯... */
	 
		 /* 이미지 추가 되는지 확인하고, 이미지 출력하고, 데이터 저장되는지 확인하기, css를 활용해서 크기 맞춰주기 list.jsp에서 출력
	 	goods수정도 하고 이미지도 수정되게 하고, 삭제도 해야되고 */
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
   
