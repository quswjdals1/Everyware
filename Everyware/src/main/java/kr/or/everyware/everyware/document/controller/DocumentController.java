package kr.or.everyware.everyware.document.controller;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.time.LocalDate;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.admin.approval.service.IAdminApprovalService;
import kr.or.everyware.admin.approval.vo.ApprovalConfig;
import kr.or.everyware.everyware.document.mapper.DocumentMapper;
import kr.or.everyware.everyware.document.service.IDocumentService;
import kr.or.everyware.everyware.document.service.ITemplateService;
import kr.or.everyware.everyware.document.vo.ApprovalLine;
import kr.or.everyware.everyware.document.vo.Document;
import kr.or.everyware.everyware.document.vo.Proxy;
import kr.or.everyware.everyware.document.vo.Template;
import kr.or.everyware.everyware.vacation.vo.Vacation;
import kr.or.everyware.login.vo.CustomUserEmployee;
import kr.or.everyware.login.vo.Employee;
import kr.or.everyware.util.attachment.AttachFileValidate;
import kr.or.everyware.util.attachment.vo.AttachFile;
import kr.or.everyware.util.fileUtils.UploadFileUtils;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/everyware")
@Slf4j
public class DocumentController {

	@Autowired
	private IDocumentService documentService;
	@Autowired
	private IAdminApprovalService adminApprovalService;
	@Autowired
	private Gson gson;
	@Autowired
	private WebApplicationContext context;
	@Autowired
	private ITemplateService templateService;
	
	@Resource(name = "uploadPath")
	private String resourcePath;
	@Autowired
	AttachFileValidate attachService;
	

	@PreAuthorize("hasAuthority('APPROVAL')")
	@GetMapping(value = {"/approval/{aprvSn}", "/approval"})
	public String goDocumentList(@PathVariable(value = "aprvSn", required = false) Integer aprvSn, Model model) {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		String empId = employee.getEmpId();
		int deptId = employee.getDeptId();
		
		
		if(aprvSn != null) {
			aprvSn = aprvSn.intValue();
//			Document document = null;
//			log.info("aprvSn: " + aprvSn);
//			
//			String custId = employee.getCustId();
//			
//			ApprovalConfig config = adminApprovalService.getConfig(custId);
//			
//			Map<String,Object> map = new HashMap<String, Object>();
//			map.put("empId", empId);
//			map.put("aprvSn", aprvSn);
//			List<ApprovalLine> permission = documentService.getMyPermission(map);
//			
//			document = documentService.getDocument(aprvSn);
//			log.info(document.toString());
//			
//			document.setConfig(config);
//			document.setMyPermission(permission);
//			document.setCurrentEmpId(empId);
//			
////			log.info(jsonData);
			model.addAttribute("aprvSn", aprvSn);
		} else {
			log.info("결재현황");
			
			// 자주 사용하는 양식 4가지
			List<Template> tmpltList =  documentService.getTemplateRecentlyUsed(empId);
			
			
			/* 결재현황 */
			
			// 결재
			Document doc = new Document();
			doc.setEmpId(empId);
			List<Document> pendingList = documentService.getDocumentListWithPending(doc);
			int scheduledCnt = documentService.getCountDocumentListWithScheduled(empId);
			int completedCnt = documentService.getCountDocumentListWithCompleted(empId);
			
			// 읽음
			List<Document> notReadList = documentService.getDocumentListWithNotRead(empId);
			int notReadAsViewerCnt = documentService.getCountDocumentListWithViewer(empId);
			int notReadAsReferencerCnt = documentService.getCountDocumentListWithReference(empId);
			
			// 기안
			List<Document> inProcessList = documentService.getDocumentListWithOnProcess(empId);
			int confirmedCnt = documentService.getCountDocumentWithConfirmed(empId);
			int rejectedCnt = documentService.getCountDocumentWithRejected(empId);
			
			// 최근 부서수신 5건
			List<Document> recentList = documentService.getDocumentListWithDepartmentRecently5(deptId);
			
			model.addAttribute("tmpltList", tmpltList);
			model.addAttribute("pendingList", pendingList);
			model.addAttribute("scheduledCnt", scheduledCnt);
			model.addAttribute("completedCnt", completedCnt);
			model.addAttribute("notReadList", notReadList);
			model.addAttribute("notReadAsViewerCnt", notReadAsViewerCnt);
			model.addAttribute("notReadAsReferencerCnt", notReadAsReferencerCnt);
			model.addAttribute("inProcessList", inProcessList);
			model.addAttribute("confirmedCnt", confirmedCnt);
			model.addAttribute("rejectedCnt", rejectedCnt);
			model.addAttribute("recentList", recentList);
		}
		
		model.addAttribute("approvalActive", "active");
		log.info(model.toString());
		
		return "everyware/document/list";
	}

