package kr.or.everyware.everyware.work.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;

import com.google.gson.Gson;

import kr.or.everyware.admin.work.vo.WorkAdjAdmin;
import kr.or.everyware.everyware.document.service.IDocumentService;
import kr.or.everyware.everyware.document.service.Impl.DocumentServiceImpl;
import kr.or.everyware.everyware.document.vo.Proxy;
import kr.or.everyware.everyware.work.service.WorkAdjService;
import kr.or.everyware.everyware.work.vo.PaginationInfo;
import kr.or.everyware.everyware.work.vo.WorkAdj;
import kr.or.everyware.login.vo.CustomUserEmployee;
import kr.or.everyware.login.vo.Employee;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value = "/everyware")
public class WorkAdjController {

	@Inject
	private WorkAdjService workAdjService;
	@Inject
	private WebApplicationContext context;
	@Inject
	private IDocumentService documentService;
	@Inject
	private Gson gson;
	
	/**
	 * goWorkAdj
	 * @return
	 */
	@PreAuthorize("hasAnyAuthority('HR')")
	@GetMapping(value = "/workAdj")
	public String goWorkAdj() {
		log.info("goWorkAdj()");
		return "everyware/work/workAdj";
	}
	
	/**
	 * 목록
	 * @param currentPage
	 * @return
	 */
	@PreAuthorize("hasAnyAuthority('HR')")
	@ResponseBody
	@PostMapping(value = "/workAdj/getWorkAdjList", produces = "application/json; charset=utf-8")
	public Map<String, Object> getWorkAdjList(
			@RequestBody WorkAdj workAdj
			, Model model
			) {
		log.info("getWorkAdjList()");
		log.info("WorkAdj(페이징) : " + workAdj);
		
		Map<String, Object> workAdjMap = new HashMap<String, Object>();
		
		// security User
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		workAdj.setEmpId(employee.getEmpId());
		workAdj.setCustId(employee.getCustId());
		workAdj.setCurrentPage(workAdj.getPage());
		log.info("workAdj : " + workAdj);
		
		// 현황
//		int totalRecode = workAdjService.getTotalRecord(workAdj);	// 전체
//		workAdj.setTotalRecord(totalRecode);
//		workAdjMap.put("totalRecode", totalRecode);
//		int progress = workAdjService.getProgressCount(workAdj);	// 진행
//		workAdj.setProgress(progress);
//		workAdjMap.put("progress", progress);
//		int approved = workAdjService.getApprovedCount(workAdj);	// 승인
//		workAdj.setApproved(approved);
//		workAdjMap.put("approved", approved);
//		int rejected = workAdjService.getRejectedCount(workAdj);	// 반려
//		workAdj.setRejected(rejected);
//		workAdjMap.put("rejected", rejected);
		
		// 근태조정현황
		List<WorkAdj> dataList = workAdjService.getWorkAdjList(workAdj);
		workAdj.setDataList(dataList);
		workAdjMap.put("dataList", dataList);
		workAdjMap.put("workAdj", workAdj);
		
		log.info("dataList : " + dataList);
		log.info("workAdjMap : " + workAdjMap);
		
//		model.addAttribute("suvyActive", "active");
		return workAdjMap;
	}
	
	
	@PreAuthorize("hasAnyAuthority('HR')")
	@PostMapping(value = "/workAdj", produces = "application/json; charset=utf-8")
	public String addWorkAdj(@RequestBody WorkAdj workAdj) {
		
		log.info("workAdj: " + workAdj);
		
		int addWorkAdj = workAdjService.addWorkAdj(workAdj);
		
		// 리턴은 맘대로~
		return "성공";
	}
	
	/**
	 * 상세보기
	 * @return
	 */
	@PreAuthorize("hasAnyAuthority('HR')")
	@ResponseBody
	@GetMapping(value = "/workAdj/getOneWorkAdj/{waNo}", produces = "application/json; charset=utf-8")
	public WorkAdj getOneWorkAdj(
			@PathVariable("waNo") int waNo
			, Model model) {
		log.info("getOneWorkAdj()");
		
		WorkAdj workAdj = new WorkAdj();
		workAdj = workAdjService.getOneWorkAdj(waNo);
		
		return workAdj;
	}
	
