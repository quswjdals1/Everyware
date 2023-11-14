package kr.or.everyware.admin.workYear.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.admin.workYear.mapper.WorkYearMapper;
import kr.or.everyware.admin.workYear.vo.WorkYear;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class WorkYearServiceImpl implements WorkYearService{
	
	@Inject
	private WorkYearMapper workYearMapper;
	
	@Override
	public List<WorkYear> getWorkYear(String custId) {
		return workYearMapper.getWorkYear(custId);
	}

	@Override
	public ServiceResult addWorkYear(WorkYear workYear) {
		ServiceResult result = null;
		
		int status = workYearMapper.addWorkYear(workYear);
		int status2 = workYearMapper.editWorkYearEmp(workYear);
//		log.info("status2 : " + status2);
		
		if(status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public int delWorkYear(int wyNo) {
		return workYearMapper.delWorkYear(wyNo);
	}

	@Override
	public ServiceResult editWorkYear(WorkYear workYear) {
		ServiceResult result = null;
		
		int status = workYearMapper.editWorkYear(workYear);
		int status2 = workYearMapper.editWorkYearEmp(workYear);
		
		if(status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}
}
