package com.movielike.app.controller;

import com.movielike.app.domain.MovieDto;
import com.movielike.app.service.ListService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

@Controller
public class ListController {
    @Autowired
    ListService service;

    @GetMapping("/list/chart")
    public String showListMovie(String title, String val, String sort, String nowPage, HttpSession session, Model model){
        if(Objects.equals(title, "search") && Objects.equals(val, "")){
            model.addAttribute("error", "blank");
            return "Movie_Like_list";
        }
        List<MovieDto> movieList = listUpMovie(title, val, sort, nowPage, session);

        model.addAttribute("title", title);
        model.addAttribute("val", val);
        model.addAttribute("movieList", movieList);

        return "Movie_Like_list";
    }

    @PostMapping("/list/chart")
    @ResponseBody
//    public ResponseEntity<List<MovieDto>> showListMovieAjax(@RequestBody String title, @RequestBody String val, @RequestBody String sort, @RequestBody String nowPage, HttpSession session){
    public ResponseEntity<List<MovieDto>> showListMovieAjax(@RequestBody Map<String, String> keyword, HttpSession session){
        System.out.print("ajax -> ");
        try {
            List<MovieDto> movieList = listUpMovie(keyword.get("s_title"), keyword.get("s_val"), keyword.get("sort"), keyword.get("nowPage"), session);
            if (movieList == null || movieList.isEmpty()){
                throw new Exception("출력할 값이 없습니다. ");
            }
            return new ResponseEntity<List<MovieDto>>(movieList, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<List<MovieDto>> (HttpStatus.BAD_REQUEST); // 400
        }
    }

    public List<MovieDto> listUpMovie(String title, String val, String sort, String nowPage, HttpSession session){
        String userId = String.valueOf((Integer)session.getAttribute("liogdin"));
        nowPage = (nowPage == null? "0" : nowPage);
        sort = (sort == null? "0" : sort);
        val = (val == null ? null : val.replaceAll(" ", ""));
        List<MovieDto> movieList = service.listSearch(title, val, userId, nowPage, sort);
        System.out.println("movieList : " + movieList);
        return movieList;
    }
}
