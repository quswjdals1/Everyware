package kr.or.everyware.everyware.main;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/everyware/")
public class MainController {
	
	
	@PreAuthorize("hasAuthority('default')")
	@RequestMapping(value = "/main")
	public String everyIntroduce() {
		return "everyware/main/main";
	}
}
