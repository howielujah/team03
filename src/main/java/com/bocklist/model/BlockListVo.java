package com.bocklist.model;

public class BlockListVo {
	private Integer mamberNo;
	private Short blockRuleNo;
	private String violationDate;
	private Integer reservationNo;
	private String blockState;
	public Integer getMamberNo() {
		return mamberNo;
	}
	public void setMamberNo(Integer mamberNo) {
		this.mamberNo = mamberNo;
	}
	public Short getBlockRuleNo() {
		return blockRuleNo;
	}
	public void setBlockRuleNo(Short blockRuleNo) {
		this.blockRuleNo = blockRuleNo;
	}
	public String getViolationDate() {
		return violationDate;
	}
	public void setViolationDate(String violationDate) {
		this.violationDate = violationDate;
	}
	public Integer getReservationNo() {
		return reservationNo;
	}
	public void setReservationNo(Integer reservationNo) {
		this.reservationNo = reservationNo;
	}
	public String getBlockState() {
		return blockState;
	}
	public void setBlockState(String blockState) {
		this.blockState = blockState;
	}
	
}
