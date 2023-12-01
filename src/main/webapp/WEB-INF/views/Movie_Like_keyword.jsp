<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movie Like</title>
    <link rel="icon" href="<c:url value='/img/favicon.ico'/>">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <link rel="stylesheet" href="<c:url value='/css/common.css'/> ">
    <link rel="stylesheet" href="<c:url value='/css/keyword_page.css'/> ">
</head>
<body>
<div id="wrap">
    <jsp:include page="header.jsp"/>
    <main class="container" onselectstart="return false">
        <div class="m_head">취향 <span class="m_headKey">#키워드</span> 골라보기</div>
        <!-- <div class="m_tagList"><span class="m_tagItem" data-key="genr/액션">#액션</span></div> -->

        <!-- 장르 선택 -->
        <input type="checkbox" id="adventure_chk">
        <input type="checkbox" id="fantasy_chk">
        <input type="checkbox" id="animation_chk">
        <input type="checkbox" id="drama_chk">
        <input type="checkbox" id="horror_chk">
        <input type="checkbox" id="action_chk">
        <input type="checkbox" id="comedy_chk">
        <input type="checkbox" id="history_chk">
        <input type="checkbox" id="western_chk">
        <input type="checkbox" id="thriller_chk">
        <input type="checkbox" id="crime_chk">
        <input type="checkbox" id="documentary_chk">
        <input type="checkbox" id="sf_chk">
        <input type="checkbox" id="mystery_chk">
        <input type="checkbox" id="music_chk">
        <input type="checkbox" id="romance_chk">
        <input type="checkbox" id="family_chk">
        <input type="checkbox" id="war_chk">
        <input type="checkbox" id="tvmovie_chk">

        <!-- 국가 선택 -->
        <input type="checkbox" id="korea_chk">
        <input type="checkbox" id="america_chk">
        <input type="checkbox" id="uk_chk">
        <input type="checkbox" id="china_chk">
        <input type="checkbox" id="japan_chk">
        <input type="checkbox" id="france_chk">
        <input type="checkbox" id="hongkong_chk">
        <input type="checkbox" id="canada_chk">
        <input type="checkbox" id="germany_chk">
        <input type="checkbox" id="taiwan_chk">
        <input type="checkbox" id="australia_chk">
        <input type="checkbox" id="brazil_chk">
        <input type="checkbox" id="india_chk">
        <input type="checkbox" id="russia_chk">
        <input type="checkbox" id="denmark_chk">
        <input type="checkbox" id="mexico_chk">
        <input type="checkbox" id="switzerland_chk">


        <!-- OTT 선택 -->
        <input type="checkbox" id="netflex_chk">
        <input type="checkbox" id="watcha_chk">
        <input type="checkbox" id="disnep_chk">
        <input type="checkbox" id="wavve_chk">
        <input type="checkbox" id="appletv_chk">

        <!-- 리뷰 선택 -->
        <input type="checkbox" name="review_rd" id="review_500_chk" data-type = "radio">
        <input type="checkbox" name="review_rd" id="review_400_chk" data-type = "radio">
        <input type="checkbox" name="review_rd" id="review_300_chk" data-type = "radio">

        <!-- 평점 선택 -->
        <input type="checkbox" name="score_rd" id="score5_chk" data-type = "radio">
        <input type="checkbox" name="score_rd" id="score4_chk" data-type = "radio">
        <input type="checkbox" name="score_rd" id="score3_chk" data-type = "radio">

        <table class="m_table">
            <tr class="m_tr">
                <th class="m_th">장르</th>
                <td class="m_td">
                    <div class="m_tdList genre_list">
                        <label for="adventure_chk"><span class="m_tdItem">모험</span></label>
                        <label for="fantasy_chk"><span class="m_tdItem">판타지</span></label>
                        <label for="animation_chk"><span class="m_tdItem">애니메이션</span></label>
                        <label for="drama_chk"><span class="m_tdItem">드라마</span></label>
                        <label for="horror_chk"><span class="m_tdItem">공포</span></label>
                        <label for="action_chk"><span class="m_tdItem">액션</span></label>
                        <label for="comedy_chk"><span class="m_tdItem">코미디</span></label>
                        <label for="history_chk"><span class="m_tdItem">역사</span></label>
                        <label for="western_chk"><span class="m_tdItem">서부</span></label>
                        <label for="thriller_chk"><span class="m_tdItem">스릴러</span></label>
                        <label for="crime_chk"><span class="m_tdItem">범죄</span></label>
                        <label for="documentary_chk"><span class="m_tdItem">다큐멘터리</span></label>
                        <label for="sf_chk"><span class="m_tdItem">SF</span></label>
                        <label for="mystery_chk"><span class="m_tdItem">미스터리</span></label>
                        <label for="music_chk"><span class="m_tdItem">음악</span></label>
                        <label for="romance_chk"><span class="m_tdItem">로맨스</span></label>
                        <label for="family_chk"><span class="m_tdItem">가족</span></label>
                        <label for="war_chk"><span class="m_tdItem">전쟁</span></label>
                        <label for="tvmovie_chk"><span class="m_tdItem">TV 영화</span></label>
                    </div>
                </td>
            </tr>
            <tr class="m_tr">
                <th class="m_th">국가</th>
                <td class="m_td">
                    <div class="m_tdList country_list">
                        <label for="korea_chk"><span class="m_tdItem">대한민국</span></label>
                        <label for="america_chk"><span class="m_tdItem">미국</span></label>
                        <label for="uk_chk"><span class="m_tdItem">영국</span></label>
                        <label for="china_chk"><span class="m_tdItem">중국</span></label>
                        <label for="japan_chk"><span class="m_tdItem">일본</span></label>
                        <label for="france_chk"><span class="m_tdItem">프랑스</span></label>
                        <label for="hongkong_chk"><span class="m_tdItem">홍콩</span></label>
                        <label for="canada_chk"><span class="m_tdItem">캐나다</span></label>
                        <label for="germany_chk"><span class="m_tdItem">독일</span></label>
                        <label for="taiwan_chk"><span class="m_tdItem">대만</span></label>
                        <label for="australia_chk"><span class="m_tdItem">호주</span></label>
                        <label for="brazil_chk"><span class="m_tdItem">브라질</span></label>
                        <label for="india_chk"><span class="m_tdItem">인도</span></label>
                        <label for="russia_chk"><span class="m_tdItem">러시아</span></label>
                        <label for="denmark_chk"><span class="m_tdItem">덴마크</span></label>
                        <label for="mexico_chk"><span class="m_tdItem">멕시코</span></label>
                        <label for="switzerland_chk"><span class="m_tdItem">스위스</span></label>
                    </div>
                </td>
            </tr>
            <tr class="m_tr">
                <th class="m_th">OTT</th>
                <td class="m_td">
                    <div class="m_tdList ott_list">
                        <label for="netflex_chk"><span class="m_tdItem">넷플릭스</span></label>
                        <label for="watcha_chk"><span class="m_tdItem">왓챠</span></label>
                        <label for="disnep_chk"><span class="m_tdItem">디즈니+</span></label>
                        <label for="wavve_chk"><span class="m_tdItem">웨이브</span></label>
                        <label for="appletv_chk"><span class="m_tdItem">Apple TV+</span></label>
                    </div>
                </td>
            </tr>
            <tr class="m_tr">
                <th class="m_th">리뷰수</th>
                <td class="m_td">
                    <div class="m_tdList review_cnt_list">
                        <label for="review_500_chk"><span class="m_tdItem">리뷰 500개 이상</span></label>
                        <label for="review_400_chk"><span class="m_tdItem">리뷰 400개
                                    <label for="review_300_chk"></label>이상</span></label>
                        <label for="review_300_chk"><span class="m_tdItem">리뷰 300개 이상</span></label>
                    </div>
                </td>
            </tr>
            <tr class="m_tr">
                <th class="m_th">평점</th>
                <td class="m_td">
                    <div class="m_tdList score_list">
                        <label for="score5_chk"><span class="m_tdItem">5점이상</span></label>
                        <label for="score4_chk"><span class="m_tdItem">4점이상</span></label>
                        <label for="score3_chk"><span class="m_tdItem">3점이상</span></label>
                    </div>
                </td>
            </tr>
        </table>

        <div class="m_tagBox">
            <!-- chk:: javascript에서 값 불러올 예정 -->
            <!-- <div class="m_tagList"><span class="m_tagItem"></span></div> -->
            <div class="m_tagList">
                <!-- 장르 check -->
                <label for="adventure_chk"><span class="m_tagItem" id="adventure" data-genr = "모험">#모험</span></label>
                <label for="fantasy_chk"><span class="m_tagItem" id="fantasy" data-genr = "판타지">#판타지</span></label>
                <label for="animation_chk"><span class="m_tagItem" id="animation" data-genr = "애니메이션">#애니메이션</span></label>
                <label for="drama_chk"><span class="m_tagItem" id="drama" data-genr = "드라마">#드라마</span></label>
                <label for="horror_chk"><span class="m_tagItem" id="horror" data-genr = "공포">#공포</span></label>
                <label for="action_chk"><span class="m_tagItem" id="action" data-genr = "액션">#액션</span></label>
                <label for="comedy_chk"><span class="m_tagItem" id="comedy" data-genr = "코미디">#코미디</span></label>
                <label for="history_chk"><span class="m_tagItem" id="history" data-genr = "역사">#역사</span></label>
                <label for="western_chk"><span class="m_tagItem" id="western" data-genr = "서부">#서부</span></label>
                <label for="thriller_chk"><span class="m_tagItem" id="thriller" data-genr = "스릴러">#스릴러</span></label>
                <label for="crime_chk"><span class="m_tagItem" id="crime" data-genr = "범죄">#범죄</span></label>
                <label for="documentary_chk"><span class="m_tagItem" id="documentary" data-genr = "다큐멘터리">#다큐멘터리</span></label>
                <label for="sf_chk"><span class="m_tagItem" id="sf" data-genr = "SF">#SF</span></label>
                <label for="mystery_chk"><span class="m_tagItem" id="mystery" data-genr = "미스터리">#미스터리</span></label>
                <label for="music_chk"><span class="m_tagItem" id="music" data-genr = "음악">#음악</span></label>
                <label for="romance_chk"><span class="m_tagItem" id="romance" data-genr = "로맨스">#로맨스</span></label>
                <label for="family_chk"><span class="m_tagItem" id="family" data-genr = "가족">#가족</span></label>
                <label for="war_chk"><span class="m_tagItem" id="war" data-genr = "전쟁">#전쟁</span></label>
                <label for="tvmovie_chk"><span class="m_tagItem" id="tvmovie" data-genr = "TV 영화">#TV 영화</span></label>

                <!-- 국가 check -->
                <label for="korea_chk"><span class="m_tagItem" id="korea" data-country = "대한민국">#대한민국</span></label>
                <label for="america_chk"><span class="m_tagItem" id="america" data-country = "미국">#미국</span></label>
                <label for="uk_chk"><span class="m_tagItem" id="uk" data-country = "영국">#영국</span></label>
                <label for="china_chk"><span class="m_tagItem" id="china" data-country = "중국">#중국</span></label>
                <label for="japan_chk"><span class="m_tagItem" id="japan" data-country = "일본">#일본</span></label>
                <label for="france_chk"><span class="m_tagItem" id="france" data-country = "프랑스">#프랑스</span></label>
                <label for="hongkong_chk"><span class="m_tagItem" id="hongkong" data-country = "홍콩">#홍콩</span></label>
                <label for="canada_chk"><span class="m_tagItem" id="canada" data-country = "캐나다">#캐나다</span></label>
                <label for="germany_chk"><span class="m_tagItem" id="germany" data-country = "독일">#독일</span></label>
                <label for="taiwan_chk"><span class="m_tagItem" id="taiwan" data-country = "대만">#대만</span></label>
                <label for="australia_chk"><span class="m_tagItem" id="australia" data-country = "호주">#호주</span></label>
                <label for="brazil_chk"><span class="m_tagItem" id="brazil" data-country = "브라질">#브라질</span></label>
                <label for="india_chk"><span class="m_tagItem" id="india" data-country = "인도">#인도</span></label>
                <label for="russia_chk"><span class="m_tagItem" id="russia" data-country = "러시아">#러시아</span></label>
                <label for="denmark_chk"><span class="m_tagItem" id="denmark" data-country = "덴마크">#덴마크</span></label>
                <label for="mexico_chk"><span class="m_tagItem" id="mexico" data-country = "멕시코">#멕시코</span></label>
                <label for="switzerland_chk"><span class="m_tagItem" id="switzerland" data-country = "스위스">#스위스</span></label>

                <!-- OTT check -->
                <label for="netflex_chk"><span class="m_tagItem" id="netflex" data-ott = "8">#넷플릭스</span></label>
                <label for="watcha_chk"><span class="m_tagItem" id="watcha" data-ott = "97">#왓챠</span></label>
                <label for="disnep_chk"><span class="m_tagItem" id="disnep" data-ott = "337">#디즈니+</span></label>
                <label for="wavve_chk"><span class="m_tagItem" id="wavve" data-ott = "356">#웨이브</span></label>
                <label for="appletv_chk"><span class="m_tagItem" id="appletv" data-ott = "350">#Apple TV+</span></label>

                <!-- 리뷰 check -->
                <label for="review_500_chk"><span class="m_tagItem" id="review_500" data-review = "500">리뷰 500개 이상</span></label>
                <label for="review_400_chk"><span class="m_tagItem" id="review_400" data-review = "400">리뷰 400개 이상</span></label>
                <label for="review_300_chk"><span class="m_tagItem" id="review_300" data-review = "300">리뷰 300개 이상</span></label>

                <!-- 평점 check -->
                <label for="score5_chk"><span class="m_tagItem" id="score5" data-score = "5">평점 5개 이상</span></label>
                <label for="score4_chk"><span class="m_tagItem" id="score4" data-score = "4">평점 4개 이상</span></label>
                <label for="score3_chk"><span class="m_tagItem" id="score3" data-score = "3">평점 3개 이상</span></label>
            </div>
            <div class="chk_delete_btn">X</div>
        </div>

        <div class="m_mvBox">
            <div class="select_box">
                <select class="select_r">
                    <option value="latest" selected>최신순</option>
                    <option value="popularity">인기순</option>
                </select>
            </div>
            <div class="m_mvListBox">
                <!-- chk:: javascript에서 값 불러올 예정 -->
                <div class="nodata_txt">키워드를 골라 원하는 영화를 찾아보세요</div>
            </div>
        </div>
        <div class="m_moreBox">more</div>
    </main>
    <jsp:include page="footer.jsp"/>
</div>
<script src="<c:url value='/js/keyword.js'/> "></script>
</body>
</html>