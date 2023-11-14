package kr.or.everyware.admin.work.controler;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import kr.or.everyware.admin.work.service.WorkAdjAdminService;
import kr.or.everyware.admin.work.vo.WorkAdjAdmin;
import kr.or.everyware.login.vo.CustomUserEmployee;
import kr.or.everyware.login.vo.Employee;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/everyware/admin")
public class WorkAdjAdminController {
	
	@Inject
	private WorkAdjAdminService workAdjAdminService;
	@Inject
	private Gson gson;
	
	/**
	 * goWorkAdjAdmin
	 * @param model
	 * @return
	 */
	@PreAuthorize("hasAnyAuthority('HR_AD')")
	@GetMapping(value = "/workAdj")
	public String goWorkAdjAdmin(Model model) {
		log.info("goWorkAdjAdmin()");
		return "admin/work/workAdjAdmin";
	}
	
	/**
	 * 
	 * @param workAdjAdmin
	 * @param model
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/workAdj/getAdminWorkAdj", produces = "application/json; charset=utf-8")
	public Map<String, Object> getAdminWorkAdj(
			@RequestBody WorkAdjAdmin workAdjAdmin
			, Model model
			){
		log.info("getAdminWorkAdj()");
		log.info("workAdjAdmin : " + workAdjAdmin);
		
		Map<String, Object> workAdjAdminMap = new HashMap<String, Object>();
		
		// security User
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		log.info("employee : " + employee);
		
		workAdjAdmin.setEmpId(employee.getEmpId());
		workAdjAdmin.setCustId(employee.getCustId());
		workAdjAdmin.setCurrentPage(workAdjAdmin.getPage());
		log.info("workAdjAdmin : " + workAdjAdmin);
		
		// 현황
//		int totalRecord = workAdjAdminService.getTotalRecord(workAdjAdmin);
//		workAdjAdmin.setTotalRecord(totalRecord);
//		workAdjAdminMap.put("totalRecord", totalRecord);
//		
//		int progress = workAdjAdminService.getProgressCount(workAdjAdmin);	// 진행
//		workAdjAdmin.setProgress(progress);
//		workAdjAdminMap.put("progress", progress);
//		
//		int approved = workAdjAdminService.getApprovedCount(workAdjAdmin);	// 승인
//		workAdjAdmin.setApproved(approved);
//		workAdjAdminMap.put("approved", approved);
//		
//		int rejected = workAdjAdminService.getRejectedCount(workAdjAdmin);	// 반려
//		workAdjAdmin.setRejected(rejected);
//		workAdjAdminMap.put("rejected", rejected);
		
		// 목록
		List<WorkAdjAdmin> dataList = workAdjAdminService.getAdminWorkAdj(workAdjAdmin);
		workAdjAdmin.setDataList(dataList);
		workAdjAdminMap.put("dataList", dataList);
		workAdjAdminMap.put("workAdjAdmin", workAdjAdmin);
		
		return workAdjAdminMap;
	}

	/**
	 * 
	 * @param waNo
	 * @param model
	 * @return
	 */
	@ResponseBody
	@GetMapping(value = "/workAdj/getOneWorkAdjAdmin/{waNo}", produces = "application/json; charset=utf-8")
	public WorkAdjAdmin getOneWorkAdjAdmin(
			@PathVariable("waNo") int waNo
			, Model model) {
		log.info("getOneWorkAdjAdmin()");
		
		WorkAdjAdmin workAdjAdmin = new WorkAdjAdmin();
		workAdjAdmin = workAdjAdminService.getOneWorkAdjAdmin(waNo);
		
		return workAdjAdmin;
	}
	
	/**
	 * Json
	 * @return
	 */
//	@ResponseBody
//	@GetMapping(value = "/workAdj/getWorkAdjAdminJson", produces = "application/json; charset=utf-8")
//	public String getWorkAdjAdminJson() {
//		log.info("getWorkAdjAdminJson()");
//		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
//		Employee employee = customUser.getEmployee();
//		
//		String empId = employee.getEmpId();
//		String custId = employee.getCustId();
//		
//		List<WorkAdjAdmin> list = workAdjAdminService.getWorkAdjAdminJson(custId);
//		log.info("list : "  + list);
//		
//		for (WorkAdjAdmin workAdjAdmin : list) {
//			String jsonObject = workAdjAdmin.getJsonObject();
//			WorkAdjAdmin fromJson = gson.fromJson(jsonObject, WorkAdjAdmin.class);
//			workAdjAdmin.setWorkAdjAdmin(fromJson);
//			log.info("fromJson" + fromJson);
//		}
//		
//		String jsonData = gson.toJson(list);
//		log.info("jsonData : " + jsonData);
//		return jsonData;
//	}
	
	/**
	 * 목록
	 * @param currentPage
	 * @return
	 */
//	@PreAuthorize("hasAnyAuthority('HR')")
//	@ResponseBody
//	@GetMapping(value = "/workAdj/getWorkAdjAdminSummary", produces = "application/json; charset=utf-8")
//	public Map<String, Object> getWorkAdjAdminSummary() {
//		log.info("getWorkAdjAdminSummary()");
//		
//		Map<String, Object> workAdjSummary = new HashMap<String, Object>();
//		
//		// security User
//		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
//		Employee employee = customUser.getEmployee();
//		
//		String empId = employee.getEmpId();
//		String custId = employee.getCustId();
//		
//		// 현황
//		int totalRecode = workAdjAdminService.getTotalRecord(custId);	// 전체
//		workAdjSummary.put("totalRecode", totalRecode);
//		int progress = workAdjAdminService.getProgressCount(custId);	// 진행
//		workAdjSummary.put("progress", progress);
//		int approved = workAdjAdminService.getApprovedCount(custId);	// 승인
//		workAdjSummary.put("approved", approved);
//		int rejected = workAdjAdminService.getRejectedCount(custId);	// 반려
//		workAdjSummary.put("rejected", rejected);
//		
//		log.info("workAdjMap : " + workAdjSummary);
//		
//		return workAdjSummary;
//	}
}
