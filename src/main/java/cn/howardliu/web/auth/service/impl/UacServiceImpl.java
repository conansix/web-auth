package cn.howardliu.web.auth.service.impl;

import cn.howardliu.web.auth.httpclient.simple.SimpleHttpRequester;
import cn.howardliu.web.auth.pojo.AuthUserPojo;
import cn.howardliu.web.auth.service.UacService;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

/**
 * <br/>created at 16-6-7
 *
 * @author liuxh
 * @since 1.2.0
 */
@Service("uacService")
public class UacServiceImpl implements UacService {
    private static final Logger logger = LoggerFactory.getLogger(UacServiceImpl.class);
    @Value("${common.uac.url}")
    private String uacUrlPre;

    @Override
    public AuthUserPojo getUserInfo(String username) throws UsernameNotFoundException {
        AuthUserPojo userFound = null;
        try {
            Map<String, String> params = new HashMap<>();
            params.put("uid", username);
            JSONObject roleData = JSONObject
                    .parseObject(SimpleHttpRequester.getHttpRequester().get(uacUrlPre + "/api/getUserDetailByUid.do", params));
            if (roleData != null && roleData.containsKey("success") && roleData.getBoolean("success")) {
                JSONObject result = roleData.getJSONObject("data");
                userFound = new AuthUserPojo();
                userFound.setUsername(result.getString("uid"));
                userFound.setPassword(result.getString("password"));
                userFound.setEnabled(true);
            }
        } catch (Exception e) {
            throw new UsernameNotFoundException("Username " + username + " not found");
        }
        return userFound;
    }

    @Override
    public Set<GrantedAuthority> listAuthority(String username) {
        Set<GrantedAuthority> authorities = new HashSet<>();
        try {
            Map<String, String> params = new HashMap<>();
            params.put("userId", username);
            JSONObject roleData = JSONObject
                    .parseObject(SimpleHttpRequester.getHttpRequester().get(uacUrlPre + "/api/findRolesByUserId.do", params));
            if (roleData != null && roleData.containsKey("success") && roleData.getBoolean("success")) {
                JSONArray result = roleData.getJSONArray("result");
                for (int i = 0; i < result.size(); i++) {
                    authorities.add(new SimpleGrantedAuthority(result.getJSONObject(i).getString("cn")));
                }
            }
        } catch (Exception e) {
            logger.error("查询Username={}的权限列表失败", username, e);
        }
        return authorities;
    }

    @Override
    public boolean isValidate(String username, String password) throws Exception {
        Map<String, String> params = new HashMap<>();
        params.put("username", username);
        params.put("password", password);
        JSONObject roleData = JSONObject
                .parseObject(SimpleHttpRequester.getHttpRequester().get(uacUrlPre + "/validate/validateUser.do", params));
        return roleData != null && roleData.containsKey("success") && roleData.getBoolean("success");
    }
}
