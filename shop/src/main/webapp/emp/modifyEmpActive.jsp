<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
    <%//active랑 empId가져오기
    String active = request.getParameter("active");
    String empId = request.getParameter("empId");
    //디버깅
    System.out.println(active);
    System.out.println(empId);
    
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	PreparedStatement stmt2 = null;
	ResultSet rs = null;
	
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	//active가 on인 경우랑 off인 경우 나눠서 분기
	
	if(active.equals("ON")){//on인 경우 off로
		String sql = "UPDATE emp SET active  = 'OFF' WHERE emp_id = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, empId);
		System.out.println(stmt+"=stmt");
		
		int row = 0;
		row = stmt.executeUpdate();
			if(row==1 ) { //둘다 empList로 response
				System.out.println("변경");
				response.sendRedirect("/shop/emp/empList.jsp");
			}  else {
				System.out.println("변경안됨");
				response.sendRedirect("/shop/emp/empList.jsp");
			}
	}
		if(active.equals("OFF")){//off인 경우는 on으로
				String sql2 = "UPDATE emp SET active  = 'ON' WHERE emp_id = ?";
				stmt2 = conn.prepareStatement(sql2);
				stmt2.setString(1, empId);
				System.out.println(stmt2+"=stmt2");
				int row2 = 0;
				row2 = stmt2.executeUpdate();
					if(row2==1 ) {
						System.out.println("변경");
						response.sendRedirect("/shop/emp/empList.jsp");
					}  else {
						System.out.println("변경안됨");
						response.sendRedirect("/shop/emp/empList.jsp");
					}
		}	
	
    %>