package com.movielike.app.service;

import com.movielike.app.dao.MovieDao;
import com.movielike.app.dao.MyListDao;
import com.movielike.app.dao.ReviewDao;
import com.movielike.app.dao.WatchedMovieDao;
import com.movielike.app.domain.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class DetailService {
    @Autowired
    MovieDao movieDao;
    @Autowired
    ReviewDao reviewDao;
    @Autowired
    MyListDao myListDao;
    @Autowired
    WatchedMovieDao watchedMovieDao;

    public MovieDto showMovieInfo(Integer movId) {
        MovieDto movieDto = movieDao.selectMovieDetail(movId);
        movieDto.setCountryNameList(movieDao.selectMovieCountry(movId));
        movieDto.setGenreList(movieDao.selectMovieGenre(movId));
        movieDto.setOttList(movieDao.selectMovieOtt(movId));
        movieDto.setActorList(movieDao.selectMoviePerson(movId));
        movieDao.updateSearchCnt(movId);
        return movieDto;
    }

    // best3 리뷰 가져오기
    public List<ReviewDto> showBestReview(Integer movId) {
        List<ReviewDto> reviewDtoList = reviewDao.selectBestReview(movId);
        return reviewDtoList;
    }

    // 현재 로그인 되어있는 회원가 해당 영화를 찜 / 봤어요를 체크했었는지 불러오는 메서드
    public int checkMyList(MyListDto myListDto) {
        return myListDao.selectMDmylist(myListDto);
    }
    public int checkWatchedMovie(WatchedMovieDto watchedMovieDto) {
        return watchedMovieDao.selectMDwatchedMovie(watchedMovieDto);
    }

    // 찜 버튼 등록 및 삭제
    public void insertMyList(MyListDto myListDto) {
        myListDao.insertMyList(myListDto);
    }
    public void deleteMyList(MyListDto myListDto) {
        myListDao.deleteMyList(myListDto);
    }

    // 봤어요 버튼 등록 및 삭제
    public void insertWatchedMovie(WatchedMovieDto watchedMovieDto) {
        watchedMovieDao.insertWatchedMovie(watchedMovieDto);
    }
    public void deleteWatchedMovie(WatchedMovieDto watchedMovieDto) {
        watchedMovieDao.deleteWatchedMovie(watchedMovieDto);
    }

    public void writeReview(ReviewDto reviewDto) {
        reviewDao.insertReview(reviewDto);
        Map<String, Integer> map = new HashMap<>();
        map.put("rvScore", reviewDto.getRvScore());
        map.put("pmOne", 1);
        map.put("movId", reviewDto.getMovId());
        movieDao.updateMovieScore(map);
    }

    public List<ReviewDto> selectMovieReviewList(Map<String, Integer> map) {
        return reviewDao.selectMovieReviewList(map);
    }

    public void insertReviewLike(Map<String, Integer> map) {
        reviewDao.insertReviewLike(map);
        Map<String, Integer> updateMap = new HashMap<>();
        updateMap.put("pmOne", 1);
        updateMap.put("rvId", map.get("rvId"));
        reviewDao.updateReviewLike(updateMap);
    }

    public int selectReviewLikeOne(Map<String, Integer> map) {
        return reviewDao.selectReviewLikeOne(map);
    }

    public void deleteReviewLike(Map<String, Integer> map) {
        reviewDao.deleteReviewLike(map);
        Map<String, Integer> updateMap = new HashMap<>();
        updateMap.put("pmOne", -1);
        updateMap.put("rvId", map.get("rvId"));
        reviewDao.updateReviewLike(updateMap);
    }

    public int selectReviewCnt(int movId) {
        return reviewDao.selectReviewCnt(movId);
    }

    public void updateReview(ReviewDto reviewDto) {
        reviewDao.updateReview(reviewDto);
    }

    public void deleteReview(int rvId) {
        Map<String, Integer> selectMap = reviewDao.selectRvScore(rvId);
        Map<String, Integer> map = new HashMap<>();
        map.put("rvScore", -selectMap.get("rvScore"));
        map.put("pmOne", -1);
        map.put("movId", selectMap.get("movId"));
        movieDao.updateMovieScore(map);
        reviewDao.deleteReview(rvId);
    }

}