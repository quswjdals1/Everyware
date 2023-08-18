package kr.or.everyware.everyware.contact.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/")
public class ContactController {
	
	@RequestMapping("/")
	public String testContacts() {
		return "argcht";
	}
}
