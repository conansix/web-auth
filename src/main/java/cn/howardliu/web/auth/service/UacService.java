package cn.howardliu.web.auth.service;

import cn.howardliu.web.auth.pojo.AuthUserPojo;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import java.util.Set;

/**
 * <br/>created at 16-6-7
 *
 * @author liuxh
 * @since 1.2.0
 */
public interface UacService {
    AuthUserPojo getUserInfo(String username) throws UsernameNotFoundException;

    Set<GrantedAuthority> listAuthority(String username);

    boolean isValidate(String username, String password) throws Exception;
}
