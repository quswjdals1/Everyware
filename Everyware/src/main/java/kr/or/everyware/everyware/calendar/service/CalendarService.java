package kr.or.everyware.everyware.calendar.service;

import java.util.List;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.vo.Schedule;

public interface CalendarService {

	List<Schedule> getEventList(int deptId);

	List<Schedule> getDeactiveEventList(String empId);

	int insertSchedule(Schedule schedule);

	ServiceResult deleteSchedule(int schdlId);

	ServiceResult modifySchedule(Schedule schedule);

}
