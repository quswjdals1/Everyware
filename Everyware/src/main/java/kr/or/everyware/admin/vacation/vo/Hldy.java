package kr.or.everyware.admin.vacation.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Hldy {
	private int hldyNo;			// 휴일번호
	private String custId;		// 고객사id
	private String hldyDt;		// 휴일일자
	private String hldyNm;		// 휴일명
	private String hldyYn;		// 휴일여부
	private String hldyMemo;	// 비고
}
