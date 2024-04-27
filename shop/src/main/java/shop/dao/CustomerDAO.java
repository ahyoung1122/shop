package shop.dao;

import java.sql.*;
import java.util.*;
import java.net.*;
import java.io.*;
import java.nio.file.*;

//고객관리별 static 메소드 모음.
public class CustomerDAO {
	//Customer 로그인
	public static HashMap<String, Object> LoginCustomer(String id, String pw) 
			throws Exception{HashMap<String, Object>resultMap = null;
		
			Connection conn = DBHelper.getConnection(); 
		
			String loginSql = "SELECT id, pw FROM customer "
					+ "WHERE id=? AND pw=?";
			PreparedStatement stmt = conn.prepareStatement(loginSql);
		    stmt.setString(1, id);
		    stmt.setString(2, pw);
		    ResultSet rs = stmt.executeQuery();
		    
		    if(rs.next()) {
		    	resultMap = new HashMap<String, Object>();
		    	resultMap.put("id", rs.getString("id"));
				resultMap.put("pw", rs.getString("pw"));
		    	
		    }
		   
		conn.close();
		return resultMap;
	}
	//회원가입 static 생성하기
	//호출 : addCustomerAcion.jsp
	//param : customer
	//return : int
		 public static int addCustomer(String id, String pw, String mail,
				 String name, String birth, String gender) throws Exception{
			 int row = 0;
			 
			 Connection conn = DBHelper.getConnection(); 
			 
			String sql = "INSERT INTO customer(id, pw, mail, name, birth, gender, update_date, create_date) "
					+ "		VALUES (?, ?, ?, ?, ?, ?, NOW(), NOW())";
			PreparedStatement stmt = conn.prepareStatement(sql);
			
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, id);
			stmt.setString(2, pw);
			stmt.setString(3, mail);
			stmt.setString(4, name);
			stmt.setString(5, birth);
			stmt.setString(6, gender);
			
			row = stmt.executeUpdate();
			
			return row;
			 
		 }
	//회원가입할때 아이디 중복값 체크하기
	//호출 :  checkIdAction.jsp
	//param : String(메인 문자열)
	//return : boolean(사용가능하면 true, 불가면 false)
	
	public static boolean checkId(String id) throws Exception{
		boolean result = false;
		
		 Connection conn = DBHelper.getConnection();
		 String sql = "select id from customer where id=?";
		// 결과가 있으면 이미 이 날짜에 일기가 있다=>이 날짜로는 입력불가!!
		 	PreparedStatement stmt = conn.prepareStatement(sql);
		 	stmt.setString(1, id);
		 	ResultSet rs = stmt.executeQuery();
				if(rs.next()) {
					//해당행이 존재하는 것이기 때문에 true값이지만
					//id가 존재하기 때문에 id는 사용이 불가능하다
					 result = false;
				}else {
					result = true;
					//해당행이 존재하지 않기 때문에 false값이지만
					//이 메일은 사용 가능
				}
				conn.close();
			
			return result;
	}
	//customer 정보 가지고 오기
	//호출 : customerPage.jsp
	//param : string, string, string, string
	//return : HashMap
	
	public static HashMap<String,Object> customerPage(String id)throws Exception{
		HashMap<String, Object>list
			= new HashMap<String, Object>();
		
		 Connection conn = DBHelper.getConnection();
		 
		 String sql = "SELECT id, pw, mail, name, birth, gender "
		 				+ "FROM customer "
		 				+ "WHERE id=?";
		 PreparedStatement stmt = conn.prepareStatement(sql);
		 stmt.setString(1, id);
		 ResultSet rs = stmt.executeQuery();
		 
		 while(rs.next()) {
			 list.put("id", rs.getString("id"));
			 list.put("pw", rs.getString("pw"));
			 list.put("mail", rs.getString("mail"));
			 list.put("name", rs.getString("name"));
			 list.put("birth", rs.getString("birth"));
			 list.put("gender", rs.getString("gender"));
		 }
			 
		return list;
	}
	
	//historypw테이블에 newPw를 추가해주기
	//호출 : pwHistory.jsp
	//parameter : pw
	//return : HashMap
	
	
	//쿼리 INSERT INTO pwhistory(id, pw, create_date) VALUES(?,? NOW());
	public static int historyPw(
			String id, String newPw) throws Exception{
		int row = 0;
		
		//연결먼저
		 Connection conn = DBHelper.getConnection();
		//쿼리작성
		 String sql ="INSERT INTO pwhistory(id, pw, create_date) "
		 				+ "VALUES(?, ?, NOW())";
		 PreparedStatement stmt = conn.prepareStatement(sql);
		 stmt.setString(1, id);
		 stmt.setString(2, newPw);
		 
		 row = stmt.executeUpdate();
		
		return row;
		
	}
	
	//historypw테이블의 pw를 customer테이블의 pw랑 바꿔주기
	//호출 : pwHistoryAction.jsp
	
	public static int changePw(String id) throws Exception{
		int row = 0;
		
		 Connection conn = DBHelper.getConnection();
		 //update쿼리=>새로운 pw를 위해서 서브쿼리 사용 생성일을 최신순으로
		 String sql ="UPDATE customer "
		 		+ "SET pw = "
		 		+ "(SELECT pw "
		 		+ "FROM pwhistory "
		 		+ "WHERE id=? "
		 		+ "ORDER BY create_date DESC LIMIT 1) "
		 		+ "WHERE id=?";
		 PreparedStatement stmt = conn.prepareStatement(sql);
		 stmt.setString(1, id);
		 stmt.setString(2, id);
		 row = stmt.executeUpdate();
		
		return row;
	}
}
