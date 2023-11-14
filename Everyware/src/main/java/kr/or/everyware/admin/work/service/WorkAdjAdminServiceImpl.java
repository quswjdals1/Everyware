package kr.or.everyware.admin.work.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.everyware.admin.work.mapper.WorkAdjAdminMapper;
import kr.or.everyware.admin.work.vo.WorkAdjAdmin;

@Service
public class WorkAdjAdminServiceImpl implements WorkAdjAdminService {
	
	@Inject
	private WorkAdjAdminMapper workadminMapper; 
	
//	@Override
//	public int getTotalRecord(WorkAdjAdmin workAdjAdmin) {
//		return workadminMapper.getTotalRecord(workAdjAdmin);
//	}
//
//	@Override
//	public int getProgressCount(WorkAdjAdmin workAdjAdmin) {
//		return workadminMapper.getProgressCount(workAdjAdmin);
//	}
//
//	@Override
//	public int getApprovedCount(WorkAdjAdmin workAdjAdmin) {
//		return workadminMapper.getApprovedCount(workAdjAdmin);
//	}
//
//	@Override
//	public int getRejectedCount(WorkAdjAdmin workAdjAdmin) {
//		return workadminMapper.getRejectedCount(workAdjAdmin);
//	}

	@Override
	public List<WorkAdjAdmin> getAdminWorkAdj (WorkAdjAdmin workAdjAdmin) {
		return workadminMapper.getAdminWorkAdj(workAdjAdmin);
	}

	@Override
	public WorkAdjAdmin getOneWorkAdjAdmin(int waNo) {
		return workadminMapper.getOneWorkAdjAdmin(waNo);
	}

	@Override
	public List<WorkAdjAdmin> getWorkAdjAdminJson(String custId) {
		return workadminMapper.getWorkAdjAdminJson(custId);
	}

	@Override
	public int getTotalRecord(String custId) {
		return workadminMapper.getTotalRecord(custId);
	}

	@Override
	public int getProgressCount(String custId) {
		return workadminMapper.getProgressCount(custId);
	}

	@Override
	public int getApprovedCount(String custId) {
		return workadminMapper.getApprovedCount(custId);
	}

	@Override
	public int getRejectedCount(String custId) {
		return workadminMapper.getRejectedCount(custId);
	}

}
