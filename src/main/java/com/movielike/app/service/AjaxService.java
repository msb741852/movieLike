package com.movielike.app.service;

import com.movielike.app.dao.UserDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AjaxService {

    @Autowired
    UserDao userDao;

    /* ajax 1*/
    public int checkId(String email) {
        int cnt = userDao.checkId(email);
        return cnt;
    }

    /* ajax 2*/
    public int checkNick(String nickname) {
        int cnt = userDao.checkNick(nickname);
        return cnt;
    }

    /* ajax 3*/
    public int checkPhone(String Phone) {
        int cnt = userDao.checkPhone(Phone);
        return cnt;
    }
}