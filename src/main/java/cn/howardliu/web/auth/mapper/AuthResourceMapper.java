package cn.howardliu.web.auth.mapper;

import java.util.List;

/**
 * <br/>create at 16-2-25
 *
 * @author liuxh
 * @since 1.0.0
 */
public interface AuthResourceMapper {
    List<String> loadResourcesByAuthority(String authority);
}
