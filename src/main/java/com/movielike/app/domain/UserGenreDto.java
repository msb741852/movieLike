package com.movielike.app.domain;

public class UserGenreDto {
    private int ugId;
    private int genrId;
    private int userId;

    public UserGenreDto(int genrId, int userId) {
        this.genrId = genrId;
        this.userId = userId;
    }

    public int getUgId() {
        return ugId;
    }

    public void setUgId(int ugId) {
        this.ugId = ugId;
    }

    public int getGenrId() {
        return genrId;
    }

    public void setGenrId(int genrId) {
        this.genrId = genrId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    @Override
    public String toString() {
        return "UserGenreDto{" +
                "ugId=" + ugId +
                ", genrId=" + genrId +
                ", userId=" + userId +
                '}';
    }
}
