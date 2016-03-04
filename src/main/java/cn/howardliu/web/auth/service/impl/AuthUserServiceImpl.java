package cn.howardliu.web.auth.service.impl;

import cn.howardliu.web.auth.mapper.AuthUserMapper;
import cn.howardliu.web.auth.pojo.AuthUserPojo;
import cn.howardliu.web.auth.service.AuthUserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <br/>create at 16-3-4
 *
 * @author liuxh
 * @since 1.0.0
 */
@Service("authUserService")
public class AuthUserServiceImpl implements AuthUserService {
    private static final Logger logger = LoggerFactory.getLogger(AuthUserServiceImpl.class);
    @Autowired
    private AuthUserMapper authUserMapper;

    @Override
    public AuthUserPojo getUserInfo(String userId) {
        return authUserMapper.getUserById(userId);
    }
}
