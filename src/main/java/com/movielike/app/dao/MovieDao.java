package com.movielike.app.dao;

import com.movielike.app.domain.MovieDto;
import com.movielike.app.domain.OttDto;
import com.movielike.app.domain.PersonDto;
import com.movielike.app.domain.ReviewDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class MovieDao {
    @Autowired
    SqlSession session;
    String namespace="com.movielike.app.dao.movieMapper.";

/////////////////////////////////
/////// 키워드 찾기 페이지 ////////
/////////////////////////////////
    public List<MovieDto> selectMovie(MovieDto movieDto) {
        return session.selectList(namespace+"selectMovie" , movieDto);
    }
    
    // perJob에 값 넣으면 감독만, 배우만 조회. ""면 둘 다 조회
    public List<PersonDto> selectPerson(int movId, String perJob){
        Map<String, String> movMap = new HashMap<>();
        movMap.put("movId", String.valueOf(movId));
        movMap.put("perJob", perJob);
        return session.selectList(namespace+"selectPerson", movMap);
    }

    public List<String> selectCountry(int movId) {
        return session.selectList(namespace+"selectCountry" , movId);
    }

    public List<String> selectGenre(int movId) {
        return session.selectList(namespace+"selectGenre" , movId);
    }

    public List<OttDto> selectOtt(int movId) {
        return session.selectList(namespace+"selectOtt" , movId);
    }

/////////////////////////////////
////////// 메인 페이지 ///////////
/////////////////////////////////
    public List<String> selectUserGenre(Integer userId){
        return session.selectList(namespace+"selectUserGenre" , userId);
    }

    public List<MovieDto> selectMainBanner(List<String> genrList){
        return session.selectList(namespace+"selectMainBanner" , genrList);
    }

    public List<MovieDto> selectBest(String search){
        return session.selectList(namespace+"selectBest" , search);
    }

    public List<MovieDto> selectSeries(String serName){
        return session.selectList(namespace+"selectSeries" , serName);
    }

    public List<MovieDto> selectSearchMov(Map search) {
        return session.selectList(namespace+"selectSearchMov" , search);
    }
    public List<MovieDto> selectSearchMovAge(Map search) {
        return session.selectList(namespace+"selectSearchMovAge" , search);
    }

/////////////////////////////////
////////// 상세 페이지 ///////////
/////////////////////////////////
    public MovieDto selectMovieDetail(int movId) {
        return session.selectOne(namespace + "selectMovieDetail", movId);
    }
    public List<String> selectMovieCountry(int movId) {
        return session.selectList(namespace + "selectMovieCountry", movId);
    }
    public List<String> selectMovieGenre(int movId) {
        return session.selectList(namespace + "selectMovieGenre", movId);
    }
    public List<OttDto> selectMovieOtt(int movId) {
        return session.selectList(namespace + "selectMovieOtt", movId);
    }
    public List<PersonDto> selectMoviePerson(int movId) {
        return session.selectList(namespace + "selectMoviePerson", movId);
    }
    public int updateSearchCnt(int movId) {
        return session.update(namespace + "updateSearchCnt", movId);
    }

    public int updateMovieScore(Map<String, Integer> map) {
        return session.update(namespace + "updateMovieScore", map);
    }

    /////////////////////////////////
    ////////// 마이 페이지 ///////////
    /////////////////////////////////
    public int updateScore(List<Map<String, Integer>> mapList) {
        return session.update(namespace + "updateScore", mapList);
    }
}

