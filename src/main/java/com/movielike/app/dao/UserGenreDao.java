package com.movielike.app.dao;

import com.movielike.app.domain.UserGenreDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class UserGenreDao {
    @Autowired
    SqlSession session;
    private final String namespace = "com.movielike.app.dao.userGenreMapper.";
    public void insertUserGenre(List<UserGenreDto> userGenreDtoList) {
        session.insert(namespace + "insertUserGenre", userGenreDtoList);
    }
}
