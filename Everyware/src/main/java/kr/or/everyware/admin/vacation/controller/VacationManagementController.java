package kr.or.everyware.admin.vacation.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.admin.vacation.service.HldyService;
import kr.or.everyware.admin.vacation.vo.Hldy;
import kr.or.everyware.login.vo.CustomUserEmployee;
import kr.or.everyware.login.vo.Employee;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value = "/everyware/admin")
public class VacationManagementController {
	
	@Inject
	private HldyService hldyService;
	
	/**
	 * goVacationManagement
	 * @return
	 */
	@PreAuthorize("hasAnyAuthority('HR_AD')")
	@GetMapping(value = "/vacationManagement")
	public String goVacationManagement() {
		log.info("goVacationManagement()");
		return "admin/vacation/vacationManagement";
	}
	
	/**
	 * 목록
	 * @param authentication
	 * @param model
	 * @return
	 */
	@ResponseBody
	@GetMapping(value = "/vacationManagement/getHldy", produces = "application/json; charset=utf-8")
	public Map<String, Object> getHldy(
			Authentication authentication
			, Model model){
		log.info("getHldy()");
		
		// security User
		authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		log.info("employee : " + employee);
		
		HashMap<String, Object> hldyMap = new HashMap<String, Object>();
		List<Hldy> hldy = hldyService.getHldy(employee.getCustId());
		log.info("hldy : " + hldy);
		hldyMap.put("hldy", hldy);
		
		return hldyMap;
	}
	
	/**
	 * 추가
	 * addHldy
	 * @param hldy
	 * @param model
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/vacationManagement/addHldy", produces = "application/json; charset=utf-8")
	public String addHldy(
			@RequestBody Hldy hldy
			, Model model) {
		log.info("addHldy()");
		String resTxt = "";
		
		// security User
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		hldy.setCustId(employee.getCustId());
		log.info("hldy : " + hldy);
		
		ServiceResult result = hldyService.addHldy(hldy);
		log.info("result : "  + result);
		
		if(result.equals(ServiceResult.OK)) {
			resTxt = "success";
		} else {
			resTxt = "fail";
		}
		return resTxt;
		
	}
	
	/**
	 * 삭제
	 * delHldy
	 * @param hldyNo
	 * @return
	 */
	@ResponseBody
	@DeleteMapping(value = "/vacationManagement/delHldy/{hldyNo}", produces = "application/json; charset=utf-8")
	public String delHldy(@PathVariable("hldyNo") int hldyNo) {
		log.info("delHldy : ");
		log.info("hldyNo : " + hldyNo);
		
		String resTxt = "";
		
		int result = hldyService.delHldy(hldyNo);
		log.info("result :" + result);
		
		if(result > 0) {
			resTxt = "success";
		} else {
			resTxt = "fail";
		}
		
		return resTxt;
	}
	
	/**
	 * 수정
	 * @param hldy
	 * @return
	 */
	@ResponseBody
	@PutMapping(value = "/vacationManagement/editHldy", produces = "application/json; charset=utf-8")
	public String editHldy(
			@RequestBody Hldy hldy) {
		log.info("editHldy()");
		log.info("hldy : " + hldy);
		String resTxt = "";
		
		ServiceResult result = hldyService.editHldy(hldy);
		log.info("result : " + result);
		
		if(result.equals(ServiceResult.OK)) {
			resTxt = "success";
		} else {
			resTxt = "fail";
		}
		
		return resTxt;
	}
	
//	@GetMapping()
//	public Map<String, Object> getOneHldy(
//			@RequestBody Hldy hldy
//			, Model model){
//		
//	} 
	
}
