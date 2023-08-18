package kr.or.everyware.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class Employee {

	private String empId;
	private String empPw;
	private int deptId;
	private int jbgdId;
	private String empName;
	private Date empBirth;
	private String empTel;
	private String empMail;
	private String empPost;
	private String empAddr1;
	private String empAddr2;
	private Date empDate;
	private String empIdno;
	private int empVac;
	private String empProfile;
	private int groupNo;
	private String custId;
	
	
	private String jbgdNm;
	private String deptNm;
	private String conm;
	private EmpAuthority empAuthority;
	private List<AuthMenu> authMenuList;
}
