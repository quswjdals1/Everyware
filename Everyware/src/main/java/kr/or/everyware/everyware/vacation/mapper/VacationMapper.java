package kr.or.everyware.everyware.vacation.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.everyware.admin.vacation.vo.VacItem;
import kr.or.everyware.everyware.vacation.vo.Vacation;
import kr.or.everyware.everyware.vacation.vo.VacationPaging;

@Mapper
public interface VacationMapper {

	public int getTotalRecord(Vacation vacation);

	public List<Vacation> getVacationList(Vacation vacation);

	public List<VacItem> getVacItem(Vacation vacation);

	public int getTotal(Vacation vacation);

	public int getProgress(Vacation vacation);

	public int getApproved(Vacation vacation);

	public int getRejected(Vacation vacation);

	public List<Vacation> getVacationJson(String empId);

	public int getTotalRecord(String empId);

	public int getProgressCount(String empId);

	public int getApprovedCount(String empId);

	public int getRejectedCount(String empId);

	// 관리자
	public List<Vacation> getVacationAdminJson(String custId);

	public int getTotalRecordAdmin(String custId);

	public int getProgressCountAdmin(String custId);

	public int getApprovedCountAdmin(String custId);

	public int getRejectedCountAdmin(String custId);

}
