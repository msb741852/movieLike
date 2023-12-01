package com.movielike.app.dao;

import com.movielike.app.domain.GenreDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class GenreDao {
    @Autowired
    SqlSession session;

    String namespace="com.movielike.app.dao.genreMapper.";

    public List<GenreDto> genreList(GenreDto genreDto) {
        return session.selectList(namespace + "selectGenre", genreDto);
    }
}

