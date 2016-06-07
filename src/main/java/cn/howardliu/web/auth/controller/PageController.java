package cn.howardliu.web.auth.controller;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * <br/>create at 16-2-25
 *
 * @author liuxh
 * @since 1.0.0
 */
@Controller
public class PageController {
    @RequestMapping("/login")
    public String login() {
        return "login";
    }

    @RequestMapping("index")
    public String index(Model model) {
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext()
                .getAuthentication()
                .getPrincipal();
        model.addAttribute("username", userDetails.getUsername());
        return "index";
    }
}
