package kr.or.everyware.security;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.security.web.authentication.logout.LogoutHandler;

public class CustomAccessDeniedHandler implements AccessDeniedHandler{

	private static final Logger log = LoggerFactory.getLogger(CustomAccessDeniedHandler.class);
	
	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response,
			AccessDeniedException accessDeniedException) throws IOException, ServletException {
		// TODO Auto-generated method stub
		log.info("[CustomAccessDenied 발동!] 접근이 거부되었습니다!");
		String page="/deniedpage";
		String uri = request.getRequestURI();
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        List<GrantedAuthority> authorities = (List<GrantedAuthority>) authentication.getAuthorities();
        boolean flag = false;
        for (GrantedAuthority authority : authorities) {
            if(authority.getAuthority().equals("custauth") && uri.contains("everyware")) {
            	request.getSession().invalidate();
            	flag=true;
            	break;
            }else if(authority.getAuthority().equals("default") && uri.contains("everysolution")) {
            	request.getSession().invalidate();
            	flag=true;
            	break;
            }
            
        }
		
		if(flag) {
			response.sendRedirect(uri);
		}else {
			response.sendRedirect("/");
		}
	}

}
