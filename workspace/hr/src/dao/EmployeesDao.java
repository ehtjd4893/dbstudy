package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.EmployeesDto;

public class EmployeesDao {
	private Connection con = null;
	private PreparedStatement ps = null;
	private ResultSet rs = null;
	private String sql = null;
	private int result;
	private static EmployeesDao dao = new EmployeesDao();
	
	private EmployeesDao() {}
	public static EmployeesDao getInstance() {
		return dao;
	}
	public Connection getConnection() throws Exception {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		String url = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
		String user = "hr";
		String pw = "1111";
		return DriverManager.getConnection(url,user,pw);
	}
	public void close(Connection con, PreparedStatement ps, ResultSet rs) {
		try {
			if(rs != null) rs.close();
			if(ps != null) ps.close();
			if(con != null) con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public EmployeesDto selectOne(EmployeesDto dto) {
		EmployeesDto emp = null;
		try {
			con = getConnection();
			sql = "SELECT E.EMPLOYEE_ID AS 사번,"
					+ "E.FIRST_NAME,"
					+ "E.LAST_NAME,"
					+ "D.DEPARTMENT_NAME AS 부서명,"
					+ "E.SALARY AS 연봉,"
					+ "E.HIRE_DATE AS 입사일 "
					+ "FROM DEPARTMENTS D, EMPLOYEES E "
					+ "WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID "
					+ "AND E.EMPOYEE_ID = ?"
					+ "ORDER BY 사번";
			ps = con.prepareStatement(sql);
			ps.setInt(1, dto.getEmployeeId());
			rs = ps.executeQuery();
			if(rs.next()) {
				emp = new EmployeesDto();
				emp.setFirst_name(rs.getString("first_name"));
				emp.setLast_name(rs.getString("last_name"));
				emp.setDepartmentName(rs.getString("부서명"));
				emp.setSalary(rs.getDouble("연봉"));
				emp.setHireDate(rs.getDate("입사일"));
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		close(con,ps,rs);
		return emp;
	}
	
	public List<EmployeesDto> selectEmployeesByDepartmentId(int departmentId){
		List<EmployeesDto> emps = new ArrayList<EmployeesDto>();
		try {
			con = getConnection();
			sql = "SELECT E.EMPLOYEE_ID AS 사번,"
					+ "E.FIRST_NAME,"
					+ "E.LAST_NAME,"
					+ "D.DEPARTMENT_NAME AS 부서명,"
					+ "E.SALARY AS 연봉,"
					+ "E.HIRE_DATE AS 입사일 "
					+ "FROM DEPARTMENTS D, EMPLOYEES E "
					+ "WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID "
					+ "ORDER BY 사번";
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				EmployeesDto dto = new EmployeesDto();
				dto.setFirst_name(rs.getString("first_name"));
				dto.setLast_name(rs.getString("last_name"));
				dto.setDepartmentName(rs.getString("부서명"));
				dto.setSalary(rs.getDouble("연봉"));
				dto.setHireDate(rs.getDate("입사일"));
				emps.add(dto);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		close(con,ps,rs);
		
		
		return emps;
	}
}
