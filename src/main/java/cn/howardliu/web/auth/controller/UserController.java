package cn.howardliu.web.auth.controller;

import cn.howardliu.web.auth.pojo.AuthAuthorityPojo;
import cn.howardliu.web.auth.pojo.AuthGroupPojo;
import cn.howardliu.web.auth.pojo.AuthResourcePojo;
import cn.howardliu.web.auth.pojo.AuthUserPojo;
import cn.howardliu.web.auth.service.AuthUserService;
import com.alibaba.fastjson.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

import static java.util.stream.Collectors.toList;

/**
 * <br/>create at 16-3-4
 *
 * @author liuxh
 * @since 1.0.0
 */
@Controller
@RequestMapping("/user")
public class UserController {
    private static final Logger logger = LoggerFactory.getLogger(UserController.class);
    @Autowired
    private AuthUserService authUserService;

    @RequestMapping("/authTree")
    @ResponseBody
    public JSONObject getUserAuthTree(HttpSession session) {
        JSONObject json = new JSONObject();
        try {
            AuthUserPojo userFound = (AuthUserPojo) session.getAttribute("userInfo");
            if (userFound == null) {
                throw new AccessDeniedException("you have to login");
            }
            json = userInfo2D3SwitchJson(authUserService.getUserInfo(userFound.getUserId() + ""));
        } catch (Exception e) {
            logger.error("读取用户权限树失败", e);
        }
        return json;
    }

    private JSONObject userInfo2D3SwitchJson(AuthUserPojo user) {
        JSONObject json = new JSONObject();
        String userId = user.getUserId() + "";
        json.put("id", userId);
        json.put("name", user.getUsername());
        if (!user.getGroups().isEmpty()) {
            List<Object> list = user.getGroups().stream()
                    .map(group -> group2Json(userId, group)).collect(toList());
            json.put("children", list);
        }
        return json;
    }

    private JSONObject group2Json(String preId, AuthGroupPojo group) {
        JSONObject json = new JSONObject();
        String groupPreId = preId + group.getGroupId();
        json.put("id", groupPreId);
        json.put("name", group.getGroupName());
        if (!group.getAuthorities().isEmpty()) {
            List<JSONObject> list = group.getAuthorities().stream()
                    .map(authority -> authority2Json(groupPreId, authority)).collect(toList());
            json.put("children", list);
        }
        return json;
    }

    private JSONObject authority2Json(String preId, AuthAuthorityPojo authority) {
        JSONObject json = new JSONObject();
        String authorityPreId = preId + authority.getAuthorityId();
        json.put("id", authorityPreId);
        json.put("name", authority.getAuthority());
        if (!authority.getResources().isEmpty()) {
            List<Object> list = authority.getResources().stream()
                    .map(resource -> resource2Json(authorityPreId, resource)).collect(toList());
            json.put("children", list);
        }
        return json;
    }

    private JSONObject resource2Json(String preId, AuthResourcePojo resource) {
        JSONObject json = new JSONObject();
        json.put("id", preId + resource.getResourceId());
        json.put("name", resource.getResource());
        return json;
    }
}
