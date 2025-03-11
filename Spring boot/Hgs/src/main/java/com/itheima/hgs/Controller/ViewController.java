package com.itheima.hgs.Controller;

import com.itheima.hgs.dao.User;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import java.io.IOException;

@Controller
public class ViewController {
    @PostMapping("/login")
    public String tologin(User user, Model model , HttpServletResponse response , HttpSession session) throws IOException {
        if("dst".equals(user.getUsername())&&"123".equals(user.getPassword())){
            session.setAttribute("user",user);
            response.sendRedirect("/houtai");
        }
        model.addAttribute("msg", "密码或账号错误");
        return "login";
    }
    @GetMapping("/login")
    public String login() {
        return "login";
    }


}
