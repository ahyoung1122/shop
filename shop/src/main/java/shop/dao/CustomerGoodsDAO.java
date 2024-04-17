package shop.dao;
import java.util.HashMap;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class CustomerGoodsDAO {
	public static ArrayList<HashMap<String, Object>>allCategory() throws Exception{
		ArrayList<HashMap<String, Object>>
		 listCategory = new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT goods_no goodsNo, category," +
				  "count(*) cnt from goods GROUP BY category O category desc";
				  
			PreparedStatement stmt = conn.prepareStatement(sql); 
			ResultSet rs = stmt.executeQuery();
			while(rs.next()){//우선 goodsNo, category만 나열 HashMap<String, Object> m = new
				HashMap<String, Object> m 
				= new HashMap<String, Object>(); 
					  m.put("goodsNo", rs.getInt("goodsNo"));
					  m.put("category", rs.getString("category"));
					  m.put("cnt", rs.getInt("cnt"));
					  listCategory.add(m); }
			
		return listCategory;
	}
	//카테고리 선택별로 만들기 category=? 
	//호출 : customerGoodsList.jsp 
	//param : Stringcategory, int startRow, int rowPerPage 
	//return : HashMap<String, Object>();
	
	public static ArrayList<HashMap<String,Object>>selectCategory(
			String category, int startRow, int rowPerPage) 
			throws Exception{
		ArrayList<HashMap<String, Object>> goodsList 
		= new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT category,goods_no goodsNo, goods_title goodsTitle, filename, goods_price goodsPrice, create_date createDate "
				+ "FROM goods WHERE category=? "
				+ "order by create_date desc LIMIT ?,?; ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, category);
		stmt.setInt(2, startRow);
		stmt.setInt(3, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()){
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("category", rs.getString("category"));
			m.put("goodsNo", rs.getInt("goodsNo"));
			m.put("goodsTitle", rs.getString("goodsTitle"));
			m.put("filename", rs.getString("filename"));
			m.put("goodsPrice", rs.getInt("goodsPrice"));
			m.put("createDate", rs.getString("createDate"));
			
			goodsList.add(m);
			
		}
		
		return goodsList;
	}
	
}
