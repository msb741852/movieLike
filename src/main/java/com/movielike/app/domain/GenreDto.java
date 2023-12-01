package com.movielike.app.domain;

public class GenreDto {
    private int genrId;
    private String genrName;
    private int userId;

    public int getGenrId() {
        return genrId;
    }

    public void setGenrId(int genrId) {
        this.genrId = genrId;
    }

    public String getGenrName() {
        return genrName;
    }

    public void setGenrName(String genrName) {
        this.genrName = genrName;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
}
