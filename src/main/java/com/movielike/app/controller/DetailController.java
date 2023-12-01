package com.movielike.app.controller;

import com.movielike.app.dao.MovieDao;
import com.movielike.app.dao.ReviewDao;
import com.movielike.app.domain.MovieDto;
import com.movielike.app.domain.MyListDto;
import com.movielike.app.domain.ReviewDto;
import com.movielike.app.domain.WatchedMovieDto;
import com.movielike.app.service.DetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class DetailController {

    @Autowired
    DetailService detailService;
    @Autowired
    ReviewDao reviewDao;

    @GetMapping("/movie/detail")
    public String showMovieDetail(Integer movId, Model model, HttpSession session) {
        if(session.getAttribute("liogdin") != null) {
            int currId = (Integer)session.getAttribute("liogdin");
            // 해당 영화에 찜 눌렀는지 확인
            MyListDto myListDto = new MyListDto(movId, currId);
            if(detailService.checkMyList(myListDto) == 1) {
                model.addAttribute("ml", 1);
            } else {
                model.addAttribute("ml", 0);
            }
            // 해당 영화에 봤어요 눌렀는지 확인
            WatchedMovieDto watchedMovieDto = new WatchedMovieDto(movId, currId);
            if(detailService.checkWatchedMovie(watchedMovieDto) == 1) {
                model.addAttribute("wm", 1);
            } else {
                model.addAttribute("wm", 0);
            }
        }
        MovieDto movieDto = detailService.showMovieInfo(movId);
        movieDto.setMovDate(new java.sql.Date(movieDto.getMovDate().getTime()));
        model.addAttribute("mv",movieDto);

        List<ReviewDto> bestReviewDto = detailService.showBestReview(movId);
        model.addAttribute("bestRvList", bestReviewDto);
        return "Movie_Like_detail";
    }


    @PostMapping("/myList/IoD")
    @ResponseBody
    public ResponseEntity<String> updateMyList(@RequestBody MyListDto myListDto, HttpSession session) {
        try {
            Integer curr_id = (Integer)session.getAttribute("liogdin");
            if(curr_id == null) {
                throw new Exception("로그인 세션 없음 !");
            }
            myListDto.setUserId(curr_id);
            int myListCheck = detailService.checkMyList(myListDto);

            if(myListCheck != 1) {
                detailService.insertMyList(myListDto);
            } else {
                detailService.deleteMyList(myListDto);
            }
            return new ResponseEntity<String> ("찜 통신 성공!", HttpStatus.OK); // 200
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String> ("찜 통신 실패!", HttpStatus.BAD_REQUEST); // 400
        }
    }

    @PostMapping("/watched/IoD")
    @ResponseBody
    public ResponseEntity<String> updateWatchedMovie(@RequestBody WatchedMovieDto watchedMovieDto, HttpSession session) {
        try {
            Integer curr_id = (Integer)session.getAttribute("liogdin");
            if(curr_id == null) {
                throw new Exception("로그인 세션 없음 !");
            }
            watchedMovieDto.setUserId(curr_id);
            int myWatchedCheck = detailService.checkWatchedMovie(watchedMovieDto);

            if(myWatchedCheck != 1) {
                detailService.insertWatchedMovie(watchedMovieDto);
            } else {
                detailService.deleteWatchedMovie(watchedMovieDto);
            }
            return new ResponseEntity<String> ("봤어요 통신 성공!", HttpStatus.OK); // 200
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String> ("봤어요 통신 실패!", HttpStatus.BAD_REQUEST); // 400
        }
    }

    @PostMapping("/review/add")
    @ResponseBody
    public ResponseEntity<String> addReview(@RequestBody ReviewDto reviewDto, HttpSession session) {
        try {
            Integer curr_id = (Integer)session.getAttribute("liogdin");
            if(curr_id == null) {
                throw new Exception("로그인 세션 없음 !");
            }
            reviewDto.setUserId(curr_id);
            detailService.writeReview(reviewDto);
            return new ResponseEntity<String> ("리뷰 등록 통신 성공!", HttpStatus.OK); // 200
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String> ("리뷰 등록 실패!", HttpStatus.BAD_REQUEST); // 400
        }
    }


    @PostMapping("/review/read/all")
    @ResponseBody
    public ResponseEntity<List<ReviewDto>> readReviewAll(@RequestBody Map<String, Integer> map, HttpSession session) {
        try {
            List<ReviewDto> rvAllresult = detailService.selectMovieReviewList(map);
            // 위에서 해당 영화의 리뷰 리스트를 가져온다.
            // 리뷰 리스트에서 rvId를 가져오고, 현재 로그인한 userId를 넘겨준다.
            Integer curr_id = (Integer)session.getAttribute("liogdin");
            // 로그인 한 상태일 때,
            if(curr_id != null) {
                Map<String, Integer> rvMap = new HashMap<>();
                rvMap.put("userId", curr_id);
                for(ReviewDto reviewDto : rvAllresult) {
                    rvMap.put("rvId", reviewDto.getRvId());
                    if(detailService.selectReviewLikeOne(rvMap) == 1) {
                        reviewDto.setRvLikeChk(true);
                    }
                }
            }
            return new ResponseEntity<List<ReviewDto>> (rvAllresult, HttpStatus.OK); // 200
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<List<ReviewDto>> (HttpStatus.BAD_REQUEST); // 400
        }
    }

    @PostMapping("/review/read/cnt")
    @ResponseBody
    public ResponseEntity<Integer> readReviewAll(@RequestBody int movId) {
        try {
            int result = detailService.selectReviewCnt(movId);
            return new ResponseEntity<Integer> (result, HttpStatus.OK); // 200
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<Integer> (HttpStatus.BAD_REQUEST); // 400
        }
    }

    @PostMapping("/review/like/IoD")
    @ResponseBody
    public ResponseEntity<String> updateReviewLike(@RequestBody ReviewDto reviewDto, HttpSession session) {
        try {
            Integer curr_id = (Integer)session.getAttribute("liogdin");
            if(curr_id == null) {
                throw new Exception("로그인 세션 없음 !");
            }
            Map<String, Integer> map = new HashMap<>();
            map.put("rvId", reviewDto.getRvId());
            map.put("userId", curr_id);
            if(detailService.selectReviewLikeOne(map) != 1) {
                detailService.insertReviewLike(map);
            } else {
                detailService.deleteReviewLike(map);
            }
            return new ResponseEntity<String> ("리뷰 좋아요 성공!", HttpStatus.OK); // 200
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String> ("리뷰 좋아요 실패유!", HttpStatus.BAD_REQUEST); // 400
        }
    }

    @PostMapping("/review/modify")
    @ResponseBody
    public ResponseEntity<String> updateReview(@RequestBody ReviewDto reviewDto) {
        try {
            detailService.updateReview(reviewDto);
            return new ResponseEntity<String> ("리뷰 수정 성공!", HttpStatus.OK); // 200
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String> ("리뷰 수정 실패유!", HttpStatus.BAD_REQUEST); // 400
        }
    }

    @PostMapping("/review/delete")
    @ResponseBody
    public ResponseEntity<String> updateReview(@RequestBody Integer rvId) {
        try {
            detailService.deleteReview(rvId);
            return new ResponseEntity<String> ("리뷰 삭제 성공!", HttpStatus.OK); // 200
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String> ("리뷰 삭제 실패유!", HttpStatus.BAD_REQUEST); // 400
        }
    }

    @PostMapping("/review/confirm")
    @ResponseBody
    public ResponseEntity<Integer> confirmReview(@RequestBody Integer movId, HttpSession session) {
        try {
            System.out.println(movId);
            Map<String, Integer> map = new HashMap<>();
            map.put("movId", movId);
            map.put("userId", (Integer) session.getAttribute("liogdin"));

            return new ResponseEntity<Integer> (reviewDao.confirmReview(map), HttpStatus.OK); // 200
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<Integer> (HttpStatus.BAD_REQUEST); // 400
        }
    }
}
