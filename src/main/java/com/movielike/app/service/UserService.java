package com.movielike.app.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.movielike.app.dao.MovieDao;
import com.movielike.app.dao.UserDao;
import com.movielike.app.domain.GenreDto;
import com.movielike.app.domain.UserDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UserService {
    @Autowired
    UserDao userDao;
    @Autowired
    MovieDao movieDao;

    public String findEmail(UserDto userDto) {
        return userDao.findEmail(userDto);
    }

    public int updatePassword(UserDto userDto) {
        return userDao.updatePassword(userDto);
    }

    public int selectUserInfo(UserDto userDto) {
        return userDao.selectUserInfo(userDto);
    }

/////////////////////////////////
///////// 회원 정보 수정 //////////
/////////////////////////////////
//    수정 전 유저 정보 조회
    public Map<String, Object> selectUser(int userId){
        Map<String, Object> userAll = new HashMap<>();
        userAll.put("user", userDao.selectUser(userId));
        userAll.put("userGenre", movieDao.selectUserGenre(userId));
        return userAll;
    }
    //    회원 정보 수정
    public String updateUser(Map<String, Object> user){
        String success = "";
        ObjectMapper mapper = new ObjectMapper();
        UserDto userDto = mapper.convertValue(user.get("user"), UserDto.class);
        System.out.println("userDto : " + userDto);
        List<GenreDto> genreDtoList = (List<GenreDto>) user.get("userGenre");

        int checkIdModify = userDao.checkIdModify(userDto);
        success += checkIdModify > 0 ? "id," : "";
        System.out.println("checkIdModify : " + checkIdModify + ", success : " + success);

        int checkNickModify = userDao.checkNickModify(userDto);
        success += checkNickModify > 0 ? "nick," : "";
        System.out.println("checkNickModify : " + checkNickModify + ", success : " + success);

        int checkPhoneModify = userDao.checkPhoneModify(userDto);
        success += checkPhoneModify > 0 ? "phone," : "";
        System.out.println("checkPhoneModify : " + checkPhoneModify + ", success : " + success);

        if(!success.equals("")){
            return success;
        }
        int updateUserAll = userDao.updateUser(userDto);
        System.out.println("updateUserAll : " + updateUserAll);
        success += updateUserAll <= 0 ? "update," : "";
        int deleteUserGenre = userDao.deleteUserGenre(userDto.getUserId());
        System.out.println("genreDtoList : " + genreDtoList);
        if (!genreDtoList.isEmpty()) {
            int insertUserGenre = userDao.insertUserGenre(genreDtoList);
        }
        return success;
    }
}
