package kr.or.everyware.vo;

import java.util.Date;

import lombok.Data;

@Data
public class Proxy {
	private int proxyId;
	private String empId;
	private String empId2;
	private Date bgngDt;
	private Date endDt;
}
