package kr.or.everyware.mapper;

import kr.or.everyware.vo.Client;
import kr.or.everyware.vo.Employee;

public interface LoginMapper {

	Client readByClientId(String username);

	Employee readByEmployeeId(String username);

}
