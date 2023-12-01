package com.movielike.app.domain;

import java.sql.Date;

public class UserDto {
    private int userId;
    private String userEmail;
    private String userPw;
    private String userName;
    private Date userBirth;
    private String userNickname;
    private String userPhone;
    private Date userRegDate;

    public UserDto() {
    }

    public UserDto(String userName, Date userBirth, String userPhone) {
        this.userName = userName;
        this.userBirth = userBirth;
        this.userPhone = userPhone;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getUserPw() {
        return userPw;
    }

    public void setUserPw(String userPw) {
        this.userPw = userPw;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public Date getUserBirth() {
        return userBirth;
    }

    public void setUserBirth(Date userBirth) {
        this.userBirth = userBirth;
    }

    public String getUserNickname() {
        return userNickname;
    }

    public void setUserNickname(String userNickname) {
        this.userNickname = userNickname;
    }

    public String getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }

    public Date getUserRegDate() {
        return userRegDate;
    }

    public void setUserRegDate(Date userRegDate) {
        this.userRegDate = userRegDate;
    }

    @Override
    public String toString() {
        return "UserDto{" +
                "userId=" + userId +
                ", userEmail='" + userEmail + '\'' +
                ", userPw='" + userPw + '\'' +
                ", userName='" + userName + '\'' +
                ", userBirth=" + userBirth +
                ", userNickname='" + userNickname + '\'' +
                ", userPhone='" + userPhone + '\'' +
                ", userRegDate=" + userRegDate +
                '}';
    }
}
