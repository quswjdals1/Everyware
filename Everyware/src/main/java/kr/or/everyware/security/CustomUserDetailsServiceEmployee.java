package kr.or.everyware.security;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import kr.or.everyware.mapper.LoginMapper;
import kr.or.everyware.vo.CustomUserEmployee;
import kr.or.everyware.vo.Employee;

public class CustomUserDetailsServiceEmployee implements UserDetailsService{
	
	private static final Logger log = LoggerFactory.getLogger(CustomUserDetailsServiceEmployee.class);
	
	@Inject
	private BCryptPasswordEncoder pe;
	
	@Inject
	private LoginMapper mapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		// 인코딩된 비밀번호를 알아봅시다.
		
		log.info("load user by username : "+username);
		
		// userName 은 사용자명이 아니라 사용자 아이디를 의미한다.
		// member를 가지고 최종 리턴해서 넘겨야할 userDetails를 만들어 준다.
		Employee employee;
		try {
			employee = mapper.readByEmployeeId(username);
			log.info("query by member mapper : "+employee);
			return employee==null?null : new CustomUserEmployee(employee);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
