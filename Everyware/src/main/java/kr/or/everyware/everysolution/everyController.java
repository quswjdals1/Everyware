package kr.or.everyware.everysolution;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/everysolution")
@Slf4j
public class everyController {
/*시험용 문구*/
	@RequestMapping(value = "/home")
	public String everyHome() {
		return "every/home";
	}
	
	@RequestMapping(value = "/signup")
	public String everySignup() {
		return "every/signup";
	}
	
	@RequestMapping(value = "/membership")
	public String everyMembership() {
		return "every/membership";
	}
	
	@PreAuthorize("hasAuthority('custauth')")
	@RequestMapping(value = "/myPage")
	public String everyMypage() {
		return "every/myPage";
	}
	
	@RequestMapping(value = "/introduce")
	public String everyIntroduce() {
		return "every/introduce";
	}
	
	
}
