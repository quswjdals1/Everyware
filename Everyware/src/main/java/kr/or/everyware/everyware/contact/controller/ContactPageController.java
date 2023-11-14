package kr.or.everyware.everyware.contact.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/everyware")
public class ContactPageController {

	@PreAuthorize("hasAuthority('ADDRESSBOOK')")
	@RequestMapping("/treeTest")
	public String testContacts() {
		return "everyware/contacts/modalOpenTest";
	}
	
	@PreAuthorize("hasAuthority('ADDRESSBOOK')")
	@RequestMapping("/contacts/folder")
	public String testFolders() {
		return "everyware/contacts/folder";
	}
	
	@PreAuthorize("hasAuthority('ADDRESSBOOK')")
	@RequestMapping("/contacts/{folderSn}")
	public String goContactsOut() {
		return "everyware/contacts/contactsOut";
	}
	
	@PreAuthorize("hasAuthority('ADDRESSBOOK')")
	@RequestMapping("/contacts/new")
	public String goContactOutForm() {
		return "everyware/contacts/contactsOutForm";
	}
//	
//	@PreAuthorize("hasAuthority('ADDRESSBOOK')")
//	@RequestMapping("/contacts/in/new")
//	public String goContactInForm() {
//		return "everyware/contacts/contactsInForm";
//	}
	
	@PreAuthorize("hasAuthority('ADDRESSBOOK')")
	@GetMapping("/tableTest")
	public String testTable(){
		return "everyware/contacts/tableTest";
	}
	
}
