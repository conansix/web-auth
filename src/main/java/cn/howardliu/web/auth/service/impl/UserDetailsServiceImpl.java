package cn.howardliu.web.auth.service.impl;

import cn.howardliu.web.auth.pojo.AuthUserPojo;
import cn.howardliu.web.auth.service.UacService;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

/**
 * 扩展Spring Security中关于用户权限的控制
 * <br/>create at 15-7-3
 *
 * @author liuxh
 * @since 1.0.0
 */
@Service("userDetailsService")
public class UserDetailsServiceImpl implements UserDetailsService {
    private final Log logger = LogFactory.getLog(this.getClass());
    @Autowired
    private UacService uacService;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        AuthUserPojo userFound = uacService.getUserInfo(username);
        if (userFound == null) {
            logger.debug("Query returned no results for user '" + username + "'");
            throw new UsernameNotFoundException("Username " + username + " not found");
        }
        userFound.getAuthorities().addAll(uacService.listAuthority(username));
        return userFound;
    }
}
