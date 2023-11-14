package kr.or.everyware.everyware.document.vo;

import java.util.Base64;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ApprovalLine implements Comparable<ApprovalLine>{
	private int aprvLineSn;
	private int aprvSn;
	private String empId;
	private int aprvOrder;
	private String atrzDt;
	private String atrzOpnn;
	private int prgrsSttsCd;	// 상태 code
	private int aprvSeCd;
	private String dcrbYn;
	private String prslDt;
	
	private String empName;
	private String empProfile;
	private String jbgdNm;
	private String deptNm;
	private String cocoNm;
	
	private String subYn;
	
	private MultipartFile file;
	private byte[] imgData;
	private String encodedImg;
	
	public void setImgData(byte[] imgData) {
		this.imgData = imgData;
		this.encodedImg = Base64.getEncoder().encodeToString(imgData);
	}
	
	@Override
	public int compareTo(ApprovalLine other) {
		return Integer.compare(this.aprvOrder, other.aprvOrder) * -1;
	}
}
