<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="sessionId" value="${ pageContext.request.getSession(false).getAttribute('liogdin')!=null? pageContext.request.getSession(false).getAttribute('liogdin'):null}" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movie Like</title>
    <link rel="icon" href="<c:url value='/img/favicon.ico'/>">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <link rel="stylesheet" href="<c:url value='/css/common.css'/> ">
    <link rel="stylesheet" href="<c:url value='/css/join_page.css'/> ">
    <link rel="stylesheet" href="<c:url value='/css/my_page.css'/> ">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
</head>
<body>
<div id="wrap">
    <jsp:include page="header.jsp"/>
    <main class="container">
        <div class="content">
            <div class="my_genre">
                <c:forEach var="genre" items="${genre_list}">
                    <input type="button" class="genre" value="#${genre.genrName}" onclick="genreClick(${genre.genrId}, '${genre.genrName}')">
                </c:forEach>
            </div>
            <div class="nickname_txt">${sessionScope.liogdinn}</div>
            <div class="user_id">${sessionScope.liogdine}</div>
            <div class="update_icon">
                <img src="<c:url value='/img/set.png'/>" alt="" class="icon_hover">
                <div class="update_hover_box">
                    <div class="my_change_btn" onclick="updateCheck('')">개인정보변경</div>
                    <div class="my_end_btn" onclick="unregister()">회원탈퇴</div>
                </div>
            </div>
            <div id="popup" class="popup">
                <div class="popup_content">
                    <table>
                        <tr>
                            <th class="th1">이메일</th>
                            <th>
                                <span id="id_ok" class="id_ok confirm_sub">사용 가능한 이메일입니다.</span>
                                <span id="id_already" class="id_already confirm_sub">이미 사용중인 이메일입니다.</span>
                                <input type="email" class="login_input" id="email" name="userEmail" placeholder="이메일 형식으로 입력해주세요" onblur= "checkIdModify()" minlength="10" maxlength="25" >
                            </th>
                        </tr>
                        <tr>
                            <th class="th1">비밀번호</th>
                            <th>
                                <div class="ok-text confirm_sub"></div>
                                <input type="password" name="userPw" id="password" class="login_input" minlength="8" maxlength="16" placeholder=" 비밀번호 - 영문(대,소),숫자,특수문자 포함 8자 이상 " onblur="check_pw();">
                            </th>
                        </tr>
                        <tr>
                            <th class="th1">비밀번호 확인</th>
                            <th>
                                <input type="password" name="password_chk" id="password_chk" class="login_input" minlength="8" maxlength="16" placeholder=" 비밀번호 확인 " onblur="check_pw();">
                            </th>
                        </tr>
                        <tr>
                            <th class="th1">이름</th>
                            <th>
                                <input type="text" name="userName" id="name" class="login_input" placeholder="이름 입력 (한글만가능)" minlength="2" maxlength="10" onblur="checkName();">
                            </th>
                        </tr>
                        <tr>
                            <th class="th1">생년월일</th>
                            <th>
                                <select class="birthday" name="userBirth1" id="birth_year">
                                    <option selected disabled>출생연도</option>
                                </select>
                                <select class="birthday" name="userBirth2" id="birth_month">
                                    <option value="월" selected disabled>월</option>
                                </select>
                                <select class="birthday" name="userBirth3" id="birth_date">
                                    <option value="일" selected disabled>일</option>
                                </select>
                            </th>
                        </tr>
                        <tr>
                            <th class="th1">전화번호</th>
                            <th>
                                <span id="ph_ok" class="ph_ok confirm_sub">사용 가능한 번호입니다.</span>
                                <span id="ph_already" class="ph_already confirm_sub">이미 사용중인 번호입니다.</span>
                                <input type="text" name="userPhone1" class="phone_input" id="hp1" minlength="3" maxlength="3"  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" value="010" disabled>
                                <input type="text" name="userPhone2" class="phone_input" id="hp2" minlength="4"   maxlength="4" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" placeholder="4자 이상"  onblur="checkphModify()">
                                <input type="text" name="userPhone3" class="phone_input" id="hp3" minlength="4"  maxlength="4" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" placeholder="4자 이상"  onblur="checkphModify()">
                            </th>
                        </tr>
                        <tr>
                            <th class="th1">닉네임</th>
                            <th> <p><span id="nick_ok" style="font-size:12px;" class="nick_ok">사용 가능한 닉네임입니다.</span><span id="nick_already" style="font-size:12px;" class="nick_already">이미 사용중인 닉네임입니다.</span>
                                <input type="text" name="userNickname" id="nickname" class="login_input" placeholder="한글 초성 및 모음 제외한 2자 이상 16자 이하," onblur="checkNickModify()"></th>
                        </tr>
                        <tr>
                            <th class="th1">나의 관심 장르<br><span class="genre_sub">(최대 3개 선택)</span></th>
                            <th>
                                <input type="checkbox" name="genre_chk" id="genre1" class="genre_checkbox" data-genr="10749" >
                                <span class="genre_label_chk"><label for="genre1"><span class="genre">로맨스</span></label></span>
                                <input type="checkbox" name="genre_chk" id="genre2" class="genre_checkbox"  data-genr="28">
                                <span class="genre_label_chk"><label for="genre2"><span class="genre">액션</span></label></span>
                                <input type="checkbox" name="genre_chk" id="genre3" class="genre_checkbox" data-genr="16">
                                <span class="genre_label_chk"><label for="genre3"><span class="genre">애니메이션</span></label></span>
                                <input type="checkbox" name="genre_chk" id="genre4" class="genre_checkbox" data-genr="27">
                                <span class="genre_label_chk"><label for="genre4"><span class="genre">공포</span></label></span>
                                <input type="checkbox" name="genre_chk" id="genre5" class="genre_checkbox" data-genr="35">
                                <span class="genre_label_chk"><label for="genre5"><span class="genre">코미디</span></label></span>
                                <input type="checkbox" name="genre_chk" id="genre6" class="genre_checkbox" data-genr="14">
                                <span class="genre_label_chk"><label for="genre6"><span class="genre">판타지</span></label></span>
                                <input type="checkbox" name="genre_chk" id="genre7" class="genre_checkbox" data-genr="12">
                                <span class="genre_label_chk"><label for="genre7"><span class="genre">모험</span></label></span>
                                <input type="checkbox" name="genre_chk" id="genre8" class="genre_checkbox" data-genr="9648">
                                <span class="genre_label_chk"><label for="genre8"><span class="genre">미스터리</span></label></span>
                                <input type="checkbox" name="genre_chk" id="genre9" class="genre_checkbox" data-genr="53">
                                <span class="genre_label_chk"><label for="genre9"><span class="genre">스릴러</span></label></span>
                                <input type="checkbox" name="genre_chk" id="genre10" class="genre_checkbox" data-genr="18">
                                <span class="genre_label_chk"><label for="genre10"><span class="genre">드라마</span></label></span>
                                <input type="checkbox" name="genre_chk" id="genre11" class="genre_checkbox" data-genr="99">
                                <span class="genre_label_chk"><label for="genre11"><span class="genre">다큐멘터리</span></label></span>
                                <input type="checkbox" name="genre_chk" id="genre12" class="genre_checkbox" data-genr="37">
                                <span class="genre_label_chk"><label for="genre12"><span class="genre">서부</span></label></span>
                                <input type="checkbox" name="genre_chk" id="genre13" class="genre_checkbox" data-genr="878">
                                <span class="genre_label_chk"><label for="genre13"><span class="genre">SF</span></label></span>
                                <input type="checkbox" name="genre_chk" id="genre14" class="genre_checkbox" data-genr="80">
                                <span class="genre_label_chk"><label for="genre14"><span class="genre">범죄</span></label></span>
                                <input type="checkbox" name="genre_chk" id="genre15" class="genre_checkbox" data-genr="36">
                                <span class="genre_label_chk"><label for="genre15"><span class="genre">역사</span></label></span>
                                <input type="checkbox" name="genre_chk" id="genre16" class="genre_checkbox" data-genr="10402">
                                <span class="genre_label_chk"><label for="genre16"><span class="genre">음악</span></label></span>
                                <input type="checkbox" name="genre_chk" id="genre17" class="genre_checkbox" data-genr="10751">
                                <span class="genre_label_chk"><label for="genre17"><span class="genre">가족</span></label></span>
                                <input type="checkbox" name="genre_chk" id="genre18" class="genre_checkbox" data-genr="10752">
                                <span class="genre_label_chk"><label for="genre18"><span class="genre">전쟁</span></label></span>
                                <input type="checkbox" name="genre_chk" id="genre19" class="genre_checkbox" data-genr="10770">
                                <span class="genre_label_chk"><label for="genre19"><span class="genre">TV 영화</span></label></span>
                            </th>
                        </tr>
                        <tr>
                            <th colspan="2">
                                <input type="button" class="user_update_btn" value="수정" onclick="updatePopup()">
                                <input type="button" class="user_update_btn" value="취소" onclick="closePopup()">
                            </th>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="btn_box">
                <div class="btn_each_box btn_myreview">
                    <a href="#my_review">
                        <div class="my_review_cnt">${reviews_count}</div>
                        <div class="my_txt">리뷰</div>
                    </a>
                </div>
                <div class="btn_each_box" >
                    <a href="#" onClick="moveList('myView', ${watched_count})">
                        <div class="my_watched_cnt">${watched_count}</div>
                        <div class="my_txt">봤어요</div>
                    </a>
                </div>
                <div class="btn_each_box">
                    <a href="#" onClick="moveList('myLike', ${list_count})">
                        <div class="my_like_cnt">${list_count}</div>
                        <div class="my_txt">찜</div>
                    </a>
                </div>
            </div>
            <div class="chart_box">
                <div class="chart_title">나의 평점 차트</div>
                <canvas id="myChart"></canvas>
            </div>
            <div class="review_box" id="my_review">
                <div class="myreview_title_txt">내가 쓴 리뷰</div>
                <select class="select_r" onchange="changeOrder(this)">
                    <option value="new" ${orderType == 'new' ? 'selected' : ''}>최신순</option>
                    <option value="like" ${orderType == 'like' ? 'selected' : ''}>좋아요순</option>
                </select>
                <div class="my_review_list">
                    <c:forEach var="data" items="${review_list}">
                        <div class="review_list_box">
                            <div class="list_line"></div>
                            <div class="review_title_box">
                                <div class="review_movie_name">
                                        ${data.movName}</div>
                                <div class="write_date"><fmt:formatDate value="${data.rvRegDate}" pattern="yyyy-MM-dd" /></div>
                            </div>
                            <textarea rows="1" class="review_content" readonly onchange="handleResizeHeight()">${data.rvContent}</textarea>
                            <input type="hidden" id="reviewId" value="${data.rvId}"/>
                            <div class="star_icon1"><img src="<c:url value='/img/star.png'/>" alt=""></div>
                            <div class="movie_avg1">${data.rvScore}</div>
                            <div class="like_box">
                                <div class="like_icon"><img src="<c:url value='/img/heart_cnt.png'/>" alt=""></div>
                                <div class="like_cnt">${data.rvLike}</div>
                            </div>
                            <div class="update_box">
                                <div class="update_btn review_update">수정</div>
                                <div class="update_btn review_delete">삭제</div>
                            </div>
                        </div>
                    </c:forEach>
                    <div class="page_box">
                        <c:if test="${currentPage > 1}">
                            <div class="prev_btn"><a href="?page=${currentPage - 1}&pageSize=${pageSize}&orderType=${orderType}">&lt;</a></div>
                        </c:if>
                        <c:forEach var="i"
                                   begin="${startPage}"
                                   end="${(startPage + 9<= totalPages) ? (startPage + 9) : totalPages}"
                                   step="1">
                            <c:if test="${i <= totalPages}">
                                <div class="num">
                                    <a href="?page=${i}&pageSize=${pageSize}&orderType=${orderType}"
                                       style="${i eq currentPage ? 'color: #a785ef;' : ''}">
                                            ${i}
                                    </a>
                                </div>
                            </c:if>
                        </c:forEach>
                        <c:if test="${currentPage < totalPages}">
                            <div class="next_btn"><a href="?page=${currentPage + 1}&pageSize=${pageSize}&orderType=${orderType}">&gt;</a></div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
        <div class="img_box"><img src="<c:url value='/img/move_gif.gif'/>" alt=""></div>
    </main>
    <jsp:include page="footer.jsp"/>

    <c:forEach var="data" items="${review_score}">
        <input type="hidden" name="review_score" value="${data.rvScore}/${data.scoreCount}">
    </c:forEach>
