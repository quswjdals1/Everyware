package kr.or.everyware.admin.vacation;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value = "/everyware/admin")
public class VacationAdminController {

	/**
	 * goVacation
	 * @return
	 */
	@PreAuthorize("hasAnyAuthority('HR_AD')")
	@GetMapping(value = "/vacation")
	public String goVacationAdmin() {
		log.info("goVacation()");
		return "admin/vacation/vacationAdmin";
	}
	
	
}
