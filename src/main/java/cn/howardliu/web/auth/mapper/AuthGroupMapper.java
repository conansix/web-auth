package cn.howardliu.web.auth.mapper;

import cn.howardliu.web.auth.pojo.AuthGroupPojo;
import cn.howardliu.web.auth.pojo.AuthUserPojo;

import java.util.List;

/**
 * <br/>create at 16-2-25
 *
 * @author liuxh
 * @since 1.0.0
 */
public interface AuthGroupMapper {
    List<AuthGroupPojo> loadUserGroups(AuthUserPojo user);
}
