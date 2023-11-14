package kr.or.everyware.admin.vacation.service;

import java.util.List;

import kr.or.everyware.ServiceResult;
import kr.or.everyware.admin.vacation.vo.Hldy;

public interface HldyService {

	public ServiceResult addHldy(Hldy hldy);

	public List<Hldy> getHldy(String custId);

	public int delWorkYear(int hldyNo);

	public int delHldy(int hldyNo);

	public ServiceResult editHldy(Hldy hldy);

}
