package kr.or.everyware.everyware.calendar.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.everyware.calendar.service.CalendarService;
import kr.or.everyware.mapper.CalendarMapper;
import kr.or.everyware.vo.Schedule;

@Service
public class CalendarServiceImpl implements CalendarService {

	@Inject
	CalendarMapper mapper;
	

	@Override
	public List<Schedule> getEventList(int deptId) {
		// TODO Auto-generated method stub
		return mapper.getEventList(deptId);
	}


	@Override
	public List<Schedule> getDeactiveEventList(String empId) {
		// TODO Auto-generated method stub
		return mapper.getDeactiveEventList(empId);
	}


	@Override
	public int insertSchedule(Schedule schedule) {
		int res = mapper.insertSchedule(schedule);
		if(res>0) {
			return schedule.getSchdlId();
		}else {
			return 0;
		}
	}


	@Override
	public ServiceResult deleteSchedule(int schdlId) {
		// TODO Auto-generated method stub
		ServiceResult res = null;
		
		int result = mapper.deleteSchedule(schdlId);
		if(result>0) {
			res=ServiceResult.OK;
		}else {
			res=ServiceResult.FAILED;
		}
		return res;
	}


	@Override
	public ServiceResult modifySchedule(Schedule schedule) {
		// TODO Auto-generated method stub
ServiceResult res = null;
		
		int result = mapper.modifySchedule(schedule);
		if(result>0) {
			res=ServiceResult.OK;
		}else {
			res=ServiceResult.FAILED;
		}
		return res;
	}

}