	/**
	 * Json
	 * @return
	 */
	@ResponseBody
	@GetMapping(value = "/workAdj/getWorkAdjJson", produces = "application/json; charset=utf-8")
	public String getWorkAdjJson() {
		log.info("getWorkAdjJson()");
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		String empId = employee.getEmpId();
		log.info("empId : " + empId);
		
		List<WorkAdj> list = workAdjService.getWorkAdjJson(empId);
		log.info("list : "  + list);
		
		for (WorkAdj workAdj : list) {
			String jsonObject = workAdj.getJsonObject();
			WorkAdj fromJson = gson.fromJson(jsonObject, WorkAdj.class);
			workAdj.setWorkAdj(fromJson);
			log.info("fromJson" + fromJson);
		}
		
		String jsonData = gson.toJson(list);
		log.info("jsonData : " + jsonData);
		return jsonData;
	}
	
	/**
	 * 목록
	 * @param currentPage
	 * @return
	 */
	@PreAuthorize("hasAnyAuthority('HR')")
	@ResponseBody
	@GetMapping(value = "/workAdj/getWorkAdjSummary", produces = "application/json; charset=utf-8")
	public Map<String, Object> getWorkAdjSummary() {
		log.info("getWorkAdjSummary()");
		
		Map<String, Object> workAdjSummary = new HashMap<String, Object>();
		
		// security User
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		String empId = employee.getEmpId();
		String custId = employee.getCustId();
		
		// 현황
		int totalRecode = workAdjService.getTotalRecord(empId);	// 전체
		workAdjSummary.put("totalRecode", totalRecode);
		int progress = workAdjService.getProgressCount(empId);	// 진행
		workAdjSummary.put("progress", progress);
		int approved = workAdjService.getApprovedCount(empId);	// 승인
		workAdjSummary.put("approved", approved);
		int rejected = workAdjService.getRejectedCount(empId);	// 반려
		workAdjSummary.put("rejected", rejected);
		
		log.info("workAdjMap : " + workAdjSummary);
		
		return workAdjSummary;
	}
	
	
	
	
	
	
	
	
	// 관리자
	/**
	 * Json
	 * @return
	 */
	@ResponseBody
	@GetMapping(value = "/workAdj/getWorkAdjAdminJson", produces = "application/json; charset=utf-8")
	public String getWorkAdjAdminJson() {
		log.info("getWorkAdjAdminJson()");
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		String empId = employee.getEmpId();
		String custId = employee.getCustId();
		
		List<WorkAdj> list = workAdjService.getWorkAdjAdminJson(custId);
		log.info("list : "  + list);
		
		for (WorkAdj workAdjAdmin : list) {
			String jsonObject = workAdjAdmin.getJsonObject();
			WorkAdj fromJson = gson.fromJson(jsonObject, WorkAdj.class);
			workAdjAdmin.setWorkAdj(fromJson);
			log.info("fromJson" + fromJson);
		}
		
		String jsonData = gson.toJson(list);
		log.info("jsonData : " + jsonData);
		return jsonData;
	}
	
	/**
	 * summary
	 * @param currentPage
	 * @return
	 */
	@PreAuthorize("hasAnyAuthority('HR')")
	@ResponseBody
	@GetMapping(value = "/workAdj/getWorkAdjAdminSummary", produces = "application/json; charset=utf-8")
	public Map<String, Object> getWorkAdjAdminSummary() {
		log.info("getWorkAdjAdminSummary()");
		
		Map<String, Object> workAdjSummaryAdmin = new HashMap<String, Object>();
		
		// security User
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		String empId = employee.getEmpId();
		String custId = employee.getCustId();
		
		// 현황
		int totalRecode = workAdjService.getTotalRecordAdmin(custId);	// 전체
		workAdjSummaryAdmin.put("totalRecode", totalRecode);
		int progress = workAdjService.getProgressCountAdmin(custId);	// 진행
		workAdjSummaryAdmin.put("progress", progress);
		int approved = workAdjService.getApprovedCountAdmin(custId);	// 승인
		workAdjSummaryAdmin.put("approved", approved);
		int rejected = workAdjService.getRejectedCountAdmin(custId);	// 반려
		workAdjSummaryAdmin.put("rejected", rejected);
		
		log.info("workAdjMap : " + workAdjSummaryAdmin);
		
		return workAdjSummaryAdmin;
	}
	
	
}
