package kr.or.everyware.vo;

import lombok.Data;

@Data
public class EmpAuthority {
	private String authrtId;
	private String empId;
	
	private AuthorityGroup authorityGroup;
}
