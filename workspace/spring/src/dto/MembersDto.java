package dto;

import java.sql.Date;

public class MembersDto {
	private long mNo;
	private String mId;
	private String mName;
	private String mEmail;
	private Date mDate;
	// constructor
	// 1. 안 만든다.(default만 사용)
	// 2. 2개 만든다(default, field 사용)
	public MembersDto() {}

	public MembersDto(long mNo, String mId, String mName, String mEmail, Date mDate ) {
		this.mNo = mNo;
		this.mId = mId;
		this.mName = mName;
		this.mEmail = mEmail;
		this.mDate = mDate;
	}

	public long getmNo() {
		return mNo;
	}

	public void setmNo(long mNo) {
		this.mNo = mNo;
	}

	public String getmId() {
		return mId;
	}

	public void setmId(String mId) {
		this.mId = mId;
	}

	public String getmName() {
		return mName;
	}

	public void setmName(String mName) {
		this.mName = mName;
	}

	public Date getmDate() {
		return mDate;
	}

	public void setmDate(Date mDate) {
		this.mDate = mDate;
	}
	
	public String getmEmail() {
		return mEmail;
	}

	public void setmEmail(String mEmail) {
		this.mEmail = mEmail;
	}

	@Override
	public String toString() {
		return "MembersDto [mNo=" + mNo + ", mId=" + mId + ", mName=" + mName + ", mEmail=" + mEmail + ", mDate="
				+ mDate + "]";
	}
	




	
	
}
