package com.movielike.app.controller;
// 기존의 import 및 다른 코드...

import com.movielike.app.dao.UserDao;
import com.movielike.app.domain.UserDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/login")
public class LoginController {

    @Autowired
    private UserDao userDao;

    private String movId = "";

    // 로그인 폼을 보여주는 메서드
    @GetMapping("/login")
    public String loginForm(String prevMovId) {
        movId = prevMovId;
        return "Movie_Like_login";
    }

    // 로그아웃 처리를 하는 메서드
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        // 세션 무효화 후 홈페이지로 리다이렉트
        session.invalidate();
        return "redirect:/";
    }

    // 로그인 처리를 하는 메서드
    @PostMapping("/login")
    public String login(String id, String pw, String Nickname, boolean rememberId, Model model,
                        HttpServletResponse response, HttpServletRequest request, String prevPage) {
        try {
            // 로그인 체크 메서드 호출
            String loginResult = loginChk(id, pw);

            // 로그인 실패 시 에러 메시지를 모델에 추가하고 로그인 폼으로 이동
            if (!"success".equals(loginResult)) {
                model.addAttribute("error", loginResult);
                return "Movie_Like_login";
            }

            // 로그인 성공 시 쿠키 생성
            Cookie cookie = new Cookie("liogdinc", id);
            cookie.setMaxAge(rememberId ? 60 * 60 * 24 * 364 * 10 : 0);
            cookie.setPath("/");
            response.addCookie(cookie);

            // 사용자 정보 조회
            UserDto loginUserInfo = userDao.selectUser(id, pw);

            // 세션에 사용자 정보 저장
            HttpSession session = request.getSession();
            session.setAttribute("liogdin", loginUserInfo.getUserId());
            session.setAttribute("liogdinn", loginUserInfo.getUserNickname());
            session.setAttribute("liogdine", loginUserInfo.getUserEmail());

            // 세션 값 확인
            checkSession(request);

            // 출력: 이메일 추가
            String storedeEmail = (String) session.getAttribute("liogdine");
            System.out.println("Logged in with email " + storedeEmail);
            System.out.println("prevPage "+ prevPage);

            // 이전 페이지로 리다이렉트 또는 기본적으로 홈페이지로 리다이렉트
            prevPage = (prevPage == null || prevPage.trim().isEmpty()) ? "/" : prevPage.trim().replace(",", "");
            if(movId != null && !("".equals(movId))) {
                prevPage = "http://localhost:8080/app/movie/detail?movId="+ movId;
            }
            return "redirect:" + prevPage;
        } catch (Exception e) {
            // 예외 처리
            e.printStackTrace();
            model.addAttribute("error", "로그인 중 오류가 발생했습니다.");
            return "Movie_Like_login";
        }
    }

    // 세션에서 ID와 닉네임을 읽어오는 코드
    private void checkSession(HttpServletRequest request) {
        System.out.println("checkSession 123"); // 디버깅용 출력 checkSession 메서드 호출
        HttpSession session = request.getSession();
        if (session == null) {
            System.out.println("404"); // 디버깅용 출력 세션을 찾을 수 없을때 404가 출력
            return;
        }

        // 세션에서 liogdin 속성 값 가져오기
        Object storedIdObject = session.getAttribute("liogdin");
        String storedId = null;

        // liogdin이 Integer 타입인지 확인 후 String으로 변환
        if (storedIdObject instanceof Integer) {
            storedId = String.valueOf((Integer) storedIdObject);
        } else if (storedIdObject instanceof String) {
            storedId = (String) storedIdObject;
        }

        // 세션에서 liogdinn 속성 값 가져오기
        String storedNickname = (String) session.getAttribute("liogdinn");
        String storedEmail = (String) session.getAttribute("liogdine");

        // 세션에 저장된 ID와 닉네임 출력
        if (storedId != null && storedNickname != null ) {
            System.out.println("login success! ID: " + storedId + ", nickname: " + storedNickname + ", email: " + storedEmail);
            System.out.println("hello, " + storedNickname + " user!"); // 로그인 성공 시 닉네임 추가된 환영 메시지;
        } else {
            System.out.println("not find login info."); //로그인 정보가 없을 때 출력
        }
    }

    // 로그인 체크 메서드
    private String loginChk(String id, String pw) {

        // 사용자 정보 조회
        UserDto user = userDao.selectUser(id, pw);

        // 사용자 정보가 없거나 비밀번호가 일치하지 않으면 에러 메시지 반환
        if (user == null || !user.getUserPw().equals(pw)) {
            return "일치하는 회원정보가 없습니다.";
        }

        // 로그인 성공을 나타내는 문자열 반환
        return "success";
    }
}