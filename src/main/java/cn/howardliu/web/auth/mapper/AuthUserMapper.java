package cn.howardliu.web.auth.mapper;

import cn.howardliu.web.auth.pojo.AuthUserPojo;

/**
 * <br/>create at 16-2-25
 *
 * @author liuxh
 * @since 1.0.0
 */
public interface AuthUserMapper {
    AuthUserPojo loadUserByUsername(String username);
}
