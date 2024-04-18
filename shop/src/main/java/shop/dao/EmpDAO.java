package shop.dao;

//import는 치환의 개념이라고 생각하면 됨, 문법적으로는 아무런 기능이 없음.
import java.sql.Connection;
import java.util.ArrayList;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;


//emp 테이블을 CRUD하는 STATIC 메서드의 컨테이너
public class EmpDAO {
	//HashMap<String, Object> : null이면 로그인 실패, 아니면 성공
	//String empId, String empPw
	public static HashMap<String, Object> empLogin(String empId, String empPw) throws Exception{
		HashMap<String, Object>resultMap = null;
		
		//DB로 접근
	   Class.forName("org.mariadb.jdbc.Driver");
	   Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	   
	   String sql = "select emp_id empId, emp_name empName, grade from emp where active='ON' and emp_id =? and emp_pw = password(?)";
	   PreparedStatement stmt = conn.prepareStatement(sql);
	   stmt.setString(1, empId);
	   stmt.setString(2, empPw);
	   ResultSet rs = stmt.executeQuery();
	   if(rs.next()) {
		   resultMap = new HashMap<String, Object>();
		   resultMap.put("empId", rs.getString("empId"));
		   resultMap.put("empName", rs.getString("empName"));
		   resultMap.put("grade", rs.getInt("grade"));
	   }
		conn.close();
		return resultMap;
	}
	
	public static int modifyEmpActive(String active, String empId) throws Exception{
		System.out.println(empId+" <<= empId");
		System.out.println(active+" <<= active");
		
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
		String sql = "UPDATE emp SET active='OFF' WHERE emp_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt = conn.prepareStatement(sql);
		int row = 0;
		if(active.equals("ON")){//on인 경우 off로
			String sql2 = "UPDATE emp SET active='OFF' WHERE emp_id = ?";
			stmt = conn.prepareStatement(sql2);
			stmt.setString(1, empId);
			System.out.println(stmt+"  <<= stmt");
			
			
			row = stmt.executeUpdate();
			
				if(row==1 ) { //둘다 empList로 response
					System.out.println("변경");
				}  else {
					System.out.println("변경안됨");
				}
		}
			if(active.equals("OFF")){//off인 경우는 on으로
					String sql3 = "UPDATE emp SET active ='ON'WHERE emp_id = ?";
					stmt = conn.prepareStatement(sql3);
					stmt.setString(1, empId);
					int row2 = 0;
					row2 = stmt.executeUpdate();
						if(row2==1 ) {
							System.out.println("변경");
						}  else {
							System.out.println("변경안됨");
						}
			}	
			return row;
	}
	
	//emp 페이징 하기
	//호출 : empList.jsp
	
	public static int empPage() throws Exception
		{
			int row = 0;
			
			Class.forName("org.mariadb.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
			
			String sql = "SELECT count(*) cnt From emp";
			
			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet rs =stmt.executeQuery();
			
			if(rs.next()) 
				{
					row = rs.getInt("cnt");
				}
			
			return row;
		}
	//empList나열
	//호출 : empList.jsp
	//param : emp
	//return : list<HashMap<String,Object>
	public static ArrayList<HashMap<String, Object>> empListAll(
			int startRow, int rowPerPage) throws Exception{
		ArrayList<HashMap<String, Object>>list 
			= new ArrayList<HashMap<String, Object>>();
		//연결하기
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
		//쿼리
		String sql = "SELECT  emp_id empId, emp_name empName, emp_job empJob, hire_date hireDate, active from emp order by hire_date desc limit ?, ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, startRow);
			stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
			while(rs.next()) 
				{
					HashMap<String, Object> m = new HashMap<String, Object>();
					m.put("empId", rs.getString("empId"));
					m.put("empName", rs.getString("empName"));
					m.put("empJob", rs.getString("empJob"));
					m.put("hireDate", rs.getString("hireDate"));
					m.put("active", rs.getString("active"));
					list.add(m);
				}
		return list;
	}
	


}
