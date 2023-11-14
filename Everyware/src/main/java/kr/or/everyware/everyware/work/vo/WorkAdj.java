package kr.or.everyware.everyware.work.vo;

import java.util.List;

import kr.or.everyware.everyware.document.vo.ApprovalLine;
import kr.or.everyware.everyware.document.vo.Document;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class WorkAdj extends WorkAdjPaging<WorkAdj> {
	private int waNo;			// 근태조정번호
	private int workNo;			// 근무번호
	private String waBgngDt;	// 조정근무시작일시
	private String waEndDt;		// 조정근무종료일시
	private String waApplyDt;	// 조정신청일자
	private String waReason;	// 근태사유
	private int waStatus;		// 조정신청상태
	private String waBfrBgngDt;	// 조정이전시작일시
	private String waBfrEndDt;	// 조정이전종료일시
	private String workDw;	// 요일
	
	private String empId;		// 사원번호
	private String custId;
	private Document document;	// 문서
	private Work work;
	private List<ApprovalLine> approvalLine;
	
	private String workDt;		// 근무연월일
	private String prgrsSttsCd;
	
	// 현황
	private int progress;	// 진행
	private int approved;	// 승인
	private int rejected;	// 반려
	
	private String jsonObject;
	private WorkAdj workAdj;
	
}
