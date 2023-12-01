package com.movielike.app.dao;

import com.movielike.app.domain.GenreDto;
import com.movielike.app.domain.UserDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class UserDao {

    @Autowired
    SqlSession session;

    String namespace = "com.movielike.app.dao.userMapper.";

    public String findEmail(UserDto userDto) {
        return session.selectOne(namespace + "findEmail", userDto);
    }

    public int updatePassword(UserDto userDto) {
        return session.update(namespace + "updatePassword", userDto);
    }

    public int selectUserInfo(UserDto userDto) {
        return session.selectOne(namespace + "selectUserInfo", userDto);
    }

    public String selectPassword(int userId) { return session.selectOne(namespace + "selectPassword", userId);}

    public int deleteUser(int userId) {
        return session.delete(namespace + "deleteUser", userId);
    }
    public int insertUser(UserDto userDto) {
        return session.insert(namespace + "insertUser", userDto);
    }

    public int checkId(String email) {
        return session.selectOne(namespace + "checkId", email);
    }
    public int checkNick(String nickname) {return session.selectOne(namespace + "checkNick", nickname);}
    public int checkPhone(String Phone) {return session.selectOne(namespace + "checkPhone", Phone);}
    public UserDto selectUser(String userEmail, String userPw) {
        // MyBatis를 통해 Mapper에서 SQL 구문 실행
        Map<String, String> paramMap = new HashMap<>();
        paramMap.put("userEmail", userEmail);
        paramMap.put("userPw", userPw);
        UserDto result = session.selectOne(namespace + "chkUserInfo", paramMap);
        return result;
    }

    public int selectUserId(String email) {return session.selectOne(namespace + "selectUserId", email);}
/////////////////////////////////
///////// 회원 정보 수정 //////////
/////////////////////////////////
    public int checkIdModify(UserDto userDto){
        return session.selectOne(namespace + "checkIdModify", userDto);
    }
    public int checkNickModify(UserDto userDto){
        return session.selectOne(namespace + "checkNickModify", userDto);
    }
    public int checkPhoneModify(UserDto userDto){
        return session.selectOne(namespace + "checkPhoneModify", userDto);
    }
    public UserDto selectUser(int userId) {
        return session.selectOne(namespace + "selectUser", userId);
    }

    public int updateUser(UserDto userDto){
        return session.update(namespace + "updateUser", userDto);
    }

    public int deleteUserGenre(int userId) {
        return session.delete(namespace + "deleteUserGenre", userId);
    }
    public int insertUserGenre(List<GenreDto> genreDto){
        return session.insert(namespace + "insertUserGenre", genreDto);
    }
}
