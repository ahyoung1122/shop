<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.util.*" %>
<%
	// 인증분기	 : 세션변수 이름 - loginEmp
	String loginMember = (String)(session.getAttribute("loginMember"));
	if(session.getAttribute("loginMember") == null) {
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
%>
<!-- Model Layer -->
<%	
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String sql = "SELECT  emp_id empId, emp_name empName, emp_job empJob, hire_date hireDate, active from emp order by hire_date desc limit ?, ?";
	
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1, startRow);
	stmt.setInt(2, rowPerPage);
	rs = stmt.executeQuery();	// JDBC API 종속된 자료구조 모델 ResultSet ==>> 기본 API 자료구조(ArrayList)로 변경
	ArrayList<HashMap<String, Object>> list		// 모든타입의 부모는 Object 
			= new ArrayList<HashMap<String, Object>>();
	// ResultSet ==>> ArrayList<HashMap<String, Object>>
	while(rs.next()) {
		HashMap<String, Object> m = new HashMap<String, Object>();
		m.put("empId", rs.getString("empId"));
		m.put("empName", rs.getString("empName"));
		m.put("empJob", rs.getString("empJob"));
		m.put("hireDate", rs.getString("hireDate"));
		m.put("active", rs.getString("active"));
		list.add(m);
	}
	// JDBC API 사용이 끝났다면 DB자원들을 반납
%>

<!-- View Layer -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
<div><a href="/shop/emp/empLogout.jsp">로그아웃</a></div>
	<h1>사원목록</h1>
		<form method="post" action="/shop/emp/modifyEmpActive.jsp">	
			<table border ="1">
				<tr>
					<th>empId</th>
					<th>empName</th>
					<th>empJob</th>
					<th>hireDate</th>
					<th>active</th>
				</tr>
				<%
					for(HashMap<String, Object> m : list) {
				%>
				<tr>
					<td><%=(String)m.get("empId")%></td>
					<td><%=(String)m.get("empName")%></td>
					<td><%=(String)m.get("empJob")%></td>
					<td><%=(String)m.get("hireDate")%></td>
					<td>
							<a href='modifyEmpActive.jsp?active=<%=(String)m.get("active")%>&empId=<%=(String)m.get("empId")%>'>
									<%=(String)m.get("active")%>
							</a>
					</td>
				</tr>
				<%		
						}
				%>
	</table>
</form>
</body>
</html>