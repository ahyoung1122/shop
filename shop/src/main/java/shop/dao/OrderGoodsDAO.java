package shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.sql.*;
import java.util.*;

public class OrderGoodsDAO {	
	//cart테이블에 상품데이터 추가하기
	//호출 : customerGoodsAction.jsp
	public static int addCart(String id, String goodsTitle, int goodsNo, int goodsPrice, 
			String filename, int amount) throws Exception{
		int row = 0;
		
			Connection conn = DBHelper.getConnection(); 
			
			String sql = "INSERT INTO cart(id,goods_title, goods_no, goods_price,filename,amount)"
					+ "VALUES(?,?,?,?,?,?)";
			PreparedStatement stmt = conn.prepareStatement(sql);
				stmt.setString(1, id);
				stmt.setString(2, goodsTitle);
				stmt.setInt(3, goodsNo);
				stmt.setInt(4, goodsPrice);
				stmt.setString(5, filename);
				stmt.setInt(6, amount);
			
			row = stmt.executeUpdate();
			
			conn.close();
			return row;
	}
	//주문하려는 상품 cart테이블의 데이터 가져오기
	//호출 : orderListByCustomer.jsp
	//param : String, int
	//return : list<ArrayList<HashMap<...
	
	public static ArrayList<HashMap<String,Object>>cartList1(String id) throws Exception{
		ArrayList<HashMap<String,Object>>list
			= new ArrayList<HashMap<String,Object>>();
		
		Connection conn = DBHelper.getConnection(); 
		
		String sql ="SELECT cart_no cartNo, id, goods_title goodsTitle, goods_no goodsNo, goods_price goodsPrice,"
				+ "filename,amount FROM cart WHERE id=?"; //주문에서는 id가 무엇이냐 기준으로
		PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, id);
		ResultSet rs = stmt.executeQuery();
			 while(rs.next()) 
			 	{
					HashMap<String,Object> m =
							 new HashMap<String,Object>();
					 	m.put("cartNo", rs.getInt("cartNo"));
				        m.put("id", rs.getString("id"));
				        m.put("goodsTitle", rs.getString("goodsTitle"));
				        m.put("goodsNo", rs.getInt("goodsNo"));
				        m.put("goodsPrice", rs.getInt("goodsPrice"));
				        m.put("filename", rs.getString("filename"));
				        m.put("amount", rs.getInt("amount"));
				        list.add(m);
			 	}
		conn.close();
		return list;
	}
	//customer테이블에서 이름이랑 mail값만 선택하기
	/* SELECT mail, NAME FROM customer; */
	//호출 :  orderGoods.jsp 
	//param : id
	//return : HashMap<String, String>
	
	public static HashMap<String, String>customerInfo(
			String id) throws Exception{
		HashMap<String, String>info =
				new HashMap<String,String>();
			//연결해주기
			Connection conn = DBHelper.getConnection(); 
			//customer정보가져오는 쿼리 
			String sql="SELECT id, mail, name FROM customer "
					+ "WHERE id=?";
			PreparedStatement stmt = conn.prepareStatement(sql);
				stmt.setString(1, id);
			ResultSet rs = stmt.executeQuery();
				if(rs.next()) 
					{
						info.put("id", rs.getString("id"));
						info.put("mail", rs.getString("mail"));
				        info.put("name", rs.getString("name"));
					}
			
		conn.close();
		return info;
	}
	//구매하려는 상품 보여주는 쿼리
	//호출 : orderGood.jsp
	//param : id
	//return : ArrayList<HashMap<...
	
	public static ArrayList<HashMap<String,Object>> cartGoods(
				String id) throws Exception{
		
			ArrayList<HashMap<String, Object>> list
				=	new ArrayList<HashMap<String,Object>>();
			
			Connection conn = DBHelper.getConnection(); 
			
			//쿼리 추가
			String sql="SELECT id,goods_title goodsTitle, goods_price goodsPrice, filename, amount "
					+ "FROM cart "
					+ "WHERE id=?";
			
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, id);
			ResultSet rs = stmt.executeQuery();
			
			while(rs.next()) {
				HashMap<String,Object> m 
					= new HashMap<String,Object>();
				
				m.put("id", rs.getString("id"));
				m.put("goodsTitle", rs.getString("goodsTitle"));
				m.put("goodsPrice", rs.getInt("goodsPrice"));
				m.put("filename", rs.getString("filename"));
				m.put("amount", rs.getInt("amount"));
				list.add(m);
			}
			
			conn.close();
			return list;
	}

	//바로 주문하기 기능을 위한 메서드 만들기
	//호출 : customerGoodsBuyAction.jsp
	//param : String, goods
	//return : int

	public static int addOrders(
			String id, String goodsTitle, int goodsNo, int goodsPrice,
				String filename, int amount, int totalPrice) throws Exception{
				int row = 0;
				
				//연결
				Connection conn = DBHelper.getConnection(); 
				//insert쿼리만들기
				String sql ="INSERT INTO orders(id, goods_title, goods_no,"
						+ " goods_price, filename,amount, total_price, create_date) "
						+ "VALUES(?,?,?,?,?,?,?,NOW()) ";
				
				PreparedStatement stmt = conn.prepareStatement(sql);
					stmt.setString(1, id);
					stmt.setString(2, goodsTitle);
					stmt.setInt(3, goodsNo);
					stmt.setInt(4, goodsPrice);
					stmt.setString(5, filename);
					stmt.setInt(6, amount);
					stmt.setInt(7, totalPrice);
				row = stmt.executeUpdate();
				
				conn.close();
				return row;
	}
	
	//주문하려는 상품 orders테이블에서 가져오기(+totalPrice구하는김에)
	//호출1.customerGoodsBuyAction.jsp
	//호출2.customerPage.jsp//주문확인기능때문
	//param : id
	//return : ArrayList.HashMap
	
	public static ArrayList<HashMap<String,Object>>ordersList1(
			String id)throws Exception{
		ArrayList<HashMap<String, Object>> list
			= new ArrayList<HashMap<String,Object>>();
		
			//연결
			Connection conn = DBHelper.getConnection(); 
			//select쿼리
			
			String sql ="SELECT orders_no ordersNo, id, goods_title goodsTitle, "
							+ "goods_no goodsNo, goods_price goodsPrice, "
							+ "filename, amount, state, total_price totalPrice, create_date createDate "
						+ "FROM orders "
						+ "WHERE id=?";
			PreparedStatement stmt = conn.prepareStatement(sql);
				stmt.setString(1, id);
				
			ResultSet rs = stmt.executeQuery();
			
			 while(rs.next()) 
			 	{
				 	HashMap<String,Object> m = 
				 			new HashMap<String,Object>();
					 	m.put("ordersNo", rs.getInt("ordersNo"));
				        m.put("id", rs.getString("id"));
				        m.put("goodsTitle", rs.getString("goodsTitle"));
				        m.put("goodsNo", rs.getInt("goodsNo"));
				        m.put("goodsPrice", rs.getInt("goodsPrice"));
				        m.put("filename", rs.getString("filename"));
				        m.put("amount", rs.getInt("amount"));
				        m.put("state", rs.getString("state"));
				        m.put("totalPrice", rs.getInt("totalPrice"));
				        m.put("createDate", rs.getString("createDate"));
				        
				        list.add(m);
			 	}
				
			 conn.close();
			 return list;
	}
	
	

}
