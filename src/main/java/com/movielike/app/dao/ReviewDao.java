package com.movielike.app.dao;

import com.movielike.app.domain.ReviewDto;
import com.movielike.app.domain.ReviewScoreDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class ReviewDao {

    @Autowired
    SqlSession session;

    String namespace = "com.movielike.app.dao.reviewMapper.";

    public List<ReviewDto> selectBestReview(int movId) {
        return session.selectList(namespace + "selectBestReview", movId);
    }

    public int insertReview(ReviewDto reviewDto) {
        return session.insert(namespace + "insertReview", reviewDto);
    }

    public List<ReviewDto> selectMovieReviewList(Map<String, Integer> map) {
        return session.selectList(namespace + "selectMovieReviewList", map);
    }

    public int selectReviewLikeOne(Map<String, Integer> map) {
        System.out.println("dao map: " + map);
        return session.selectOne(namespace + "selectReviewLikeOne", map);
    }
    public int insertReviewLike(Map<String, Integer> map) {
        return session.insert(namespace + "insertReviewLike", map);
    }

    public int updateReviewLike(Map<String, Integer> map) {
        return session.update(namespace + "updateReviewLike", map);
    }

    public int deleteReviewLike(Map<String, Integer> map) {
        return session.delete(namespace + "deleteReviewLike", map);
    }

    public int selectReviewCnt(int movId) {
        return session.selectOne(namespace + "selectReviewCnt", movId);
    }

    public int updateReview(ReviewDto reviewDto) {
        return session.update(namespace + "updateReview", reviewDto);
    }

    public int deleteReview(int rvId) {
        return session.delete(namespace + "deleteReview", rvId);
    }
    public int confirmReview(Map<String, Integer> map) {
        return session.selectOne(namespace + "confirmReview", map);
    }

    public Map<String, Integer> selectRvScore(int rvId) {
        return session.selectOne(namespace + "selectReviewScore", rvId);
    }

    public List<ReviewDto> selectReview(HashMap param) {
        return session.selectList(namespace + "selectReview", param);
    }

    public Integer selectReviewCount(HashMap param) {
        return session.selectOne(namespace + "selectReviewCount", param);
    }

    public List<ReviewScoreDto> selectReviewScore(ReviewDto reviewDto) {
        return session.selectList(namespace + "selectReviewGroupByScore", reviewDto);
    }

    public List<Map<String, Integer>> selectUserReview(int userId) {
        return session.selectList(namespace + "selectUserReview", userId);
    }
    public int deleteAllReview(int userId) {
        return session.delete(namespace + "deleteAllReview", userId);
    }
    public int deleteAllReviewLike(int userId) {
        return session.delete(namespace + "deleteAllReviewLike", userId);
    }
}
