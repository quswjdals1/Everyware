package kr.or.everyware.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ApprovalLine {
	private int apprSn;
	private int docSn;
	private String empId;
	private String docStts;
	private int apprOrder;
	private Date AtrzDt;
	private String atrzOpnn;
	private String idntyYn;
}
