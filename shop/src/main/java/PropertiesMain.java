import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.Properties;

public class PropertiesMain {
	public static void main(String[] args) {
		FileReader fr = null;
		try {
			fr = new FileReader("C:\\temp\\info.properties");
			Properties prop = new Properties();			
			prop.load(fr); 
			System.out.println(prop.getProperty("name")); 
			System.out.println(prop.getProperty("url")); 
			
		} catch(Exception e) {
			System.out.println("실패");
		} finally {
			try {
				fr.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
}