package com.example.snslogin_server.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.JsonNode;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Map;

@Controller
public class MainController
{
    @Autowired
    KakaoService kakaoService;

    @RequestMapping("kakao/sign_in")
    public String kakaoSignIn(@RequestParam("code") String code) {
        System.out.println("kakaoSignIn");
        Map<String,Object> result = kakaoService.execKaKaoLogin(code);
        return "redirect:webauthcallback://success?customToken="+result.get("customToken").toString();
    }
}
