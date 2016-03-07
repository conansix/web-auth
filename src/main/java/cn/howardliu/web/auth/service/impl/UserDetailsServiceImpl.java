package cn.howardliu.web.auth.service.impl;

import cn.howardliu.web.auth.mapper.AuthAuthorityMapper;
import cn.howardliu.web.auth.mapper.AuthGroupMapper;
import cn.howardliu.web.auth.mapper.AuthUserMapper;
import cn.howardliu.web.auth.pojo.AuthAuthorityPojo;
import cn.howardliu.web.auth.pojo.AuthGroupPojo;
import cn.howardliu.web.auth.pojo.AuthUserPojo;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

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
    private AuthUserMapper userMapper;
    @Autowired
    private AuthGroupMapper groupMapper;
    @Autowired
    private AuthAuthorityMapper authorityMapper;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        AuthUserPojo userFound = userMapper.loadUserByUsername(username);
        if (userFound == null) {
            logger.debug("Query returned no results for user '" + username + "'");
            throw new UsernameNotFoundException("Username " + username + " not found");
        } else {
            List<AuthGroupPojo> groups = this.groupMapper.loadUserGroups(userFound);
            if (groups.size() > 0) {
                groups.stream()
                        .filter(group -> group.getGroupName().startsWith("ROLE_"))
                        .forEach(group -> userFound.getAuthorities()
                                .add(new SimpleGrantedAuthority(group.getGroupName())));
                List<AuthAuthorityPojo> authorities = this.authorityMapper.loadAuthorityOfGroups(groups);
                for (AuthAuthorityPojo authority : authorities) {
                    userFound.getAuthorities().add(new SimpleGrantedAuthority(authority.getAuthority()));
                }
            }
            HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes())
                    .getRequest();
            HttpSession session = request.getSession();
            session.setAttribute("userInfo", userFound);
            return userFound;
        }
    }
}
