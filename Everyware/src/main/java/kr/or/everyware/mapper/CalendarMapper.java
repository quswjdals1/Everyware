package kr.or.everyware.mapper;

import java.util.List;

import kr.or.everyware.vo.Schedule;

public interface CalendarMapper {

	List<Schedule> getEventList(int deptId);

	List<Schedule> getDeactiveEventList(String empId);

	int insertSchedule(Schedule schedule);

	int deleteSchedule(int schdlId);

	int modifySchedule(Schedule schedule);

}
