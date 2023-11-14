package kr.or.everyware.everyware.work.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.everyware.everyware.work.vo.PaginationInfo;
import kr.or.everyware.everyware.work.vo.WorkAdj;

@Mapper
public interface WorkAdjMapper {

	public List<WorkAdj> getWorkAdjList(WorkAdj workAdj);

//	public int getTotalRecord(WorkAdj workAdj);

	public int updateWorkAdjWithConfirm(WorkAdj workAdj);

	public int updateWorkAdjWithReject(WorkAdj workAdj);

	public int insertWorkAdj(WorkAdj workAdj);

//	public int getProgressCount(WorkAdj workAdj);
//
//	public int getApprovedCount(WorkAdj workAdj);
//
//	public int getRejectedCount(WorkAdj workAdj);

	public WorkAdj getOneWorkAdj(int waNo);

	public List<WorkAdj> getWorkAdjJson(String empId);

	public int getProgressCount(String empId);

	public int getApprovedCount(String empId);

	public int getRejectedCount(String empId);

	public int getTotalRecord(String empId);

	public List<WorkAdj> getWorkAdjAdminJson(String custId);

	public int getTotalRecordAdmin(String custId);

	public int getProgressCountAdmin(String custId);

	public int getApprovedCountAdmin(String custId);

	public int getRejectedCountAdmin(String custId);

}
