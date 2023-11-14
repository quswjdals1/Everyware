package kr.or.everyware.everyware.work.service;

import java.util.List;

import kr.or.everyware.everyware.work.vo.PaginationInfo;
import kr.or.everyware.everyware.work.vo.WorkAdj;

public interface WorkAdjService {

	public List<WorkAdj> getWorkAdjList(WorkAdj workAdj);
	
//	public int getTotalRecord(WorkAdj workAdj);
	
	int addWorkAdj(WorkAdj workAdj);

	// 결재후처리
	int processAfterConfirm(String jsonObj);
	int processAfterReject(String jsonObj);

//	public int getProgressCount(WorkAdj workAdj);
//
//	public int getApprovedCount(WorkAdj workAdj);
//
//	public int getRejectedCount(WorkAdj workAdj);

	public WorkAdj getOneWorkAdj(int waNo);

	public List<WorkAdj> getWorkAdjJson(String empId);

	public int getTotalRecord(String empId);

	public int getProgressCount(String empId);

	public int getApprovedCount(String empId);

	public int getRejectedCount(String empId);

	public List<WorkAdj> getWorkAdjAdminJson(String custId);

	public int getTotalRecordAdmin(String custId);

	public int getProgressCountAdmin(String custId);

	public int getApprovedCountAdmin(String custId);

	public int getRejectedCountAdmin(String custId);


}
