package com.movielike.app.domain;

import java.util.Date;

public class ReviewDto {
    private int rvId;
    private int movId;
    private int userId;
    private String userNickname;
    private int rvScore;
    private String rvContent;
    private Date rvRegDate;
    private Date rvUpDate;
    private int rvLike;
    private boolean rvLikeChk;
    private String movName;
    private int nowPage;
    private int pageSize;

    public ReviewDto() {
    }

    public ReviewDto(int rvId, int userId) {
        this.rvId = rvId;
        this.userId = userId;
    }

    public ReviewDto(int rvId, String rvContent) {
        this.rvId = rvId;
        this.rvContent = rvContent;
    }

    public ReviewDto(int movId, int userId, int rvScore, String rvContent) {
        this.movId = movId;
        this.userId = userId;
        this.rvScore = rvScore;
        this.rvContent = rvContent;
    }

    public int getRvId() {
        return rvId;
    }

    public void setRvId(int rvId) {
        this.rvId = rvId;
    }

    public int getMovId() {
        return movId;
    }

    public void setMovId(int movId) {
        this.movId = movId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserNickname() {
        return userNickname;
    }

    public void setUserNickname(String userNickname) {
        this.userNickname = userNickname;
    }

    public int getRvScore() {
        return rvScore;
    }

    public void setRvScore(int rvScore) {
        this.rvScore = rvScore;
    }

    public String getRvContent() {
        return rvContent;
    }

    public void setRvContent(String rvContent) {
        this.rvContent = rvContent;
    }

    public Date getRvRegDate() {
        return rvRegDate;
    }

    public void setRvRegDate(Date rvRegDate) {
        this.rvRegDate = rvRegDate;
    }

    public Date getRvUpDate() {
        return rvUpDate;
    }

    public void setRvUpDate(Date rvUpDate) {
        this.rvUpDate = rvUpDate;
    }

    public int getRvLike() {
        return rvLike;
    }

    public void setRvLike(int rvLike) {
        this.rvLike = rvLike;
    }

    public boolean isRvLikeChk() {
        return rvLikeChk;
    }

    public void setRvLikeChk(boolean rvLikeChk) {
        this.rvLikeChk = rvLikeChk;
    }

    public String getMovName() {
        return movName;
    }

    public void setMovName(String movName) {
        this.movName = movName;
    }

    public int getNowPage() {
        return nowPage;
    }

    public void setNowPage(int nowPage) {
        this.nowPage = nowPage;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    @Override
    public String toString() {
        return "ReviewDto{" +
                "rvId=" + rvId +
                ", movId=" + movId +
                ", userId=" + userId +
                ", userNickname=" + userNickname +
                ", rvScore=" + rvScore +
                ", rvContent='" + rvContent + '\'' +
                ", rvRegDate=" + rvRegDate +
                ", rvUpDate=" + rvUpDate +
                ", rvLike=" + rvLike +
                ", rvLikeChk=" + rvLikeChk +
                ", movName=" + movName +
                ", nowPage=" + nowPage +
                ", pageSize=" + pageSize +
                '}';
    }
}
