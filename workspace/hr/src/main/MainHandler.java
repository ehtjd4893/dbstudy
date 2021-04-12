package main;

import java.util.List;
import java.util.Scanner;

import dao.EmployeesDao;
import dto.EmployeesDto;

public class MainHandler {
	private EmployeesDao dao = EmployeesDao.getInstance();
	private Scanner sc = new Scanner(System.in);
	
	public void showOne() {
		System.out.print("검색할 ID 입력 >> ");
		int id = sc.nextInt();
		EmployeesDto dto = new EmployeesDto();
		dto.setEmployeeId(id);
		dto = dao.selectOne(dto);
		if(dto != null)
			System.out.println(dto);
		else
			System.out.println("존재하지 않는 사번입니다.");
	}
	
	public void showAll() {
		System.out.print("검색할 부서번호 >> ");
		int dept_id = sc.nextInt();
		List<EmployeesDto> emps = dao.selectEmployeesByDepartmentId(dept_id);
		for(EmployeesDto e : emps)
			System.out.println(e);
	}
}
