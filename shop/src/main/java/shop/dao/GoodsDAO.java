package shop.dao;

import java.sql.*;
import java.util.*;

public class GoodsDAO {//카테고리들 리스트
	public static ArrayList<HashMap<String, Object>> category() throws Exception {
		ArrayList<HashMap<String, Object>> categoryList =
				new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection();
		String sql1 = "select goods_no goodsNo, category, count(*) cnt "
				+ "from goods group by category "
				+ "order by category asc";
		PreparedStatement stmt1 = conn.prepareStatement(sql1);
		ResultSet rs1 = stmt1.executeQuery();
		while(rs1.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("goodsNo", rs1.getInt("goodsNo"));
			m.put("category", rs1.getString("category"));
			m.put("cnt", rs1.getInt("cnt"));
			categoryList.add(m);
		}
		
		conn.close();
		
		return categoryList;
	}
	//카테고리 선택하면 카테고리별 상품 나열
	public static ArrayList<HashMap<String, Object>> checkGoodsList(String category, int startRow, int rowPerPage) throws Exception{
		ArrayList<HashMap<String, Object>> selectGoodsList = 
				new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection();
		String sql2 = "SELECT category,goods_no goodsNo, goods_title goodsTitle, filename, goods_price goodsPrice, create_date createDate "
				+ "FROM goods WHERE category=? order by create_date desc LIMIT ?,?;";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1, category);
		stmt2.setInt(2, startRow);
		stmt2.setInt(3, rowPerPage);
		ResultSet rs2 = stmt2.executeQuery();
		while(rs2.next()) {
			HashMap<String, Object> m2 = new HashMap<String, Object>();
			m2.put("category", rs2.getString("category"));
			m2.put("goodsNo", rs2.getInt("goodsNo"));
			m2.put("goodsTitle", rs2.getString("goodsTitle"));
			m2.put("filename", rs2.getString("filename"));
			m2.put("goodsPrice", rs2.getInt("goodsPrice"));
			m2.put("createDate", rs2.getString("createDate"));
			selectGoodsList.add(m2);
		}
		conn.close();
		
		return selectGoodsList;
	}
	//'전체'버튼을 위해 모든 카테고리들의 데이터가 보일 수 있는 쿼리 작성
		public static ArrayList<HashMap<String, Object>> allGoodsList2(int startRow, int rowPerPage)throws Exception{
			ArrayList<HashMap<String, Object>> goodsList = 
					new ArrayList<HashMap<String, Object>>();

			Connection conn = DBHelper.getConnection();
			
			String sqlAll ="SELECT category, goods_no goodsNo, goods_title goodsTitle, filename, goods_price goodsPrice, create_date createDate "
					+ "FROM goods ORDER BY goods_no desc LIMIT ?,?;";
			PreparedStatement stmt3 = conn.prepareStatement(sqlAll);	
			stmt3.setInt(1, startRow);
			stmt3.setInt(2, rowPerPage);
			ResultSet rs3 = stmt3.executeQuery(); 
			while(rs3.next()) 
				{
				HashMap<String, Object> m3 = new HashMap<String, Object>();
				m3.put("category", rs3.getString("category"));
				m3.put("goodsNo", rs3.getInt("goodsNo"));
				m3.put("goodsTitle", rs3.getString("goodsTitle"));
				m3.put("filename", rs3.getString("filename"));
				m3.put("goodsPrice", rs3.getInt("goodsPrice"));
				m3.put("createDate", rs3.getString("createDate"));
				goodsList.add(m3);
				}
			conn.close();
			return goodsList;
		}
		//uploadFile
		/*
		 * public static int upladFile(String category, String_id, String goods_title,
		 * filename, )
		 * 
		 * Connection conn = DBHelper.getConnection();
		 * 
		 * String sql3 =
		 * "insert into goods(category, emp_id, goods_title, filename, goods_content, goods_price, goods_amount, update_date, create_date) values(?,'admin',?,?,?,?,?, now(), now())"
		 * ; stmt = conn.prepareStatement(sql);
		 */
}