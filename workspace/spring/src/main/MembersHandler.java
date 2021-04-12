package main;

import java.util.List;
import java.util.Scanner;

import dao.MembersDao;
import dto.MembersDto;

// 비즈니스 로직(bussiness logic)
public class MembersHandler {
	private MembersDao dao = MembersDao.getInstance();
	private Scanner sc = new Scanner(System.in);
	
	// method 
	private void menu() {
		System.out.println("=====회원관리=====");
		System.out.println("0. 종료");
		System.out.println("1. 가입");
		System.out.println("2. 탈퇴");
		System.out.println("3. 수정");
		System.out.println("4. 아이디 찾기");
		System.out.println("5. 회원검색");
		System.out.println("6. 전체 회원검색");
		System.out.println("==================");
	}
	
	public void excute() {
		while(true) {
			menu();
			System.out.print("선택 >> ");
			switch(sc.nextInt()) {
			case 0: System.out.println("프로그램을 종료합니다."); return;
			case 1:	join(); break;
			case 2: leave(); break;
			case 3: modify(); break;
			case 4: findID(); break;
			case 5: inquiryMember(); break;
			case 6: inquiryAll(); break;
			default:
				System.out.println("잘못된 입력입니다.");		
			}
		}
	}

	private void inquiryAll() {
		List<MembersDto> members = dao.selectAll();
		
		System.out.println("전체 회원 수 : " + members.size() + "명");
		for(MembersDto dto : members)
			System.out.println(dto);
		
	}

	public void inquiryMember() {
		System.out.println("조회할 회원 id >> ");
		String mId = sc.next();
		MembersDto dto = dao.selectMembersDtoBymId(mId);
		if(dto != null)
			System.out.println(dto);
		else
			System.out.println(mId + "는 존재하지 않는 ID입니다.");
	}

	public void modify() {
		System.out.print("변경할 ID >> ");
		String mId = sc.next();
		System.out.print("변경할 이름 >> ");
		String mName = sc.next();
		System.out.print("변경할 e-mail >> ");
		String mEmail = sc.next();
		MembersDto dto = new MembersDto(0L, mId, mName, mEmail, null);
		int result = dao.updateMembers(dto);
		if(result > 0)
			System.out.println(mId + "님의 정보가 수정되었습니다.");
		else
			System.out.println(mId + "님의 정보수정에 실패했습니다.");
	}

	public void leave() {
		System.out.print("탈퇴할 ID >> ");
		String mId = sc.next();
		System.out.println("정말 탈퇴하시겠습니까? (Y/N)");
		String yn = sc.next();
		if(yn.equalsIgnoreCase("Y")) {
				
			int result = dao.deleteMembers(mId);
			if(result > 0)
				System.out.println(mId + "계정이 삭제되었습니다.");
			else
				System.out.println(mId + "계정 삭제 실패");
		}
		else {
			System.out.println("탈퇴를 중단합니다.");
		}
	}

	public void join() {
		String mId = null;
		String mEmail = null;
		do {
			System.out.print("신규 ID >> ");
			mId = sc.next();
			System.out.print("e-mail 입력 >> ");
			mEmail = sc.next();
			if(dao.doubleCheck(mId, mEmail))
				System.out.println("이미 존재하는 ID 또는 e-mail입니다. ");
			else
				break;
		}while(true);
		// 일치하는 mId 또는 mEmail이 이미 DB에 있으면 SELECT join() 메소드 종료
		System.out.print("사용자명 >> ");
		String mName = sc.next();
	
		MembersDto dto = new MembersDto();
		dto.setmId(mId);
		dto.setmEmail(mEmail);
		dto.setmName(mName);
		
		int result = dao.insertMembers(dto);
		if(result > 0)
			System.out.println(mId + "님 가입에 성공했습니다.");
		else
			System.out.println(mId + "님 가입에 실패했습니다.");
	}
	
	public void findID() {
		System.out.print("가입 이메일 >> ");
		String mEmail = sc.next();
		String mId = dao.findmIdBymEmail(mEmail);
		if(mId != null)
			System.out.println("회원님이 찾으시는 ID는 " + mId + " 입니다." );
		else
			System.out.println("일치하는 정보가 없습니다.");
	}
}
