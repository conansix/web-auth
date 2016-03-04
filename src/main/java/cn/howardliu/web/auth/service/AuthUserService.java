package cn.howardliu.web.auth.service;

import cn.howardliu.web.auth.pojo.AuthUserPojo;

/**
 * <br/>create at 16-3-4
 *
 * @author liuxh
 * @since 1.0.0
 */
public interface AuthUserService {
    AuthUserPojo getUserInfo(String userId);
}
