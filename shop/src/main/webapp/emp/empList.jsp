<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.util.*" %>
<!--Controller Layer -->
<%
		// 인증분기 : 세션 변수 이름 - loginEmp 
		if(session.getAttribute("loginEmp") == null){
			response.sendRedirect("/shop/emp/empList.jsp");
			return;
		}

%>
<%
	//request 분석
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 10; 
	int startRow = (currentPage-1)*rowPerPage;
%>
<!-- Model Layer -->
<% 
		//모델 : 특수한 형태의 데이터(RDBMS : mariadb)
		//=> API 사용하여 자료구조(ResultSet) 취득
		//=>일반화된 자료구조(ArrayList<HashMap>)로 변경 -> 모델 취득 //MVC(Model, View, Controller)
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT emp_id empId, emp_name empName, emp_job empJob, hire_date hireDate, active FROM emp order by hire_date desc limit ?,?";
		conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, startRow);
		stmt.setInt(2, rowPerPage);
		rs = stmt.executeQuery(); //JDBC API 종속된 자료구조 모델 = > 기본 API자료구조(ArrayList)로 변경
				
				
		ArrayList<HashMap<String, Object>>list
		 = new ArrayList<HashMap<String, Object>>();
		//object넌 뭐다? 모든 타입의 부모가 되는것(아까예를 들면 '사람'(소방관,경찰관의 부모)처럼 
		//나중에 object를 String이나 integer로 형변환 시켜줄 수 있다. )
		//ResultSet -> ArrayList<HashMap<String, Object>>	
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("empId", rs.getString("empId"));
			m.put("empName", rs.getString("empName"));
			m.put("empJob", rs.getString("empJob"));
			m.put("hireDate", rs.getString("hireDate"));
			m.put("active", rs.getString("active"));
			list.add(m);
		}
		//JDBC API 사용이 끝났다면 DB자원들을 반납
		
%>

<!-- View layer : 모델(ArrayList<Hashmap<String, Object>>) 출력 -->
<!DOCTYPE html>
<html>
<head>
		<meta charset="UTF-8">
		<title></title>
</head>
<body>
	<div><a href="./empLogout.jsp">로그아웃</a></div>
		<h1>사원목록</h1>
			<table border="1">
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
								<td><%=(String)(m.get("empId"))%></td>
								<td><%=(String)(m.get("empName"))%></td>
								<td><%=(String)(m.get("empJob"))%></td>
								<td><%=(String)(m.get("hireDate"))%></td>
								<td>	
									<a href='modifyEmpActive.jsp?active=<%=(String)(m.get("active"))%>'>
										<%=(String)(m.get("active"))%>
									</a>
								</td>
							</tr>
					<%		
						}
					%>
			</table>
</body>
</html>