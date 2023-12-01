package com.movielike.app.dao;

import com.movielike.app.domain.MovieDto;
import com.movielike.app.domain.OttDto;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.*;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class MovieDaoTest {
    @Autowired
    MovieDao movieDao;

    @Autowired
    ReviewDao reviewDao;

    @Test
    public void selectMovie() {
        List<OttDto> ottList = new ArrayList<>();
        OttDto ottDto = new OttDto();
        ottDto.setOttName("Netflix");
        ottList.add(ottDto);
        ottDto.setOttName("Watcha");
        ottList.add(ottDto);

        List<String> genreList = new ArrayList<>();
        genreList.add("모험");
        genreList.add("범죄");

        List<String> countryList = new ArrayList<>();
        countryList.add("스위스");

        MovieDto movieDto = new MovieDto(0, 0, countryList, null, null, 0, 20, 0);
        assertTrue(!movieDao.selectMovie(movieDto).get(0).getMovName().equals(null));
    }

    @Test
    public void selectCountry() {
        assertTrue(movieDao.selectCountry(11) != null);
    }

    @Test
    public void selectOtt() {
        assertTrue(movieDao.selectOtt(492008) != null);
    }

    @Test
    public void selectMainBanner(){
        Integer userId = 1;
        List<String> genrList = new ArrayList<>();
        genrList = movieDao.selectUserGenre(userId);
        System.out.println("genrList : " + genrList);

        assertTrue(movieDao.selectMainBanner(genrList) != null);
    }

    @Test
    public void selectBest(){
        String search = "netflix";
        assertTrue(movieDao.selectBest(search) != null);
    }

    @Test
    public void selectSeries(){
        String serName = "marble";
        assertTrue(movieDao.selectSeries(serName) != null);
    }

    @Test
    public void selectSearchMov() {
        Map<String, String> search = new HashMap<>();

        search.put("title", "year");

        int year = Integer.parseInt("2000");
        if ("2000" == "1989"){
            search.put("endYear", (year + 1) + "0101");
        }else{
            search.put("startYear", year + "0101");
            search.put("endYear", (year + 10) + "0101");
        }

        search.put("sort", "0");
        search.put("nowPage", "0");
        String userId = null;

        search.put("userId", userId);
        search.put("val", "2000");

        assertTrue(movieDao.selectSearchMov(search) != null);
    }

    @Test
    public void selectUserReview() {
        System.out.println((reviewDao.selectUserReview(2)));
    }

}