	@PreAuthorize("hasAuthority('APPROVAL')")
	@RequestMapping(value = "/approval/new/{tmpltCd}", method = {RequestMethod.GET, RequestMethod.POST})
	@PostMapping("/approval/new/{tmpltCd}")
	public String goForm(Model model, @PathVariable("tmpltCd") int TmpltCd, @RequestParam(required = false) Map<String, String> jsonMap) 
			throws IllegalAccessException, IllegalArgumentException, InvocationTargetException, NoSuchMethodException, SecurityException {
		
		if(jsonMap != null) {
			log.info(jsonMap.toString());
		}
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();

		String empId = employee.getEmpId();
		String custId = employee.getCustId();
		
		// 결재 설정
		ApprovalConfig config = adminApprovalService.getConfig(custId);
		model.addAttribute("config", config);
		
		// 템플릿
		Template template = documentService.getTemplate(TmpltCd);
		model.addAttribute("template", template);
		
		
		// 템플릿에 따른 필요 객체
		if(TmpltCd == 2) {
			List<Vacation> itemList = templateService.getVacationItems(custId);
			model.addAttribute("itemList", itemList);
		}
		
		
		model.addAttribute("myinfo", employee);
		model.addAttribute("map", gson.toJson(jsonMap));
		
		return "everyware/document/write";
	}
	
	@PreAuthorize("hasAuthority('APPROVAL')")
	@PostMapping("/documents/edit/{status}")
	public String goDocumentModifyForm(@PathVariable("status") String status, Model model, int aprvSn) {
		//TODO 문서 수정폼 이동
		//TODO 수정인지 재기안인지..... 분별 가능하도록 전달하기
		log.info("수정 컨트롤러");

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
 
		String custId = employee.getCustId();
		
		// 결재 설정
		ApprovalConfig config = adminApprovalService.getConfig(custId);
		model.addAttribute("config", config);
		
		Document document = documentService.getDocument(aprvSn);
		model.addAttribute("document", document);
		
		Template template = documentService.getTemplate(document.getTmpltCd());
		model.addAttribute("template", template);
		model.addAttribute("status", status);
		
		log.info(document.toString());
		
		return "everyware/document/write";
	}

	@PreAuthorize("hasAuthority('APPROVAL')")
	@PostMapping(value = "/documents")
	@ResponseBody
	public String addDocument(@RequestBody Document document) {

		// TODO 파일 첨부 추가

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();

		String empId = employee.getEmpId();
		String custId = employee.getCustId();
		String conm = employee.getConm();
		String deptNm = employee.getDeptNm();
		document.setEmpId(empId);
		document.setCustId(custId);
		document.setConm(conm);
		document.setDeptNm(deptNm);
		
		ApprovalConfig config = adminApprovalService.getConfig(custId);
		
		ServiceResult result = documentService.addDocument(document, config);
		
		int aprvSn = document.getAprvSn();
		
		return aprvSn + "";
	}
	
