package kr.or.everyware.vo;

import java.util.List;

import lombok.Data;

@Data
public class AuthorityGroup {
	private String authrtId;
	private String authrtNm;
	private String custId;
	
	private List<AuthMenu> authMenuList;
}
