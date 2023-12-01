<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session = "false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movie Like</title>
    <link rel="icon" href="<c:url value='/img/favicon.ico'/>">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <link rel="stylesheet" href="<c:url value='/css/common.css'/> ">
    <link rel="stylesheet" href="<c:url value='/css/main_page.css'/> ">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
</head>
<body>
<div id="wrap">
    <jsp:include page="header.jsp"/>
    <main class="container">
        <div class="main_banner">
            <!-- 메인베너 -->
            <div class="mainbanner_list on"></div>
            <div class="mainbanner_list"></div>
            <div class="mainbanner_list"></div>
            <div class="mainbanner_list"></div>
            <div class="mainbanner_list"></div>
            <section id="slide_btn_box">
                <div class="left_btn">
                    <span></span>
                    <span></span>
                </div>
                <div class="right_btn">
                    <span></span>
                    <span></span>
                </div>
            </section>
            <section id="control">
                <a class="on" href="#"></a>
                <a href="#"></a>
                <a href="#"></a>
                <a href="#"></a>
                <a href="#"></a>
            </section>
        </div>
        <div class="search_bar">
            <input type="text" class="search" placeholder="영화 제목, 감독 배우를 검색해주세요">
            <div class="s_icon"><img src="<c:url value='/img/search.png'/>" alt=""></div>
        </div>
        <div class="content">
            <div class="content_box">
                <div class="title_box">
                    <div class="title">전체 인기순위</div>
                    <div class="title_icon"><img src="<c:url value='/img/crown.png'/>" alt="왕관 아이콘"></div>
                </div>
                <div class="ranking_poster_box allBox">
                    <div class="recommended_item_content">
                        <section class="new_arr">
                            <!-- Swiper -->
                            <div class="swiper mySwiper" style="
                                padding: 0 30px; box-sizing: border-box;">
                                <div class="swiper-wrapper">
                                    <div class="swiper-slide"></div>
                                    <div class="swiper-slide"></div>
                                    <div class="swiper-slide"></div>
                                    <div class="swiper-slide"></div>
                                    <div class="swiper-slide"></div>
                                    <div class="swiper-slide"></div>
                                    <div class="swiper-slide"></div>
                                    <div class="swiper-slide"></div>
                                    <div class="swiper-slide"></div>
                                    <div class="swiper-slide"></div>
                                </div>
                                <div class="swiper-pagination"></div>

                                <!-- If we need navigation buttons -->
                                <div class="swiper-button-prev"></div>
                                <div class="swiper-button-next"></div>
                            </div>
                        </section>
                    </div>
                </div>
            </div>
            <div class="content_box">
                <div class="title_box">
                    <div class="title">넷플릭스 인기순위</div>
                    <div class="title_icon"><img src="<c:url value='/img/popcon.png'/>" alt="팝콘 아이콘"></div>
                </div>
                <div class="ranking_poster_box netflixBox">
                    <div class="recommended_item_content">
                        <section class="new_arr">
                            <!-- Swiper -->
                            <div class="swiper mySwiper" style="
                                padding: 0 30px; box-sizing: border-box;">
                                <div class="swiper-wrapper">
                                    <div class="swiper-slide"></div>
                                    <div class="swiper-slide"></div>
                                    <div class="swiper-slide"></div>
                                    <div class="swiper-slide"></div>
                                    <div class="swiper-slide"></div>
                                    <div class="swiper-slide"></div>
                                    <div class="swiper-slide"></div>
                                    <div class="swiper-slide"></div>
                                    <div class="swiper-slide"></div>
                                    <div class="swiper-slide"></div>
                                </div>
                                <div class="swiper-pagination"></div>

                                <!-- If we need navigation buttons -->
                                <div class="swiper-button-prev"></div>
                                <div class="swiper-button-next"></div>
                            </div>
                        </section>
                    </div>
                </div>
            </div>
            <div class="content_box">
                <div class="title_box">
                    <div class="title">사람들이 많이 검색한 영화</div>
                    <div class="title_icon"><img src="<c:url value='/img/eyes.png'/>" alt="눈 아이콘"></div>
                </div>
                <div class="ranking_poster_box wannerBox">
                    <div class="recommended_item_content">
                        <section class="new_arr">
                            <!-- Swiper -->
                            <div class="swiper mySwiper" style="padding: 0 30px; box-sizing: border-box;">
                                <div class="swiper-wrapper">
                                    <div class="swiper-slide"></div>
                                    <div class="swiper-slide"></div>
                                    <div class="swiper-slide"></div>
                                    <div class="swiper-slide"></div>
                                    <div class="swiper-slide"></div>
                                    <div class="swiper-slide"></div>
                                    <div class="swiper-slide"></div>
                                    <div class="swiper-slide"></div>
                                    <div class="swiper-slide"></div>
                                    <div class="swiper-slide"></div>
                                </div>
                                <div class="swiper-pagination"></div>

                                <!-- If we need navigation buttons -->
                                <div class="swiper-button-prev"></div>
                                <div class="swiper-button-next"></div>
                            </div>
                        </section>
                    </div>
                </div>
            </div>

            <div class="best_review_box">
                <div class="title_box">
                    <div class="title">베스트 리뷰</div>
                    <div class="title_icon"><img src="<c:url value='/img/best_review.png'/>" alt="베스트 아이콘"></div>
                </div>
                <div class="review_box">
                    <c:forEach var="review" items="${reviewList}">
                        <div class="review" data-movId = "${review.movId}">
                            <div class="review_movie_name">${review.movName}</div>
                            <div class="review_txt">${review.rvContent}</div>
                            <div class="review_right_box">
                                <div class="review_title">${review.userNickname}</div>
                                <div class="star_icon"><img src="<c:url value='/img/star.png'/>" alt="★"></div>
                                <div class="movie_star">${review.rvScore}</div>
                            </div>
                            <div class="like_box">
                                <div class="like_icon"><img src="<c:url value='/img/heart_cnt.png'/>" alt="♥"></div>
                                <div class="like_cnt">${review.rvLike}</div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <div class="content_box">
                <div class="title_box">
                    <div class="title">지브리 시리즈</div>
                    <div class="title_icon"><img src="<c:url value='/img/gibli.png'/>" alt="지브리 아이콘"></div>
                    <div class="more_btn"><a href="<c:url value='/list/chart?title=series&val=gibli&valName=지브리&nbsp;시리즈'/>">더보기</a></div>
                </div>
                <div class="poster_box gibliBox">

                </div>
            </div>
            <div class="content_box">
                <div class="title_box">
                    <div class="title">마블 시리즈</div>
                    <div class="title_icon"><img src="<c:url value='/img/marble.png'/>" alt="마블 아이콘"></div>
                    <div class="more_btn"><a href="<c:url value='/list/chart?title=series&val=marble&valName=마블&nbsp;시리즈'/>">더보기</a></div>
                </div>
                <div class="poster_box marbleBox">

                </div>
            </div>
            <div class="content_box">
                <div class="title_box">
                    <div class="title">해리포터 시리즈</div>
                    <div class="title_icon"><img src="<c:url value='/img/glasses.png'/>" class="glasses" alt="해리포터 아이콘"></div>
                    <div class="more_btn"><a href="<c:url value='/list/chart?title=series&val=harry&valName=해리포터&nbsp;시리즈'/>">더보기</a></div>
                </div>
                <div class="poster_box harryBox">

                </div>
            </div>
        </div>
    </main>
    <jsp:include page="footer.jsp"/>
</div>
<script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
<script>
    var bannerList = ${bannerList};
    var allBestList = ${allBestList};
    var netflixBestList = ${netflixBestList};
    var searchBestList = ${searchBestList};
    var gibliList = ${gibliList};
    var marbleList = ${marbleList};
    var harryList = ${harryList};
</script>
<script src="<c:url value='/js/main_item.js'/>"></script>
</body>
</html>