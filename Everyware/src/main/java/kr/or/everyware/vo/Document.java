package kr.or.everyware.vo;

import java.util.Date;

import lombok.Data;

@Data
public class Document {
	private int docSn;
	private String docNo;
	private int docCd;
	private String custId;
	private String empId;
	private Date atrzDmndDt;
	private Date atrzCmptnDt;
	private String docTtl;
	private String docCn;
	private String docStts;
	private String docTmprStrgYn;
}
