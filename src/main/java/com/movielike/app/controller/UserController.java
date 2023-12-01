package com.movielike.app.controller;

import com.movielike.app.domain.UserDto;
import com.movielike.app.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.Map;

@Controller
public class UserController {

    @Autowired
    UserService userService;
    @GetMapping("/show/findEmail")
    public String showFindEmail() {
        return "find_id";
    }

    @PostMapping("/find/email")
    @ResponseBody
    public ResponseEntity<String> findEmail(@RequestBody Map<String, String> map) {
        try {
            Date date = new Date();
            date.setYear(Integer.parseInt(map.get("birth_year")) - 1900);
            date.setMonth(Integer.parseInt(map.get("birth_month")) - 1);
            date.setDate(Integer.parseInt(map.get("birth_date")));

            UserDto userDto = new UserDto(map.get("userName"), new java.sql.Date(date.getTime()), map.get("userPhone"));
            String result = userService.findEmail(userDto);
            return new ResponseEntity<String>(result, HttpStatus.OK);
        }
        catch (Exception e) {
            return new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping("/show/findPassword")
    public String showFindPassword() {
        return "find_password";
    }

    @PostMapping("/find/password")
    @ResponseBody
    public ResponseEntity<String> showFindPassword(@RequestBody UserDto userDto) {
        try {
            System.out.println(userDto.getUserName() + " " + userDto.getUserEmail() + " " + userDto.getUserPhone());
            if(userService.selectUserInfo(userDto) == 1) {
                return new ResponseEntity<String>("ok!",HttpStatus.OK);
            } else {
                return new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
            }
        } catch (Exception e) {
            return new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
        }
    }

    @PostMapping("/update/userPassword")
    @ResponseBody
    public ResponseEntity<String> updatePassword(@RequestBody UserDto userDto) {
        try {
            System.out.println(userDto);
            userService.updatePassword(userDto);
            return new ResponseEntity<>("ok", HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }

    }

}