	@PreAuthorize("hasAuthority('APPROVAL')")
	@PutMapping(value = "/documents")
	@ResponseBody
	public String editDocument(@RequestBody Document document) {
		
		// TODO 파일 첨부 추가
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
//		ApprovalConfig config = adminApprovalService.getConfig(custId);
		
		ServiceResult result = documentService.editDocument(document);
		
		int aprvSn = document.getAprvSn();
		
		return aprvSn + "";
	}

	@PreAuthorize("hasAuthority('APPROVAL')")
	@PostMapping(value = "/documents/pending", produces = "application/text; charset=utf8")
	@ResponseBody
	public String getDocumentListWithPending(@RequestBody Document doc) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();

		String empId = employee.getEmpId();

		doc.setEmpId(empId);

		List<Document> docList = documentService.getDocumentListWithPending(doc);
		String tbodyData = generateTbody(docList);

		return tbodyData;
	}

	@PreAuthorize("hasAuthority('APPROVAL')")
	@PostMapping(value = "/documents/scheduled", produces = "application/text; charset=utf8")
	@ResponseBody
	public String getDocumentListWithScheduled(@RequestBody Document doc) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();

		String empId = employee.getEmpId();

		doc.setEmpId(empId);

		List<Document> docList = documentService.getDocumentListWithScheduled(doc);
		String tbodyData = generateTbody(docList);

		return tbodyData;
	}

	@PreAuthorize("hasAuthority('APPROVAL')")
	@PostMapping(value = "/documents/completed", produces = "application/text; charset=utf8")
	@ResponseBody
	public String getDocumentListWithCompleted(@RequestBody Document doc) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();

		String empId = employee.getEmpId();

		doc.setEmpId(empId);

		List<Document> docList = documentService.getDocumentListWithCompleted(doc);
		String tbodyData = generateTbody(docList);

		return tbodyData;
	}

	@PreAuthorize("hasAuthority('APPROVAL')")
	@PostMapping(value = "/documents/department", produces = "application/text; charset=utf8")
	@ResponseBody
	public String getDocumentListWithDepartment(@RequestBody Document doc) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();

		int deptId = employee.getDeptId();

		doc.setDeptId(deptId);

		List<Document> docList = documentService.getDocumentListWithDepartment(doc);
		String tbodyData = generateTbody(docList);

		return tbodyData;
	}

	@PreAuthorize("hasAuthority('APPROVAL')")
	@PostMapping(value = "/documents/reference", produces = "application/text; charset=utf8")
	@ResponseBody
	public String getDocumentListWithReference(@RequestBody Document doc) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();

		String empId = employee.getEmpId();

		doc.setEmpId(empId);

		List<Document> docList = documentService.getDocumentListWithReference(doc);
		String tbodyData = generateTbody(docList);

		return tbodyData;
	}

	@PreAuthorize("hasAuthority('APPROVAL')")
	@PostMapping(value = "/documents/drafts", produces = "application/text; charset=utf8")
	@ResponseBody
	public String getDocumentListWithDrafts(@RequestBody Document doc) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();

		String empId = employee.getEmpId();
		doc.setEmpId(empId);

		List<Document> docList = documentService.getDocumentListWithDrafts(doc);
		String tbodyData = generateTbody(docList);

		return tbodyData;
	}

	@PreAuthorize("hasAuthority('APPROVAL')")
	@PostMapping(value = "/documents/temp", produces = "application/text; charset=utf8")
	@ResponseBody
	public String getDocumentListWithTemp(@RequestBody Document doc) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();

		String empId = employee.getEmpId();

		doc.setEmpId(empId);

		List<Document> docList = documentService.getDocumentListWithTemp(doc);
		String tbodyData = generateTbody(docList);

		return tbodyData;
	}

	@PreAuthorize("hasAuthority('APPROVAL')")
	@PostMapping(value = "/documents/scraps", produces = "application/text; charset=utf8")
	@ResponseBody
	public String getDocumentListWithScraps(@RequestBody Document doc) {
		log.info("스크랩리스트");
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();

		String empId = employee.getEmpId();

		doc.setEmpId(empId);
		log.info(doc.toString());

		List<Document> docList = documentService.getDocumentListWithScraps(doc);
		log.info(docList.toString());
		String tbodyData = generateTbody(docList);

		return tbodyData;
	}

	@PreAuthorize("hasAuthority('APPROVAL')")
	@PostMapping(value = "/documents/shared", produces = "application/text; charset=utf8")
	@ResponseBody
	public String getDocumentListWithShared(@RequestBody Document doc) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();

		String empId = employee.getEmpId();

		doc.setEmpId(empId);

		List<Document> docList = documentService.getDocumentListWithShared(doc);
		String tbodyData = generateTbody(docList);

		return tbodyData;
	}

	@PreAuthorize("hasAuthority('APPROVAL')")
	@GetMapping("/approval/proxy")
	public String goProxy() {
		return "everyware/document/proxy";
	}

	@PreAuthorize("hasAuthority('APPROVAL')")
	@GetMapping("/templates")
	@ResponseBody
	public String getTemplateList() {
		List<Template> list = documentService.getTemplateList();
		String jsonData = gson.toJson(list);
		return jsonData;
	}

	@PreAuthorize("hasAuthority('APPROVAL')")
	@GetMapping("/templates/{tmpltCd}")
	@ResponseBody
	public String getTemplate(@PathVariable("tmpltCd") int TmpltCd) {
		Template template = documentService.getTemplate(TmpltCd);
		String jsonData = gson.toJson(template);
		return jsonData;
	}

	@PreAuthorize("hasAuthority('APPROVAL')")
	@GetMapping("/documents/{aprvSn}")
	@ResponseBody
	public String getDocument(@PathVariable("aprvSn") int aprvSn) {
		// 문서 가져오기
		// TODO 문서 상태, 열람자 권한 조회 추가
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();

		String empId = employee.getEmpId();
		String custId = employee.getCustId();
		
		ApprovalConfig config = adminApprovalService.getConfig(custId);
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("empId", empId);
		map.put("aprvSn", aprvSn);
		List<ApprovalLine> permission = documentService.getMyPermission(map);
		
		
		Document doc = documentService.getDocument(aprvSn);
		doc.setConfig(config);
		doc.setMyPermission(permission);
		doc.setCurrentEmpId(empId);
		
		String jsonData = gson.toJson(doc);
		
		log.info(jsonData);

		return jsonData;
	}

	@PreAuthorize("hasAuthority('APPROVAL')")
	@GetMapping("/doc")
	public String goDocument() {
		return "everyware/document/list";
	}
	
	public String generateTbody(List<Document> docList) {
		StringBuilder builder = new StringBuilder();
		
		for(Document doc : docList) {
			builder.append("<tr>");
			builder.append("<td>");
			builder.append(doc.getAprvSn());
			builder.append("</td>");
			builder.append("<td>");
			if(doc.getAprvNo() != null) {
				builder.append(doc.getAprvNo());
			}else {
				builder.append("-");
			}
			builder.append("</td>");
			builder.append("<td>");
			builder.append(doc.getAprvTtl());
			builder.append("</td>");
			builder.append("<td>");
			builder.append(doc.getEmpName());
			builder.append("</td>");
			builder.append("<td>");
			builder.append(doc.getAtrzDmndDt());
			builder.append("</td>");
			builder.append("<td>");
			if(doc.getAtrzCmptnDt() != null) {
				builder.append(doc.getAtrzCmptnDt());
			}else {
				builder.append("-");
			}
			builder.append("</td>");
			builder.append("</tr>");
		}
		
		return builder.toString();
	}
	
	@PreAuthorize("hasAuthority('APPROVAL')")
	@PostMapping("/documents/scrap")
	@ResponseBody
	public String addScrapDocument(@RequestBody int aprvSn) {
		//TODO 스크랩 추가
		log.info("스크랩추가");
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();

		String empId = employee.getEmpId();
		
		Map<String,Object> map = new HashMap<>();
		map.put("empId", empId);
		map.put("aprvSn", aprvSn);
		
		ServiceResult result = documentService.addScrapDocument(map);
		log.info(result.toString());
		return null;
	}
	
	@PreAuthorize("hasAuthority('APPROVAL')")
	@DeleteMapping("/documents/scrap")
	@ResponseBody
	public String deleteScrapDocument(@RequestBody int aprvSn) {
		//TODO 스크랩 삭제
		log.info("스크랩삭제");
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		String empId = employee.getEmpId();
		
		Map<String,Object> map = new HashMap<>();
		map.put("empId", empId);
		map.put("aprvSn", aprvSn);
		
		ServiceResult result = documentService.deleteScrapDocument(map);
		return null;
	}
	
	@PreAuthorize("hasAuthority('APPROVAL')")
	@PostMapping("/documents/collect")
	@ResponseBody
	public String collectDocument(@RequestBody int aprvSn) {
		//TODO 문서 회수
		ServiceResult result = documentService.collectDocument(aprvSn);
		return null;
	}
	
	
	
	@PreAuthorize("hasAuthority('APPROVAL')")
	@PostMapping("/documents/share")
	@ResponseBody
	public String addShareDocument(@RequestBody List<Document> shareList) {
		//TODO 공유 문서 추가...
		//누구한테 전달할지 파라미터로 받아야함..!!!!!
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		ServiceResult result = documentService.addShareDocument(shareList);
		return null;
	}
	
	@PreAuthorize("hasAuthority('APPROVAL')")
	@DeleteMapping("/documents/share")
	@ResponseBody
	public String deleteShareDocument() {
		//TODO 공유 문서 삭제
		return null;
	}
	
	
	//////////////////////////////////
	@PreAuthorize("hasAuthority('APPROVAL')")
	@PostMapping(value = "/approval/proxy", produces = "application/json; charset=utf8")
	@ResponseBody
	public String addProxy(@RequestBody List<Proxy> proxyList) {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();

		String empId = employee.getEmpId();
		
		for(Proxy proxy : proxyList) {
			proxy.setEmpId(empId);
		}
		
		ServiceResult result = documentService.addProxy(proxyList);
		
		String jsonData = gson.toJson(proxyList);
		
		return jsonData;
	}
	
	@PreAuthorize("hasAuthority('APPROVAL')")
	@GetMapping(value = "/approval/proxy", produces = "application/json; charset=utf8")
	@ResponseBody
	public String getProxyList() {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		String empId = employee.getEmpId();
		
		List<Proxy> list = documentService.getProxyList(empId);
		String jsonData = gson.toJson(list);
		
		return jsonData;
	}
	
	@PreAuthorize("hasAuthority('APPROVAL')")
	@PatchMapping(value = "/approval/proxy")
	@ResponseBody
	public String deleteProxy(@RequestBody int proxyId) {
		ServiceResult result = documentService.deleteProxy(proxyId);
		return "";
	}
	
	@PreAuthorize("hasAuthority('APPROVAL')")
	@PostMapping(value = "/approval/verification")
	public ResponseEntity<ServiceResult> verifyApprover(@RequestBody String password){
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		String empPw = employee.getEmpPw();
		
		log.info("세션: " + empPw);
		
		log.info("비밀번호: " + password);
		
		if(empPw.equals(password)) {
			return new ResponseEntity<ServiceResult>(ServiceResult.OK, HttpStatus.OK);
		}
		
		return new ResponseEntity<ServiceResult>(ServiceResult.FAILED,HttpStatus.OK);
	}
	
	@PreAuthorize("hasAuthority('APPROVAL')")
	@PostMapping(value = "/approval/approval-process")
	@ResponseBody
	public String approvalProcess(@RequestBody ApprovalLine aprvLine) throws NoSuchMethodException, SecurityException, IllegalAccessException, IllegalArgumentException, InvocationTargetException {
		log.info("결재합니다~");
		// TODO 결재자 검증 로직 추가
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		
		String custId = employee.getCustId();
		
		ApprovalConfig config = adminApprovalService.getConfig(custId);
		
		String verifUseYn = config.getVerifUseYn();
		
		if(verifUseYn.equals("Y")) {
			return "Y";
		}
		
		
		String nextApprover = documentService.confirmProcess(aprvLine);
		
		Document doc = documentService.getDocument(aprvLine.getAprvSn());
//		log.info(doc.toString());
		
		String aprvNo = doc.getAprvNo();
		
		// 문서번호 채번
		if(aprvNo == null) {

			String empId = employee.getEmpId();
			String conm = employee.getConm();
			String deptNm = employee.getDeptNm();
			doc.setEmpId(empId);
			doc.setCustId(custId);
			doc.setConm(conm);
			doc.setDeptNm(deptNm);
			
			aprvNo = documentService.createAprvNo(doc, config);
			doc.setAprvNo(aprvNo);
			
			ServiceResult updateRslt = documentService.updateAprvNo(doc);
		}
		
		
		// 후처리 실행 결과 count
		if(doc.getJsonObject() != null) {
			int rsltCnt = processAfterApproval(aprvLine, doc);
		}
		
		int aprvSn = doc.getAprvSn();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("aprvSn", aprvSn);
		map.put("nextApprover", nextApprover);
		
		String jsonData = gson.toJson(map);
		
		return jsonData;
	}
	
	public int processAfterApproval(ApprovalLine aprvLine, Document doc) throws NoSuchMethodException, SecurityException, IllegalAccessException, IllegalArgumentException, InvocationTargetException {
		int rsltCnt = 0;
		String jsonObj = doc.getJsonObject();
		
		if (jsonObj == null) {
			return rsltCnt;
		}
		
		int sttsCd = aprvLine.getPrgrsSttsCd();
		
		
		
		// 서비스 클래스 이름
		String serviceClassNm = doc.getTemplate().getServiceClassNm();
		
		// 서비스 빈
		Object bean = context.getBean(serviceClassNm);
		log.info("bean: " + bean);
		
		Method method = null;
		
		if(sttsCd == 3) {
			// 승인후처리 메소드
			method = bean.getClass().getMethod("processAfterConfirm", String.class);
		}
		if(sttsCd == 4) {
			// 반려후처리 메소드
			method = bean.getClass().getMethod("processAfterReject", String.class);
		}
		
		log.info("method: " + method);
		
		// jsonObject를 파라미터로 메소드 실행
		rsltCnt = (int) method.invoke(bean, jsonObj);
		
		return rsltCnt;
	}
	
	@PreAuthorize("hasAuthority('APPROVAL')")
	@GetMapping("/approval/sign")
	public String goImage(Model model) {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		String empId = employee.getEmpId();
		
		ApprovalLine aprvLine = documentService.getSignImage(empId);
		
		if(aprvLine != null) {
			model.addAttribute("img", aprvLine.getEncodedImg());
		}
		
		return "everyware/document/signImageModal";
	}
	
	@PreAuthorize("hasAuthority('APPROVAL')")
	@PostMapping("/approval/sign")
	public String addSignImage(@RequestParam("image") MultipartFile file) {
		log.info(file.toString());
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		CustomUserEmployee customUser = (CustomUserEmployee) authentication.getPrincipal();
		Employee employee = customUser.getEmployee();
		String empId = employee.getEmpId();
		
		ApprovalLine aprvLine = new ApprovalLine();
		aprvLine.setEmpId(empId);
		aprvLine.setFile(file);
		
		ServiceResult result = documentService.addSignImage(aprvLine);
		return "everyware/document/signImageModal";
	}
	
}
