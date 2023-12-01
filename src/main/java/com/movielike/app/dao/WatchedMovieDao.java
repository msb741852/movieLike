package com.movielike.app.dao;

import com.movielike.app.domain.MyListDto;
import com.movielike.app.domain.WatchedMovieDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class WatchedMovieDao {

    @Autowired
    SqlSession session;


    String namespace="com.movielike.app.dao.watchedMovieMapper.";

    public int selectMDwatchedMovie(WatchedMovieDto watchedMovieDto) {
        return session.selectOne(namespace + "selectMDwatchedMovie" , watchedMovieDto);
    }

    public int selectMDmylist(MyListDto myListDto) {
        return session.selectOne(namespace + "selectMDmylist" , myListDto);
    }

    public int insertWatchedMovie(WatchedMovieDto watchedMovieDto) {
        return session.insert(namespace + "insertWatchedMovie", watchedMovieDto);
    }

    public int deleteWatchedMovie(WatchedMovieDto watchedMovieDto) {
        return session.delete(namespace + "deleteWatchedMovie", watchedMovieDto);
    }

    ///////////// 정선
    public List<WatchedMovieDto> WatchedMovie(WatchedMovieDto watchedMovieDto) {
        return session.selectList(namespace + "selectWatchedMovie", watchedMovieDto);
    }

    public int deleteAllWatchedMovie(int userId) {
        return session.delete(namespace + "deleteAllWatchedMovie", userId);
    }
}
