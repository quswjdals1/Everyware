package kr.or.everyware.vo;

import java.util.Date;

import lombok.Data;

@Data
public class Schedule {
	private int schdlId;
	private String schdlTtl;
	private String schdlType;
	private String schdlCn;
	private Date schdlBgngDt;
	private Date schdlEndDt;
	private String empId;
	private String schdlColor;
	private String schdlAllday;
}
