package kr.or.everyware.admin.vacation.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.admin.vacation.mapper.HldyMapper;
import kr.or.everyware.admin.vacation.vo.Hldy;

@Service
public class HldyServiceImpl implements HldyService{

	@Inject
	private HldyMapper hldyMapper;
	
	@Override
	public ServiceResult addHldy(Hldy hldy) {
		ServiceResult result = null;
		
		int status = hldyMapper.addHldy(hldy);
		
		if(status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public List<Hldy> getHldy(String custId) {
		return hldyMapper.getHldy(custId);
	}

	@Override
	public int delWorkYear(int hldyNo) {
		return hldyMapper.delWorkYear(hldyNo);
	}

	@Override
	public int delHldy(int hldyNo) {
		return hldyMapper.delHldy(hldyNo);
	}

	@Override
	public ServiceResult editHldy(Hldy hldy) {
		ServiceResult result = null;
		
		int status = hldyMapper.editHldy(hldy);
		
		if(status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}
	
}
