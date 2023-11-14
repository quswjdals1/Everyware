package kr.or.everyware.admin.work.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.everyware.admin.work.vo.WorkAdjAdmin;

@Mapper
public interface WorkAdjAdminMapper {

//	public int getTotalRecord(WorkAdjAdmin workAdjAdmin);
//
//	public int getProgressCount(WorkAdjAdmin workAdjAdmin);
//
//	public int getApprovedCount(WorkAdjAdmin workAdjAdmin);
//
//	public int getRejectedCount(WorkAdjAdmin workAdjAdmin);

	public List<WorkAdjAdmin> getAdminWorkAdj(WorkAdjAdmin workAdjAdmin);

	public WorkAdjAdmin getOneWorkAdjAdmin(int waNo);

	public List<WorkAdjAdmin> getWorkAdjAdminJson(String custId);

	public int getTotalRecord(String custId);

	public int getProgressCount(String custId);

	public int getApprovedCount(String custId);

	public int getRejectedCount(String custId);

}
