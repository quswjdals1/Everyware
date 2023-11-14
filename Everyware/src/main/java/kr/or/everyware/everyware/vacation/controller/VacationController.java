package kr.or.everyware.everyware.vacation.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import kr.or.everyware.admin.vacation.vo.VacItem;
import kr.or.everyware.everyware.document.service.IDocumentService;
import kr.or.everyware.everyware.document.service.ITemplateService;
import kr.or.everyware.everyware.vacation.service.VacationService;
import kr.or.everyware.everyware.vacation.vo.Vacation;
import kr.or.everyware.everyware.vacation.vo.VacationPaging;
import kr.or.everyware.login.vo.CustomUserEmployee;
import kr.or.everyware.login.vo.Employee;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value = "/everyware")
public class VacationController {
	
	@Inject
	private VacationService vacationService;
	@Autowired
	private Gson gson;
	@Autowired
	private ITemplateService templateService;
	@Autowired
	private IDocumentService documentService;
	
	/**
	 * goVacation
	 * @return
	 */
	@PreAuthorize("hasAnyAuthority('HR')")
	@GetMapping(value = "/vacation")
	public String goVacation() {
		log.info("goVacation()");
		return "everyware/vacation/vacation";
	}
	
	/**
	 * 목록
	 * @param vacation
	 * @param model
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/vacation/getVacationList", produces = "application/json; charset=utf-8")
	public Map<String, Object> getVacationList(
			@RequestBody Vacation vacation
			, Model model
			){
		log.info("getVacationList()");
		log.info("vacation : " + vacation);
		
		Map<String, Object> vacationMap = new HashMap<String, Object>();
	
		// security User
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		vacation.setEmpId(employee.getEmpId());
		vacation.setCustId(employee.getCustId());
		
		// 현황
//		int totalRecode = vacationService.getTotalRecord(vacation);		// 전체
//		vacation.setTotalRecord(totalRecode);
//		vacationMap.put("totalRecode", totalRecode);
//		int total = vacationService.getTotal(vacation);
//		vacationMap.put("total", total);
//		int progress = vacationService.getProgress(vacation);
//		vacationMap.put("progress", sprogress);
//		int approved = vacationService.getApproved(vacation);
//		vacationMap.put("approved", approved);
//		int rejected = vacationService.getRejected(vacation);
//		vacationMap.put("rejected", rejected);
//		
		// 휴가항목
		List<VacItem> vacItemList = vacationService.getVacItem(vacation);
		vacation.setVacItem(vacItemList);
		vacationMap.put("vacItemList", vacItemList);
		
		// 목록
		List<Vacation> dataList = vacationService.getVacationList(vacation);
		vacation.setDataList(dataList);
		vacationMap.put("dataList", dataList);
		vacationMap.put("vacation", vacation);
		
		log.info("dataList : " + dataList);
		log.info("vacation : " + vacation);
		return vacationMap;
	}
	
	/**
	 * 
	 * @param model
	 * @return
	 */
	@ResponseBody
	@GetMapping(value = "/vacation/getVacationJson", produces = "application/json; charset=utf-8")
	public String getVacationJson() {
		
		// security User
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		String empId = employee.getEmpId();
		String custId = employee.getCustId();
		
		List<Vacation> list = vacationService.getVacationJson(empId);
		log.info("list : " + list);
		
		for (Vacation vacation : list) {
			String jsonObject = vacation.getJsonObject();
			Vacation fromJson = gson.fromJson(jsonObject, Vacation.class);
			vacation.setVacation(fromJson);
			log.info("fromJson" + fromJson);
		}
		
		String jsonData = gson.toJson(list);
		log.info("jsonData : " + jsonData);
		return jsonData;
	}
	
	@ResponseBody
	@GetMapping(value = "/vacation/getVacationSummary", produces = "application/json; charset=utf-8")
	public Map<String, Object> getVacationSummary() {
		log.info("getVacationSummary()");
		
		Map<String, Object> vacationSum = new HashMap<String, Object>();
		
		// security User
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		String empId = employee.getEmpId();
		String custId = employee.getCustId();
		
		// 현황
		int totalRecode = vacationService.getTotalRecord(empId);	// 전체
		vacationSum.put("totalRecode", totalRecode);
		int progress = vacationService.getProgressCount(empId);	// 진행
		vacationSum.put("progress", progress);
		int approved = vacationService.getApprovedCount(empId);	// 승인
		vacationSum.put("approved", approved);
		int rejected = vacationService.getRejectedCount(empId);	// 반려
		vacationSum.put("rejected", rejected);
		
		log.info("vacationSum : " + vacationSum);
		
		return vacationSum;
	}

	
	
	
	
	
	// 관리자
	/**
	 * 
	 * @param model
	 * @return
	 */
	@ResponseBody
	@GetMapping(value = "admin/vacation/getVacationAdminJson", produces = "application/json; charset=utf-8")
	public String getVacationAdminJson() {
		
		// security User
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		String empId = employee.getEmpId();
		String custId = employee.getCustId();
		
		List<Vacation> list = vacationService.getVacationAdminJson(custId);
		log.info("list : " + list);
		
		for (Vacation vacation : list) {
			String jsonObject = vacation.getJsonObject();
			Vacation fromJson = gson.fromJson(jsonObject, Vacation.class);
			vacation.setVacation(fromJson);
			log.info("fromJson" + fromJson);
		}
		
		String jsonData = gson.toJson(list);
		log.info("jsonData : " + jsonData);
		return jsonData;
	}
	
	@ResponseBody
	@GetMapping(value = "admin/vacation/getVacationAdminSummary", produces = "application/json; charset=utf-8")
	public Map<String, Object> getVacationAdminSummary() {
		log.info("getVacationSummary()");
		
		Map<String, Object> vacationSum = new HashMap<String, Object>();
		
		// security User
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		String empId = employee.getEmpId();
		String custId = employee.getCustId();
		
		// 현황
		int totalRecode = vacationService.getTotalRecordAdmin(custId);	// 전체
		vacationSum.put("totalRecode", totalRecode);
		int progress = vacationService.getProgressCountAdmin(custId);	// 진행
		vacationSum.put("progress", progress);
		int approved = vacationService.getApprovedCountAdmin(custId);	// 승인
		vacationSum.put("approved", approved);
		int rejected = vacationService.getRejectedCountAdmin(custId);	// 반려
		vacationSum.put("rejected", rejected);
		
		log.info("vacationSum : " + vacationSum);
		
		return vacationSum;
	}
	 
}
