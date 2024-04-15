package shop.dao;

import java.io.FileReader;
import java.sql.*;
import java.util.Properties;

public class DBHelper { //DBHELPER의 getConnection 호출
		public static java.sql.Connection getConnection() throws Exception {
			//DB로 접근
			   Class.forName("org.mariadb.jdbc.Driver");
			   
			   //로컬 PC의 properties파일 읽어오기
			   //FileReader은 외부파일을 가져올때 사용한다inputStream이다.
			   FileReader fr = new FileReader("c:\\auth\\mariadb.properties");
			   Properties prop = new Properties();
			   prop.load(fr);
			  // System.out.println(prop.getProperty("id"));
			   //System.out.println(prop.getProperty("pw"));
			   String id = prop.getProperty("id");
			   String pw = prop.getProperty("pw");
			
			   Connection conn = DriverManager.getConnection(
			   		"jdbc:mariadb://127.0.0.1:3306/shop", id, pw);
			   return conn;
		}
		
		public static void main(String[] args) throws Exception{
			DBHelper.getConnection();
		}
}
