package kr.or.everyware.everyware.document.vo;

import java.util.Collections;
import java.util.List;

import kr.or.everyware.admin.approval.vo.ApprovalConfig;
import kr.or.everyware.everyware.contact.vo.Department;
import kr.or.everyware.util.toExcel.ExcelFieldName;
import kr.or.everyware.util.toExcel.ExcelFileName;
import lombok.Data;

@Data
@ExcelFileName(value="전자결재")
public class Document {
	private int aprvSn;
	@ExcelFieldName(value = "문서번호", order = 1)
	private String aprvNo;
	private int tmpltCd;
	private String clsfNm;
	@ExcelFieldName(value = "양식명", order = 2)
	private String tmpltNm;
	private String custId;
	private String empId;
	@ExcelFieldName(value = "기안일자", order = 6)
	private String atrzDmndDt;
	@ExcelFieldName(value = "최종결재일자", order = 7)
	private String atrzCmptnDt;
	@ExcelFieldName(value = "제목", order = 8)
	private String aprvTtl;
	private String aprvCn;
	@ExcelFieldName(value = "상태코드", order = 3)
	private String prgrsSttsCd;  // 문서 현재 상태(enum)
	
	private Template template;
	private ApprovalConfig config;
	
	@ExcelFieldName(value = "기안자", order = 5)
	private String empName;
	private int deptId;
	@ExcelFieldName(value = "기안부서", order = 4)
	private String deptNm;
	private String conm;
	
	private String currentEmpId;
	private List<ApprovalLine> myPermission;
	
	private int scrapSn;
	private String dlvrId;
	
	private List<ApprovalLine> approvalLine;
	private List<ApprovalLine> viewers;
	private List<Department> destinations;
	
	// 검색조건
	private String dmndStartDate;
	private String dmndEndDate;
	
	// 후처리용 JSON Object
	private String jsonObject;
	
	private String status; // modify or redraft
	
	public void setApprovalLine(List<ApprovalLine> approvalLine) {
		Collections.sort(approvalLine);
		this.approvalLine = approvalLine;
	}
}
