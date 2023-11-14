package kr.or.everyware.admin.workGroup.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.admin.workGroup.service.WorkGroupService;
import kr.or.everyware.admin.workGroup.vo.WorkGroup;
import kr.or.everyware.login.vo.Client;
import kr.or.everyware.login.vo.CustomUserClient;
import kr.or.everyware.login.vo.CustomUserEmployee;
import kr.or.everyware.login.vo.Employee;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/everyware/admin")
public class workGroupController {
	
	@Inject
	private WorkGroupService workGroupService;
	
	/**
	 * 근로제 목록
	 * goWorkGroup
	 * @param model
	 * @return
	 */
	@PreAuthorize("hasAnyAuthority('HR_AD','custauth')")
	@RequestMapping(value = "/workGroup", method = RequestMethod.GET)
	public String goWorkGroup(Model model) {
		log.info("goWorkGroup()");
		
		String custId="";
        
    	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		boolean isCleint=false;
		if (authentication != null && authentication.isAuthenticated()) {
			authentication.getAuthorities();
		    for (GrantedAuthority authority : authentication.getAuthorities()) {
		        if(authority.getAuthority().equals("custauth")) {
		        	isCleint=true;
		        	break;
		        }
		    }
		}
		
		if(isCleint) {
			CustomUserClient customUser = (CustomUserClient) authentication.getPrincipal();
			Client client = customUser.getClient();
			custId = client.getCustId();
		}else {
			CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
			Employee employee = customUser.getEmployee();
			custId = employee.getCustId();
		}
		
		// 
		List<WorkGroup> workGroup = workGroupService.getWorkGroup(custId);
		
		log.info("custId :" + custId);
		
		//		
		int totalWorkGroup = workGroupService.getWorkGroupCount(custId);
		
		
		model.addAttribute("workGroup", workGroup);
		model.addAttribute("totalWorkGroup", totalWorkGroup);
		
		
		return "popup/workGroup";
	}
	
	
	
	/**
	 * 추가 addWorkGroup
	 * @param workGroup
	 * @param model
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/workGroup/addWorkGroup", produces = "application/json; charset=utf-8")
	public String addWorkGroup(
			@RequestBody WorkGroup workGroup
			, Model model
			) {
		log.info("addWorkGroup()");
		String resTxt = "";
		
		String custId="";
        
    	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		boolean isCleint=false;
		if (authentication != null && authentication.isAuthenticated()) {
			authentication.getAuthorities();
		    for (GrantedAuthority authority : authentication.getAuthorities()) {
		        if(authority.getAuthority().equals("custauth")) {
		        	isCleint=true;
		        	break;
		        }
		    }
		}
		
		if(isCleint) {
			CustomUserClient customUser = (CustomUserClient) authentication.getPrincipal();
			Client client = customUser.getClient();
			custId = client.getCustId();
		}else {
			CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
			Employee employee = customUser.getEmployee();
			custId = employee.getCustId();
		}
		
		workGroup.setCustId(custId);
		log.info("workGroup : " + workGroup);
		
		ServiceResult result = workGroupService.addWorkGorup(workGroup);
		log.info("result : " + result);
		
		if(result.equals(ServiceResult.OK)) {
			resTxt = "success";
		} else {
			resTxt = "fail";
		}
		
		return resTxt;
	}
	
	/**
	 * 상세보기
	 * @param groupNo
	 * @param model
	 * @return
	 */
	@ResponseBody
	@GetMapping(value = "/workGroup/getOneWorkGroup/{groupNo}", produces = "application/json; charset=utf-8")
	public WorkGroup getOneWorkGroup(
			@PathVariable("groupNo") int groupNo
			, Model model) {
		log.info("getOneWorkGroup()");
		
		WorkGroup workGroup = new WorkGroup();
		workGroup = workGroupService.getOneWorkGroup(groupNo);
		log.info("workGroupDetail : " + workGroup);
//		model.addAttribute("");
		return workGroup;
	}
	
	/**
	 * 수정
	 * @param workGroup
	 * @param model
	 * @return
	 */
	@ResponseBody
	@PutMapping(value = "/workGroup/editWorkGroup", produces = "application/json; charset=utf-8")
	public String editWorkGroup(
			@RequestBody WorkGroup workGroup
			, Model model) {
		log.info("editGroup()");
		log.info("workGroup : " + workGroup);
		String resTxt = "";
		
		ServiceResult result = workGroupService.editGroup(workGroup);
		if(result.equals(ServiceResult.OK)) {
			resTxt = "success";
		} else {
			resTxt = "fail";
		}
		
		return resTxt;
	}
	
	/**
	 * 삭제
	 * @param groupNo
	 * @return
	 */
	@ResponseBody
	@DeleteMapping(value = "/workGroup/delWorkGroup/{groupNo}", produces = "application/json; charset=utf-8")
	public String delWorkGroup(@PathVariable("groupNo") int groupNo) {
		log.info("delWorkGroup()");
		String resTxt = "";
		int res = workGroupService.delWorkGroup(groupNo);
		log.info("res" + res);
		
		if(res > 0) {
			resTxt = "success";
		} else {
			resTxt = "fail";
		}
		
		log.info("resTxt" + resTxt);
		return resTxt;
	}
	
}