</div>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script> var sessionId = '<c:out value="${sessionId}"/>'; </script>
<script src="<c:url value='/js/join.js'/>" defer></script>
<script src="<c:url value='/js/mypage.js'/>"></script>
<script>
    $(window).load(function(){
        /*
        score점수를 input hidden으로 추가하고 해당데이터를 가져와서 차트 데이터를 만들어준다.
        ajax로 api를 따로 뺴서 하면 더 간단하게 처리할수 있다.
         */
        scores = document.getElementsByName("review_score")
        scores_data = {}
        for (var i = 0; i < scores.length; i++) {
            data = scores[i].value.split("/")
            scores_data[data[0]] = data[1]
        }
        /*
        점수/갯수 이렇게 되어있는걸 javascript object로 바꿔준다.
        {점수: 갯수, ....} 이런식으로
         */

        data = []
        for(var i=1; i<=5; i++) {
            /*
            차트를 위한 데이터를 만든다. 총5개의 데이터가 필요하며
            위에 갯수가 있으면 해당 점수의 갯수를 가져와 넣어주고
            없으면 0을 입력한다.
             */
            if (scores_data[i] != null) {
                data.push(scores_data[i])
            } else {
                data.push(0)
            }
        }
        // 차트 생성 함수 호출
        chartInit(data)
    })
</script>
</body>
</html>