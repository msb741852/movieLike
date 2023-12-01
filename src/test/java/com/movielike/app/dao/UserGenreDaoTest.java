package com.movielike.app.dao;

import com.movielike.app.domain.UserDto;
import com.movielike.app.domain.UserGenreDto;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.*;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class UserGenreDaoTest {
    @Autowired
    UserGenreDao userGenreDao;
    @Test
    public void insertUserGenre() {
        List<UserGenreDto> userGenreDtoList = new ArrayList<>();
        UserGenreDto userGenreDto = new UserGenreDto(11, 1);
        userGenreDtoList.add(userGenreDto);
        userGenreDao.insertUserGenre(userGenreDtoList);
    }
}