package kr.or.everyware.everyware.vacation.vo;

import java.util.List;

import kr.or.everyware.admin.vacation.vo.VacItem;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Vacation extends VacationPaging<Vacation> {
	private int aprvSn;			// 결재문서ID
	private String empId;		// 사원번호
	private String vacBgngDt;	// 시작일자
	private String vacEndDt;	// 종료일자
	private String vacReason;	// 휴가사유
	
	private int viNo;
	private String viType;
	private double viDay;
	private String viMemo;
	private String custId;		// 고객사id
	
	private List<VacItem> vacItem;	// 휴가항목
	
	// 현황
	private int total;		// 전체
	private int progress;	// 진행
	private int approved;	// 승인
	private int rejected;	// 반려
	
	private double restVacDay;
	private String jsonObject;
	private Vacation vacation;
	
	private String vacPeriod;
	
//	public void setVacPeriod(String vacPeriod) {
//		this.vacPeriod = vacPeriod;
//		// 문자열 split해서... 
//	}
}
