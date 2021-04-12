package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import dto.MembersDto;

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
	
	// 가입(Dao로 전달된 데이터를 DB에 INSERT)
	// (부가기능: 같은 아이디, 같은 이메일은 가입 방지)
	public int insertMembers(MembersDto dto) {	// dto(mID,mName, mEmail) 저장
		try {
			result = 0;
			con = getConnection();
			sql = "INSERT INTO members(MNO, MID, MNAME, MEMAIL, MDATE) " + 
				  "VALUES(MEMBERS_SEQ.NEXTVAL,?,?,?,SYSDATE)";
			ps = con.prepareStatement(sql);
			ps.setString(1, dto.getmId());
			ps.setString(2, dto.getmName());
			ps.setString(3, dto.getmEmail());
			
			result = ps.executeUpdate();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		close(con,ps,null);
		
		return result;
	}
	// 탈퇴
	public int deleteMembers(String mId) {
		result = 0;
		try {
			con = getConnection();
			sql = "DELETE FROM MEMBERS WHERE MID = ?";
			ps = con.prepareStatement(sql);
			ps.setString(1, mId);
			result = ps.executeUpdate();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		close(con,ps,null);
		return result;
	}
	// 회원정보수정
	public int updateMembers(MembersDto dto) {
		result = 0;
		try {
			con = getConnection();
			sql = "UPDATE MEMBERS SET MNAME = ?, MEMAIL = ? WHERE MID = ?";
			ps = con.prepareStatement(sql);
			ps.setString(1,dto.getmName());
			ps.setString(2,dto.getmEmail());
			ps.setString(3,dto.getmId());
			result = ps.executeUpdate();

		} catch(Exception e) {
			e.printStackTrace();
		}
		close(con,ps,null);
		return result;
	}

	// 아이디찾기
	public String findmIdBymEmail(String mEmail) {
		String findmId = null;
		try {
			con = getConnection();
			sql = "SELECT mId FROM MEMBERS WHERE mEmail = ?";
			ps = con.prepareStatement(sql);
			ps.setString(1,mEmail);
			rs = ps.executeQuery();
			if(rs.next()) 
				findmId = rs.getString(1);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		close(con,ps,rs);
		return findmId;
	}
	
	public boolean doubleCheck(String mId, String mEmail) {
		boolean isDuplicate = false;
		try {
			con = getConnection();
			sql = "SELECT mEmail FROM members WHERE mEmail = ? OR mId = ?";
			ps = con.prepareStatement(sql);
			ps.setString(1, mEmail);
			ps.setString(2, mId);
			rs = ps.executeQuery();
			if(rs.next())
				isDuplicate = true;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		close(con,ps,rs);
		return isDuplicate;
	}
	
	// 회원번호에 의한 검색
	public MembersDto selectMembersDtoBymId(String mId) {
		MembersDto dto = null;
		try {
			con = getConnection();
			sql = "SELECT MNO,MID,MNAME,MEMAIL,MDATE FROM MEMBERS WHERE MID = ?";
			ps = con.prepareStatement(sql);
			ps.setString(1, mId);
			rs = ps.executeQuery();
			if(rs.next())
				dto = new MembersDto(rs.getLong(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getDate(5));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		close(con,ps,rs);
		return dto;
	}
	
	// 전체 검색
	public List<MembersDto> selectAll(){
		List<MembersDto> members = new ArrayList<MembersDto>();
		try {
			con = getConnection();
			sql = "SELECT MNO,MID,MNAME,MEMAIL,MDATE FROM MEMBERS";
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) 
				members.add(new MembersDto(rs.getLong(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getDate(5)));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		close(con,ps,rs);
		return members;
	}
	
	
}
