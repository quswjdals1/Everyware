package kr.or.everyware.everyware.work.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.google.gson.Gson;

import kr.or.everyware.everyware.work.mapper.WorkAdjMapper;
import kr.or.everyware.everyware.work.vo.PaginationInfo;
import kr.or.everyware.everyware.work.vo.WorkAdj;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class WorkAdjServiceImpl implements WorkAdjService {

	@Inject
	private WorkAdjMapper workAdjMapper;
	@Inject
	private Gson gson;

	@Override
	public List<WorkAdj> getWorkAdjList(WorkAdj workAdj) {
		return workAdjMapper.getWorkAdjList(workAdj);
	}

//	@Override
//	public int getTotalRecord(WorkAdj workAdj) {
//		return workAdjMapper.getTotalRecord(workAdj);
//	}
	
	@Override
	public int addWorkAdj(WorkAdj workAdj) {
		return workAdjMapper.insertWorkAdj(workAdj);
	}
	
	// 승인 시 process
	@Override
	public int processAfterConfirm(String jsonObj) {
		int result = 0;
		
		WorkAdj workAdj = gson.fromJson(jsonObj, WorkAdj.class);
		log.info(workAdj.toString());
		
		result = workAdjMapper.updateWorkAdjWithConfirm(workAdj);
		
		// 추가 로직
		
		return result;
	}
	
	// 반려 시 process
	@Override
	public int processAfterReject(String jsonObj) {
		int result = 0;
		
		WorkAdj workAdj = gson.fromJson(jsonObj, WorkAdj.class);
		log.info(workAdj.toString());
		
		result = workAdjMapper.updateWorkAdjWithReject(workAdj);
		
		// 추가 로직
		
		return result;
	}

//	@Override
//	public int getProgressCount(WorkAdj workAdj) {
//		return workAdjMapper.getProgressCount(workAdj);
//	}
//
//	@Override
//	public int getApprovedCount(WorkAdj workAdj) {
//		return workAdjMapper.getApprovedCount(workAdj);
//	}
//
//	@Override
//	public int getRejectedCount(WorkAdj workAdj) {
//		return workAdjMapper.getRejectedCount(workAdj);
//	}

	@Override
	public WorkAdj getOneWorkAdj(int waNo) {
		return workAdjMapper.getOneWorkAdj(waNo);
	}

	@Override
	public List<WorkAdj> getWorkAdjJson(String empId) {
		return workAdjMapper.getWorkAdjJson(empId);
	}

	// 
	@Override
	public int getTotalRecord(String empId) {
		return workAdjMapper.getTotalRecord(empId);
	}

	@Override
	public int getProgressCount(String empId) {
		return workAdjMapper.getProgressCount(empId);
	}

	@Override
	public int getApprovedCount(String empId) {
		return workAdjMapper.getApprovedCount(empId);
	}

	@Override
	public int getRejectedCount(String empId) {
		return workAdjMapper.getRejectedCount(empId);
	}

	@Override
	public List<WorkAdj> getWorkAdjAdminJson(String custId) {
		return workAdjMapper.getWorkAdjAdminJson(custId);
	}

	@Override
	public int getTotalRecordAdmin(String custId) {
		return workAdjMapper.getTotalRecordAdmin(custId);
	}

	@Override
	public int getProgressCountAdmin(String custId) {
		return workAdjMapper.getProgressCountAdmin(custId);
	}

	@Override
	public int getApprovedCountAdmin(String custId) {
		return workAdjMapper.getApprovedCountAdmin(custId);
	}

	@Override
	public int getRejectedCountAdmin(String custId) {
		return workAdjMapper.getRejectedCountAdmin(custId);
	}

}
