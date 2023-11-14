package kr.or.everyware.security;

import java.io.IOException;
import java.net.InetAddress;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import com.maxmind.geoip2.model.CityResponse;
import com.maxmind.geoip2.model.CountryResponse;

import kr.or.everyware.login.mapper.LoginMapper;
import kr.or.everyware.login.vo.CustomUserClient;
import kr.or.everyware.login.vo.CustomUserEmployee;
import kr.or.everyware.login.vo.LoginLog;

public class CustomLoginSuccessHandlerClient extends SavedRequestAwareAuthenticationSuccessHandler{
	
	private static final Logger log = LoggerFactory.getLogger(CustomLoginSuccessHandlerClient.class);
	
	@Inject
	LoginMapper mapper;
	@Inject
	GeoReader reader;
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws ServletException, IOException {
		

        	setDefaultTargetUrl("/everysolution/home");	// 나중에 관리자 메인페이지로 이동하도록 변경해야함
        									// 그룹웨어에 클라이언트가 로그인한 경우 바로 관리자페이지 이동
		super.onAuthenticationSuccess(request, response, authentication);
	}
	
	
}
