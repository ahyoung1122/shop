package shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.sql.*;
import java.util.*;

public class OrderGoodsDAO {
		//값을 가지고 주문페이지로 넘어가기
	public static int addOrder(String id, String goodsTitle, int goodsNo, int goodsPrice, 
			String filename, int amount) throws Exception{
		int row = 0;
		
		Connection conn = DBHelper.getConnection(); 
		
		String sql = "INSERT INTO orders(id,goods_title, goods_no, goods_price,filename,amount,create_date)"
				+ "values(?,?,?,?,?,?,NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		stmt.setString(2, goodsTitle);
		stmt.setInt(3, goodsNo);
		stmt.setInt(4, goodsPrice);
		stmt.setString(5, filename);
		stmt.setInt(6, amount);
		
		System.out.println(id + "<===OrderGoodsDAO.id");
		System.out.println(goodsTitle + "<===orderGoodsDAO.goodsTitle");
		System.out.println(goodsNo + "<===OrderGoodsDAO.goodsNo");
		System.out.println(goodsPrice + "<===OrderGoodsDAO.goodsPrice");
		System.out.println(filename + "<===OrderGoodsDAO.filename");
		System.out.println(amount + "<===OrderGoodsDAO.amount");
		
		row = stmt.executeUpdate();
		
		return row;
	}
		//주문하려는 상품 orders테이블의 데이터 가져오기
		//호출 : orderListByCustomer.jsp
		//param : String, int
		//return : list<ArrayList<HashMap<...
	
	public static ArrayList<HashMap<String,Object>>orderList1(String id) throws Exception{
		ArrayList<HashMap<String,Object>>list
			= new ArrayList<HashMap<String,Object>>();
		
		Connection conn = DBHelper.getConnection(); 
		
		String sql ="SELECT orders_no ordersNo, id, goods_title goodsTitle, goods_no goodsNo, goods_price goodsPrice,"
				+ "filename,amount FROM orders WHERE id=?"; //주문에서는 id가 무엇이냐 기준으로
		PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, id);
		ResultSet rs = stmt.executeQuery();
		 while(rs.next()) {
			HashMap<String,Object> m =
					 new HashMap<String,Object>();
			 	m.put("ordersNo", rs.getInt("ordersNo"));
		        m.put("id", rs.getString("id"));
		        m.put("goodsTitle", rs.getString("goodsTitle"));
		        m.put("goodsNo", rs.getInt("goodsNo"));
		        m.put("goodsPrice", rs.getInt("goodsPrice"));
		        m.put("filename", rs.getString("filename"));
		        m.put("amount", rs.getInt("amount"));
		        list.add(m);
		 }
		return list;
	}
}
