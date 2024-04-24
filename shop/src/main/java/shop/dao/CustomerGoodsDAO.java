package shop.dao;
import java.util.HashMap;

import javax.naming.spi.DirStateFactory.Result;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class CustomerGoodsDAO {
	//호출 : customerGoodsList.jsp
	//param : void
	//return : HashMap<string,Object>
	
	public static ArrayList<HashMap<String, Object>> categoryList1()
			throws Exception{
		ArrayList<HashMap<String, Object>> categoryList2
			= new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection(); 
		
		String sql = "select goods_no goodsNo, category, count(*) cnt "
				+ "from goods "
				+ "group by category "
				+ "order by category desc";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next())
			{//우선 goodsNo, category만 나열
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("goodsNo", rs.getInt("goodsNo"));
			m.put("category", rs.getString("category"));
			m.put("cnt", rs.getInt("cnt"));
			categoryList2.add(m);	
			}
		return categoryList2;
	}
	
	//category = ? 카테고리 클릭하면 카테고리별로 나열
	//customerGoodsList.jsp
	//parameter : category,startRow, rowPerpage
	//return : HashMap
	
	public static ArrayList<HashMap<String,Object>>goodsList1(String category, int startRow, int rowPerPage) 
			throws Exception{
		ArrayList<HashMap<String,Object>> goodsList2 =
				new ArrayList<HashMap<String,Object>>();
		
		Connection conn = DBHelper.getConnection(); 
		String sql = "SELECT category,goods_no goodsNo, goods_title goodsTitle, filename, goods_price goodsPrice, create_date createDate "
				+ "FROM goods "
				+ "WHERE category = ? "
				+ "order by create_date desc LIMIT ?,?; ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, category);
		stmt.setInt(2, startRow);
		stmt.setInt(3, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next())
			{
			HashMap<String, Object> m2 = new HashMap<String, Object>();
			m2.put("category", rs.getString("category"));
			m2.put("goodsNo", rs.getInt("goodsNo"));
			m2.put("goodsTitle", rs.getString("goodsTitle"));
			m2.put("filename", rs.getString("filename"));
			m2.put("goodsPrice", rs.getString("goodsPrice"));
			m2.put("goodsPrice", rs.getInt("goodsPrice"));
			m2.put("createDate", rs.getString("createDate"));
			
			goodsList2.add(m2);
			}	
		return goodsList2;

	}
	
	//전체page를 위한 쿼리
	//호출 : customerGoodsList.jsp
	//param : startRow, rowPerpage
	//return : Arrayist<HashMap>
	
	public static ArrayList<HashMap<String,Object>> allGoodsList1(
			int startRow, int rowPerPage) throws Exception{
		ArrayList<HashMap<String,Object>> allGoodsList2
			= new ArrayList<HashMap<String,Object>>();
		
		Connection conn = DBHelper.getConnection(); 
		String sql3 = "SELECT category, goods_no goodsNo, goods_title goodsTitle, filename, goods_price goodsPrice, create_date createDate "
				+ "FROM goods "
				+ "ORDER BY goods_no desc LIMIT ?,?;";
		PreparedStatement stmt = conn.prepareStatement(sql3);
		stmt.setInt(1, startRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()){
			HashMap<String,Object> m3 = new HashMap<String,Object>();
			m3.put("category", rs.getString("category"));
			m3.put("goodsNo", rs.getInt("goodsNo"));
			m3.put("goodsTitle", rs.getString("goodsTitle"));
			m3.put("filename", rs.getString("filename"));
			m3.put("goodsPrice", rs.getInt("goodsPrice"));
			m3.put("createDate", rs.getString("createDate"));
			allGoodsList2.add(m3);
		}
		
		return allGoodsList2;
	}
	
	//전체페이지의 버튼을 위해 qeury추가
	//호출 : customerGoodsList.jsp
	//param : void
	//return : String
	
	public static int totalBtn1() throws Exception{
		int row = 0;
		//연결
		Connection conn = DBHelper.getConnection(); 
		//쿼리작성
		String sql = "select count(*)cnt from goods";
		//전체 goods 테이블의 행 수를
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		//전체 행 수를 반환함
		if(rs.next()){
			row = rs.getInt("cnt");
		}
		return row;
	}
	//고객상품 상세보기 페이지 연결
	//호출 : customerGoodsOne
	//param : goodsNo
	//return : HashMap
	
		public static HashMap<String,Object>goodsOne(int goodsNo) 
				throws Exception{
			
			HashMap<String,Object> one =
					new HashMap<String,Object>();
			
			Connection conn = DBHelper.getConnection(); 
			
			String sql = "SELECT * from goods WHERE goods_no = ? ";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, goodsNo);
			ResultSet rs = stmt.executeQuery();
			
			//customerGoodsOne으로 넘겨줄 값을 추가해야한다.
			if(rs.next()) {
			one.put("goodsNo", rs.getInt("goods_no"));
			one.put("goodsTitle", rs.getString("goods_title"));
			one.put("filename", rs.getString("filename"));
			one.put("goodsPrice", rs.getInt("goods_price"));
			one.put("goodsContent", rs.getString("goods_content"));
			}
			
			if(rs.next()){
				System.out.println("성공");
		
			}else{
				System.out.println("실패");
			}
			
			return one;
		}
		
		//상품 수량 변경하기
		//호출  : customerGoodsAction.jsp
		//param : amount, goodsNo
		//return : int
		public static int goodsAmount(
				int goodsNo, int amount)throws Exception{
			int row = 0;
			
			Connection conn = DBHelper.getConnection(); 
			
			String sql = "UPDATE goods SET goods_amount = goods_amount - ?,  "
					+ "update_date = now() WHERE goods_no = ? AND goods_amount > ?";
			PreparedStatement stmt = null;
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, amount);
			stmt.setInt(2, goodsNo);
			stmt.setInt(3, goodsNo - 1);
			System.out.println(stmt);

			row = stmt.executeUpdate();
			
			return row;
		}

	
}