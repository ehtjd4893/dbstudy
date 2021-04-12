package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MembersDao {
	private Connection con;
	private PreparedStatement ps;
	private ResultSet rs;
	private String sql;
	private int result;
	
	// singleton 패턴
	private static MembersDao dao = new MembersDao();
	private MembersDao() {}
	public static MembersDao getInstance() {
		return dao;
	}	
	// MembersDao dao = MembersDao.getInstance(); 형식으로 호출
	
	private Connection getConnection() throws Exception{	
		//getConnection() 메소드를 호출하는 곳으로						
		// 예외를 던져버리자.
			Class.forName("oracle.jdbc.driver.OracleDriver");
			String url = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
			String user = "spring";
			String pw = "1111";
			return DriverManager.getConnection(url, user, pw);			
	}
	
	private void close(Connection con, PreparedStatement ps, ResultSet rs) {
		try {
			if(rs != null) rs.close();
			if(ps != null) ps.close();
			if(con != null) con.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	// 가입
	
	// 탈퇴
	
	// 회원정보수정
	
	// 아이디찾기
	
	// 회원번호에 의한 검색
	
	// 전체 검색
	
	
}
