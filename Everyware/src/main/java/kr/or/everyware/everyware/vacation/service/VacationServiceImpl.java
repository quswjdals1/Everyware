package kr.or.everyware.everyware.vacation.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.everyware.admin.vacation.vo.VacItem;
import kr.or.everyware.everyware.vacation.mapper.VacationMapper;
import kr.or.everyware.everyware.vacation.vo.Vacation;
import kr.or.everyware.everyware.vacation.vo.VacationPaging;

@Service
public class VacationServiceImpl implements VacationService{

	@Inject
	private VacationMapper vacationMapper;

	@Override
	public int getTotalRecord(Vacation vacation) {
		return vacationMapper.getTotalRecord(vacation);
	}

	@Override
	public List<Vacation> getVacationList(Vacation vacation) {
		return vacationMapper.getVacationList(vacation);
	}

	@Override
	public List<VacItem> getVacItem(Vacation vacation) {
		return vacationMapper.getVacItem(vacation);
	}

//	@Override
//	public int getTotal(Vacation vacation) {
//		return vacationMapper.getTotal(vacation);
//	}
//
//	@Override
//	public int getProgress(Vacation vacation) {
//		return vacationMapper.getProgress(vacation);
//	}
//
//	@Override
//	public int getApproved(Vacation vacation) {
//		return vacationMapper.getApproved(vacation);
//	}
//
//	@Override
//	public int getRejected(Vacation vacation) {
//		return vacationMapper.getRejected(vacation);
//	}

	@Override
	public int processAfterConfirm(String jsonObj) {
		return 0;
	}

	@Override
	public int processAfterReject(String jsonObj) {
		return 0;
	}

	@Override
	public List<Vacation> getVacationJson(String empId) {
		return vacationMapper.getVacationJson(empId);
	}

	@Override
	public int getTotalRecord(String empId) {
		return vacationMapper.getTotalRecord(empId);
	}

	@Override
	public int getProgressCount(String empId) {
		return vacationMapper.getProgressCount(empId);
	}

	@Override
	public int getApprovedCount(String empId) {
		return vacationMapper.getApprovedCount(empId);
	}

	@Override
	public int getRejectedCount(String empId) {
		return vacationMapper.getRejectedCount(empId);
	}

	@Override
	public List<Vacation> getVacationAdminJson(String custId) {
		return vacationMapper.getVacationAdminJson(custId);
	}

	@Override
	public int getTotalRecordAdmin(String custId) {
		return vacationMapper.getTotalRecordAdmin(custId);
	}

	@Override
	public int getProgressCountAdmin(String custId) {
		return vacationMapper.getProgressCountAdmin(custId);
	}

	@Override
	public int getApprovedCountAdmin(String custId) {
		return vacationMapper.getApprovedCountAdmin(custId);
	}

	@Override
	public int getRejectedCountAdmin(String custId) {
		return vacationMapper.getRejectedCountAdmin(custId);
	}
	

}
