package com.memberinfo.model;

import java.sql.Date;
import java.util.Set;

import com.membercars.model.MemberCarsVO;

public class MemberInfoVO {
	Integer memberNo;
	String email;
	String password;
	String memberName;
	String phone;
	Date birthday;
	String address;
	Date effectiveDate;
	Set<MemberCarsVO> memberCars;
	
	public Integer getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(Integer memberNo) {
		this.memberNo = memberNo;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public Date getBirthday() {
		return birthday;
	}
	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Date getEffectiveDate() {
		return effectiveDate;
	}
	public void setEffectiveDate(Date effectiveDate) {
		this.effectiveDate = effectiveDate;
	}
	public Set<MemberCarsVO> getMemberCars() {
		return memberCars;
	}
	public void setMemberCars(Set<MemberCarsVO> memberCars) {
		this.memberCars = memberCars;
	}
	

}
