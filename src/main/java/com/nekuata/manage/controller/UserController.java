package com.nekuata.manage.controller;

import com.nekuata.manage.domain.User;
import com.nekuata.manage.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Controller
@RequestMapping("/")
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping(value = "/signin", method = RequestMethod.GET)
    public String userSignInPage() {
        return "user/signin";
    }

    @RequestMapping(value = "/signin", method = RequestMethod.POST)
    public String userSignIn(HttpServletResponse resp, HttpSession session, User user, Integer remember) {
        // 判断用户名
        User realUser = userService.findUserByUserName(user.getUserName());
        // 判断密码
        if (realUser != null && realUser.getUserPassword().equals(user.getUserPassword())) {
            session.setAttribute("user", realUser);
            return "redirect:/panel";
        } else {
            try {
                resp.setContentType("text/html;charset=UTF-8");
                resp.getWriter().print("<script>alert('登陆失败，请检查用户名和密码！');history.go(-1);</script>");
            } catch (IOException e) {
                e.printStackTrace();
            }
            return null;
        }
    }

    @RequestMapping(value = "/signup", method = RequestMethod.GET)
    public String userSignUpPage() {
        return "user/signup";
    }

    @RequestMapping(value = "/signup", method = RequestMethod.POST)
    public String userSignUp(HttpServletResponse resp, HttpSession session, User user) {
        User realUser = userService.findUserByUserName(user.getUserName());
        // 如果用户名不存在则继续添加
        if (realUser == null) {
            // 返回添加后的用户
            realUser = userService.insertUser(user);
            // 添加成功，直接登录
            if (realUser != null) {
                session.setAttribute("user", realUser);
                return "redirect:/panel";
            }
        }
        try {
            resp.setContentType("text/html;charset=UTF-8");
            resp.getWriter().print("<script>alert('非酋你好！用户名大概已注册！');history.go(-1);</script>");
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    @RequestMapping(value = "/panel")
    public String userPanel(HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/signin";
        } else {
            return "panel/index";
        }
    }

    @RequestMapping
    public String index() {
        return "index";
    }

    @RequestMapping("/out")
    public String signOut(HttpSession httpSession) {
        httpSession.invalidate();
        return "redirect:/signin";
    }
}
