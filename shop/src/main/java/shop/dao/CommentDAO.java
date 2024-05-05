package shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

public class CommentDAO {
	//comment에 추가
	//호출 : myCommentOneAction.jsp
	//param : 
	
	
	//쿼리 
	//INSERT INTO comment(orders_no, star_point, content) 
	//VALUES('93', 3.5, '너무맘에들어요!');


	
	public static int addComment(
			int ordersNo, String starPoint,String content) throws Exception{
		int row = 0;
		
		Connection conn = DBHelper.getConnection(); 
		String sql ="INSERT INTO comment(orders_no, star_point, content,update_date, create_date) "
					+ "VALUES(?,?,?,NOW(),NOW())";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, ordersNo);
			stmt.setString(2, starPoint);
			stmt.setString(3, content);
		
		row = stmt.executeUpdate();
		
		return row;
		
	}
	
	//코멘트 테이블 가져오기
	//호출 : myComment.jsp
	public static ArrayList<HashMap<String, Object>>commentList1(String id) throws Exception{
		ArrayList<HashMap<String,Object>> list
			= new ArrayList<HashMap<String,Object>>();
		
		Connection conn = DBHelper.getConnection(); 
		
		//select sql가져오기
		String sql ="SELECT o.orders_no ordersNo, o.state state, c.content content, o.goods_title,"
				+ " c.star_point starPoint,o.filename filename, update_date updateDate "
				+ "FROM orders o "
				+ "INNER JOIN comment c "
				+ "ON o.orders_no = c.orders_no "
				+ "WHERE o.id=? order by update_date desc";
		PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, id);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String,Object> m
				= new HashMap<String,Object>();
			
			m.put("ordersNo", rs.getInt("ordersNo"));
			m.put("state", rs.getString("state"));
			m.put("content", rs.getString("content"));
			m.put("starPoint", rs.getDouble("starPoint"));
			m.put("updateDate", rs.getString("updateDate"));
			m.put("filename", rs.getString("filename"));
				list.add(m);
			
		}
		
		return list;
	}
	
	//전체고객후기 가져오기
	//호출 : allCommentList.jsp
	/*
	 * 쿼리:SELECT o.id,o.goods_title,c.star_point,c.content, c.create_date FROM
	 * comment c INNER JOIN orders o ON c.orders_no = o.orders_no ORDER BY
	 * c.create_date DESC;
	 */
	
	public static ArrayList<HashMap<String,Object>> comment() throws Exception{
		ArrayList<HashMap<String,Object>> list
			= new ArrayList<HashMap<String,Object>>();
		
		Connection conn = DBHelper.getConnection(); 
		
		String sql = "SELECT o.id id, o.goods_title goodsTitle,"
				+ " c.star_point starPoint, c.content content, c.create_date createDate "
				+ "FROM orders o "
				+ "INNER JOIN comment c "
				+ "ON c.orders_no = o.orders_no "
				+ "ORDER BY c.create_date DESC";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String,Object> m 
				=	new HashMap<String,Object>();
			m.put("id", rs.getString("id"));
			m.put("goodsTitle", rs.getString("goodsTitle"));
			m.put("starPoint", rs.getDouble("starPoint"));
			m.put("content", rs.getString("content"));
			m.put("createDate", rs.getString("createDate"));
			
			list.add(m);
			
		}
		
		return list;
	}
}	