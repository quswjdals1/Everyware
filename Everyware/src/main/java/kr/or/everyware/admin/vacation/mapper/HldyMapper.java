package kr.or.everyware.admin.vacation.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.everyware.admin.vacation.vo.Hldy;

@Mapper
public interface HldyMapper {

	public int addHldy(Hldy hldy);

	public List<Hldy> getHldy(String custId);

	public int delWorkYear(int hldyNo);

	public int delHldy(int hldyNo);

	public int editHldy(Hldy hldy);

}
