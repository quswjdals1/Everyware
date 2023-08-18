package kr.or.everyware.everyware.calendar.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.gson.Gson;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.everyware.calendar.service.CalendarService;
import kr.or.everyware.vo.CustomUserEmployee;
import kr.or.everyware.vo.Employee;
import kr.or.everyware.vo.Schedule;

@Controller
@RequestMapping(value = "/everyware")
public class CalendarController {
	
	@Inject
	CalendarService calendarService;
	
	@PreAuthorize("hasAuthority('calendar')")
	@RequestMapping(value = "/calendar", method = RequestMethod.GET)
	public String calendarMain(Model model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		System.out.println(employee);
		List<Schedule> eventList = calendarService.getEventList(employee.getDeptId());
		List<Schedule> list = calendarService.getDeactiveEventList(employee.getEmpId());
		
		Gson gson = new Gson();
		String json = gson.toJson(eventList);
		model.addAttribute("eventList",json);
		model.addAttribute("undoEventList",list);
		model.addAttribute("employee",employee);
		return "everyware/calendar/test";
	}
	@PreAuthorize("hasAuthority('default')")
	@RequestMapping(value = "/calendar/register", method = RequestMethod.POST)
	public ResponseEntity<Integer> addSchedule(Schedule schedule, Model model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		schedule.setEmpId(employee.getEmpId());
		int res = calendarService.insertSchedule(schedule);
		return new ResponseEntity<Integer>(res,HttpStatus.OK);
	}
	@PreAuthorize("hasAuthority('default')")
	@RequestMapping(value = "/calendar/delete", method = RequestMethod.POST)
	public ResponseEntity<ServiceResult> deleteSchedule(Integer schdlId,Model model) {
		ResponseEntity<Integer> result = null;
		ServiceResult res = null;
		res = calendarService.deleteSchedule(schdlId);

		return new ResponseEntity<ServiceResult>(res,HttpStatus.OK);
	}
	
	@PreAuthorize("hasAuthority('default')")
	@RequestMapping(value = "/calendar/modify", method = RequestMethod.POST)
	public ResponseEntity<ServiceResult> editSchedule(Schedule schedule,Model model) {
		ResponseEntity<Integer> result = null;
		ServiceResult res = null;
		System.out.println(schedule);
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		schedule.setEmpId(employee.getEmpId());
		
		res = calendarService.modifySchedule(schedule);

		return new ResponseEntity<ServiceResult>(res,HttpStatus.OK);
	}
	
}
