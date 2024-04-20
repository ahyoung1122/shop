package shop.dao;

import java.sql.Connection;
import java.util.HashMap;
import java.util.ArrayList;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class EmpCategoryDAO {
	
	// 카테고리 불러오기
	// 호출 : categoryList.jsp
	//param : void
	//return : ArrayList<HashMap...
	
	public static ArrayList<HashMap<String,Object>> categoryList1() 
			throws Exception{
		ArrayList<HashMap<String,Object>> list
		= new ArrayList<HashMap<String,Object>>();
		
		//1연결
		Connection conn = DBHelper.getConnection(); 
		//2쿼리
		String sql = "SELECT category FROM category";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next())
		{
			HashMap<String,Object> m  = new HashMap<String,Object>();
				 m.put("category", rs.getString("category"));
				 list.add(m);
		}
		
		return list;
	}
	 
	
	// 카테고리 추가액션
	// 호출 : categoryList.jsp
	// param : category
	// return : int
	
	public static int categoryList(String category) throws Exception{
		int row = 0;
		//1연결
		Connection conn = DBHelper.getConnection(); 
		//2쿼리
		String sql = "INSERT INTO category(category) VALUES(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, category);
		System.out.println(stmt+"<<==stmt");
		
		row = stmt.executeUpdate();
		if(row==1 )
			{
				System.out.println("변경");
			}  
		else 
			{
				System.out.println("변경실패");
			}
		
		return row;
	}

}
