package com.movielike.app.controller;

import com.movielike.app.dao.UserDao;
import com.movielike.app.dao.UserGenreDao;
import com.movielike.app.domain.UserDto;
import com.movielike.app.domain.UserGenreDto;
import com.movielike.app.service.AjaxService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;


@Controller
public class JoinController {

    @Autowired
    UserDao userDao;
    @Autowired
    UserGenreDao userGenreDao;
    @Autowired
    AjaxService ajaxService;

    @GetMapping("/signUp/add")
    public String showMovieAdd() {
        return "Movie_Like_join";
    }

    @PostMapping("/signUp/save")
    public String showMovieSave(UserDto userDto, String userPhone2, String userPhone3,
                                String userBirth1, String userBirth2, String userBirth3, String userNickname, int [] genr_arr) {
        // 번호 합쳐서 넣기
        String userPhone = "010-" + userPhone2 + "-" + userPhone3;
        userDto.setUserPhone(userPhone);

        //생년월일
        Date date = new Date();
        date.setYear(Integer.parseInt(userBirth1) - 1900);
        date.setMonth(Integer.parseInt(userBirth2) - 1);
        date.setDate(Integer.parseInt(userBirth3));
        userDto.setUserBirth(new java.sql.Date(date.getTime()));

        userDto.setUserNickname(userNickname);
        /* 회원가입 시키기 */
        userDao.insertUser(userDto);
        int userId = userDao.selectUserId(userDto.getUserEmail());

        if(genr_arr != null && genr_arr.length != 0 ) {
            List<UserGenreDto> userGenreDtoList = new ArrayList<UserGenreDto>();
            for (int genr_no : genr_arr) {
                UserGenreDto userGenreDto = new UserGenreDto(genr_no, userId);
                userGenreDtoList.add(userGenreDto);
            }
            System.out.println(userGenreDtoList);
            userGenreDao.insertUserGenre(userGenreDtoList);
        }
        return "redirect:/login/login";
    }

    // 아이디 중복체크 ajax
    @PostMapping("/checkId")
    @ResponseBody
    public int checkId(@RequestParam("userEmail") String email) {
        int cnt = ajaxService.checkId(email);
        return cnt;
    }

    // 닉네임 중복체크 ajax
    @PostMapping("/checkNick")
    @ResponseBody
    public int checkNick (@RequestParam("userNickname") String nickname) {
        int cnt = ajaxService.checkNick(nickname);
        return cnt;
    }

    // 전화번호 중복체크 ajax
    @PostMapping("/checkPhone")
    @ResponseBody
    public int checkPhone (@RequestParam("userPhone") String phone) {
        int cnt = ajaxService.checkPhone(phone);
        return cnt;
    }
}
