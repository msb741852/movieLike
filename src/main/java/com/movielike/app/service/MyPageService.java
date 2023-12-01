package com.movielike.app.service;


import com.movielike.app.dao.*;
import com.movielike.app.domain.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class MyPageService {
    @Autowired
    ReviewDao reviewDao;

    @Autowired
    WatchedMovieDao watchedMovieDao;

    @Autowired
    MyListDao myListDao;

    @Autowired
    GenreDao genreDao;

    @Autowired
    UserDao userDao;

    @Autowired
    MovieDao movieDao;

    public List<ReviewDto> reviewFind(int page, int pageSize, String orderType, int userId) {
        // 페이지 처리를 위한 계산
        int startRow = (page - 1) * pageSize;

        HashMap params = new HashMap();
        params.put("userId", userId);
        params.put("startRow", startRow);
        params.put("pageSize", pageSize);
        params.put("orderType", orderType);

        return reviewDao.selectReview(params);
    }

    public int reviewCount(int userId) {
        HashMap params = new HashMap();
        params.put("userId", userId);
        return reviewDao.selectReviewCount(params);
    }

    public List<WatchedMovieDto> watchedMovieFind(int userId) {
        WatchedMovieDto watchedMovieDto = new WatchedMovieDto();
        watchedMovieDto.setUserId(userId);

        return watchedMovieDao.WatchedMovie(watchedMovieDto);
    }

    public List<MyListDto> myListFind(int userId) {
        MyListDto myListDto = new MyListDto();
        myListDto.setUserId(userId);

        return myListDao.myList(myListDto);
    }

    public List<ReviewScoreDto> reviewScoreFind(int userId) {
        ReviewDto reviewDto = new ReviewDto();
        reviewDto.setUserId(userId);

        return reviewDao.selectReviewScore(reviewDto);
    }

    public List<GenreDto> genreFind(int userId) {
        GenreDto genreDto = new GenreDto();
        genreDto.setUserId(userId);

        return genreDao.genreList(genreDto);
    }

    public void deleteUserInfo(int userId) {
        userDao.deleteUser(userId);
        myListDao.deleteAllMyList(userId);
        watchedMovieDao.deleteAllWatchedMovie(userId);

        // 작성했던 리뷰 조회
        List<Map<String, Integer>> userReviewList =  reviewDao.selectUserReview(userId);
        System.out.println("userReviewList : " + userReviewList);
        if(!userReviewList.isEmpty()) {
            movieDao.updateScore(userReviewList);
            reviewDao.deleteAllReview(userId);
            reviewDao.deleteAllReviewLike(userId);
        }
    }
}
