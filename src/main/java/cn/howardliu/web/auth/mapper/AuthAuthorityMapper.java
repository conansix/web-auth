package cn.howardliu.web.auth.mapper;

import cn.howardliu.web.auth.pojo.AuthAuthorityPojo;
import cn.howardliu.web.auth.pojo.AuthGroupPojo;

import java.util.List;

/**
 * <br/>create at 16-2-25
 *
 * @author liuxh
 * @since 1.0.0
 */
public interface AuthAuthorityMapper {
    List<AuthAuthorityPojo> loadAuthorityOfGroups(List<AuthGroupPojo> groups);

    List<String> loadAllAuthorities();

    List<AuthAuthorityPojo> listAuthoritiesByGroupId(String groupId);
}
