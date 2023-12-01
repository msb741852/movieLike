<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page session="false" %> <%-- 이 페이지에서는 세션을 새로 생성 안하겠다 라는 뜻 --%>
<c:set var="sessionId" value="${ pageContext.request.getSession(false).getAttribute('liogdin')!=null? pageContext.request.getSession(false).getAttribute('liogdin'):null}" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movie Like</title>
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <link rel="icon" href="<c:url value='/img/favicon.ico'/>">
    <link rel="stylesheet" href="<c:url value='/css/common.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/detail_page.css'/>">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
</head>
<body>
<span id="sId" style="display: none">${sessionId}</span>
<div id="wrap">
    <jsp:include page="header.jsp"/>
    <main class="container">
        <div class="content1">
            <div class="detail_poster"><img src="https://image.tmdb.org/t/p/w500${mv.movPoster}" alt=""></div>
            <div class="detail_content">
                <div class="detail_top">
                    <div class="movie_title"> ${mv.movName}</div>
                    <span class="movie_year">${mv.movDate}</span>
                </div>
                <div class="movie_country">
                    <c:forEach var="country" items="${mv.countryNameList}" varStatus="status">
                        <span>${country}<c:if test="${fn:length(mv.countryNameList) != status.count}">,</c:if></span>
                    </c:forEach>
                </div>
                <div class="movie_genre">
                    <c:forEach var="genre" items="${mv.genreList}" varStatus="status">
                    <span>
                                ${genre}<c:if test="${fn:length(mv.genreList) != status.count}">,</c:if>
                            <span>
                                </c:forEach>
                </div>
                <div class="movie_ott_box">
                    <c:if test="${not empty mv.ottList}">
                        <c:forEach var="ott" items="${mv.ottList}">
                            <div class="float_L">
                                <div class="ott_img"><img src="<c:url value='/img/ott/${ott.ottId}.png'/>" alt="${ott.ottName}"></div>
                                <div class="movie_ott">${ott.ottName}</div>
                            </div>
                        </c:forEach>
                    </c:if>
                </div>
                <div class="avg_box">
                    <div class="star_icon"><img src="<c:url value='/img/star.png'/>" alt=""></div>
                    <div class="movie_avg">
                        <c:choose>
                            <c:when test="${mv.movScoreCnt != 0}">
                                <fmt:formatNumber value="${((mv.movScore) / (mv.movScoreCnt + 0.0))}" pattern=".0"/>
                            </c:when>
                            <c:otherwise>
                                0.0
                            </c:otherwise>
                        </c:choose>
                        (${mv.movScoreCnt})
                    </div>
                </div>
            </div>
            <div class="click_box">
                <div class="click_box1"><a href="">
                    <input type="checkbox" id="jjim">
                    <div class="jjim_box">
                        <label for="jjim">
                            <div class="click_icon ${ml == 1 ? "jjim_color" : ""}" id="jjim_img"><img src="<c:url value='/img/heart.png'/>" alt="찜"></div>
                        </label>
                    </div>
                    <div class="click_menu">찜</div>
                </a></div>
                <div class="click_box1"><a href="">
                    <input type="checkbox" id="check">
                    <div class="check_box">
                        <label for="check">
                            <div class="click_icon ${wm == 1 ? "watched_color" : ""}" id="watched_img"><img src="<c:url value='/img/check.png'/>" alt="찜"></div>
                        </label>
                    </div>
                    <div class="click_menu">봤어요</div>
                </a></div>
                <div class="click_box1" id="btn_share">
                    <div class="click_icon"><img src="<c:url value='/img/share.png'/>" alt="공유"></div>
                    <div class="click_menu">공유</div>
                </div>
                <div class="click_box1"><a href="#review_write" id="reviewWriteBtn">
                    <div class="click_icon"><img src="<c:url value='/img/write.png'/>" alt="리뷰작성"></div>
                    <div class="click_menu">리뷰작성</div>
                </a></div>
            </div>
            <div id="login_move_popup">
                <div class="login_page_move_icon"><img src="<c:url value='/img/login_page_move.png'/>" alt=""></div>
                <div class="login_txt">로그인이 필요한 기능입니다.</div>
                <div class="popup_btn_box">
                    <div class="popup_btn"><a href="<c:url value='/login/login?prevMovId=${mv.movId}'/>">로그인</a></div>
                    <div class="popup_btn" onclick="closeLoginPopup()">취소</div>
                </div>
                <div class="popup_close_btn" onclick="closeLoginPopup()"><img src="<c:url value='/img/close_btn.png'/>" alt=""></div>
            </div>

            <div class="best_review_box">
                <c:choose>
                    <c:when test="${not empty bestRvList}">
                        <div class="best_title">이 영화의 베스트 리뷰</div>
                        <div class="best_icon"><img src="<c:url value='/img/best_review.png'/>" alt=""></div>
                        <div class="best_box">
                            <c:forEach items="${bestRvList}" var="bestRv">
                                <div class="best">
                                    <div class="best_review_id">${bestRv.userNickname}</div>
                                    <div class="star_icon_best"><img src="<c:url value='/img/star.png'/>" alt=""></div>
                                    <div class="movie_star_best">${bestRv.rvScore}</div>
                                    <div class="best_review_txt">${bestRv.rvContent}</div>
                                    <div class="like_box">
                                        <div class="like_icon nofilter"><img src="<c:url value='/img/heart_cnt.png'/>" alt=""></div>
                                        <div class="like_cnt">${bestRv.rvLike}</div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="best_title">이 영화의 베스트 리뷰어가 되어보세요</div>
                        <div class="best_icon"><img src="<c:url value='/img/best_review.png'/>" alt=""></div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        <div class="content2">
            <div class="title_txt">줄거리</div>
            <div class="txt">${mv.movDesc}</div>
            <div class="title_txt">감독 / 출연배우</div>
            <div class="actor_box">
                <c:forEach items="${mv.actorList}" var="actor">
                    <div class="actor_box1">
                        <c:choose>
                            <c:when test="${empty actor.perImgSrc}">
                                <div class="photo"><img src="<c:url value='/img/profile_img.png'/>" alt=""></div>
                            </c:when>
                            <c:otherwise>
                                <div class="photo"><img src="https://image.tmdb.org/t/p/w400/${actor.perImgSrc}" alt=""></div>
                            </c:otherwise>
                        </c:choose>
                        <div class="photo_name">${actor.perName}</div>
                    </div>
                </c:forEach>
            </div>
            <c:if test="${not empty mv.movTrailer}">
                <div class="title_txt">예고편 영상</div>
                <div class="preview">
                    <iframe
                            src="https://www.youtube.com/embed/${mv.movTrailer}?si=MLICGmo6npmC-CJj&amp;controls=1&autoplay=1&mute=1&loop=1&rel=0"
                            title="YouTube video player"
                            frameborder="0"
                            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                            allowfullscreen
                    ></iframe>
                </div>
            </c:if>
            <div class="review_box" id="review_write">
                <div class="write_box">
                    <div class="title_txt">리뷰 작성</div>
                    <div class="star_score_box">
                        <input type="radio" name="star_rd" class="star_none" value="5" id="star5">
                        <div class="star_score"><label for="star5"><img src="<c:url value='/img/star.png'/>" alt="" class="img_pointer"></label></div>
                        <input type="radio" name="star_rd" class="star_none" value="4" id="star4">
                        <div class="star_score"><label for="star4"><img src="<c:url value='/img/star.png'/>" alt="" class="img_pointer"></label></div>
                        <input type="radio" name="star_rd" class="star_none" value="3" id="star3">
                        <div class="star_score"><label for="star3"><img src="<c:url value='/img/star.png'/>" alt="" class="img_pointer"></label></div>
                        <input type="radio" name="star_rd" class="star_none" value="2" id="star2">
                        <div class="star_score"><label for="star2"><img src="<c:url value='/img/star.png'/>" alt="" class="img_pointer"></label></div>
                        <input type="radio" name="star_rd" class="star_none" value="1" id="star1">
                        <div class="star_score"><label for="star1"><img src="<c:url value='/img/star.png'/>" alt="" class="img_pointer"></label></div>
                    </div>
                    <input type="text" class="review_write" name="reviewContent" placeholder="리뷰 내용을 입력해주세요.">
                    <input type="button" class="review_write_btn" id="btn_review_write" value="등록">
                </div>
                <div class="all_review">
                    <div class="title_txt">모든 리뷰</div>
                    <select class="select_r">
                        <option value="latest" selected>최신순</option>
                        <option value="like">좋아요순</option>
                    </select>
                    <div class="review_list" id="review_list"></div>

                    <div class="page_box">
                        <div class="prev_btn">〈</div>
                        <div class="next_btn">〉</div>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <jsp:include page="footer.jsp"/>
</div>
<script src="<c:url value='/js/detail.js'/>"></script>
<script>
    $(document).on('click', '#btn_share', function () {
        navigator.clipboard.writeText(location.href);
        Swal.fire({
            title: '현재 주소를 복사하였습니다.',
        })
    })
    let movId = ${param.movId};
    let pageSize = 10;
    $('#reviewWriteBtn').click(function () {
        setTimeout( function(){ $('.review_write').focus();}, 50 );
    });
    let reviewChk = false;

    // 찜 비동기 통신
    $(document).on('click', '#jjim_img',function () {
            $.ajax({
                type: 'POST',
                url: '/app/myList/IoD', // IoD - Insert or Delete
                headers: {"content-type" : "application/json"},
                dataType:'text',
                data: JSON.stringify({movId: movId}),
                success: function (result) {
                    jjimClick();
                },
                error: function (request, error) {
                    idChkPopup();
                }
            });
        }
    );
    // 봤어요 비동기 통신
    $(document).on('click', '#watched_img',function () {
            $.ajax({
                type: 'POST',
                url: '/app/watched/IoD', // IoD - Insert or Delete
                headers: {"content-type" : "application/json"},
                dataType:'text',
                data: JSON.stringify({movId: movId}),
                success: function (result) {
                    watchedClick();
                },
                error: function (request, error) {
                    idChkPopup();
                }
            });
        }
    );
    // 리뷰 추가 비동기 통신
    $(document).on('click', '#btn_review_write',function () {
            if("${sessionId}" == "") {
                idChkPopup();
            } else {
                $.ajax({
                    type: 'POST',
                    url: '/app/review/confirm',
                    headers: {"content-type" : "application/json"},
                    dataType:'text',
                    data: JSON.stringify(movId),
                    success: function (confirm) {
                        if(confirm === "0") {
                            let result =  writeBtnChk();
                            if(result != null) {
                                $.ajax({
                                    type: 'POST',
                                    url: '/app/review/add', // IoD - Insert or Delete
                                    headers: {"content-type": "application/json"},
                                    dataType: 'text',
                                    data: JSON.stringify({movId: movId, rvScore: result.starChk, rvContent: result.contentChk}),
                                    success: function (result) {
                                        showReviewAll(1, 0);
                                        setReviewPage();
                                        $('.select_r option').prop("selected", "");
                                        $('option[value=latest]').prop("selected", true);
                                        maxReviewCnt = maxReviewCnt < 1 ? 1 : maxReviewCnt;
                                        showPageNation();
                                        $("input[name='star_rd']").prop('checked', false);
                                        $("input[name='reviewContent']").prop("value", "");
                                    },
                                    error: function (request, error) {
                                        alert("로그인 세션 가져오기 실패요");
                                        alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
                                    }
                                })
                            }
                        } else {
                            Swal.fire( {
                                title: '회원님은 이미 리뷰를 작성하셨습니다.'
                            })
                        }

                    },
                    error: function () {
                        Swal.fire({
                            title: '리뷰 추가 중 ERROR. 관리자에게 문의하세요.',
                        })
                    }
                });
            }
        }
    )

    /* 리뷰 범위 불러오기 */
    let showReviewAll = (nowPage, mode) => {
        mode = mode == "like" ? 1 : 0;
        nowPage = (+nowPage - 1) * 10;
        $.ajax({
            type:'POST',
            url: '/app/review/read/all',
            headers: {"content-type": "application/json"},
            data: JSON.stringify({movId: movId, nowPage: nowPage, pageSize: pageSize, mode: mode}),
            success : function(result){
                $("#review_list").html(toHtml(result));
                var txtArea = $(".review_content");
                if (txtArea) {
                    txtArea.each(function(){
                        $(this).height(this.scrollHeight);
                    });
                }
                const DEFAULT_HEIGHT = 30; // textarea 기본 height
                const $textarea = document.querySelector('.review_content');
                if ($textarea != null) {
                    $textarea.oninput = (event) => {
                        const $target = event.target;
                        $target.style.height = 0;
                        $target.style.height = DEFAULT_HEIGHT + $target.scrollHeight + 'px';
                    };
                }
            },
            error   : function(){
                alert("error 리뷰 다 불러오기");
            }
        })};

    let startNum = 1;
    let endNum = startNum + pageSize - 1;
    let showPageNation = () => {
        endNum = endNum > maxReviewCnt ? maxReviewCnt : endNum;
        if(endNum == 0 && maxReviewCnt > 0 ) {
            endNum = maxReviewCnt;
        }
        $('.num').remove();
        let reviewPageTxt = "";
        for (let i = startNum; i <= endNum; i++) {
            if(i != startNum) {
                reviewPageTxt += "<div class='num'>" + i + "</div>"
            } else {
                reviewPageTxt += "<div class='num page_clicked'>" + i + "</div>"
            }
        }
        $(".prev_btn").after(reviewPageTxt);
    }
    let maxReviewCnt = null;
    let setReviewPage = () => {
        $.ajax({
            type:'POST',
            url: '/app/review/read/cnt',
            headers: {"content-type": "application/json"},
            data: JSON.stringify(movId),
            success : function(reviewCnt){
                maxReviewCnt = reviewCnt % pageSize == 0 ? reviewCnt % pageSize : Math.floor(reviewCnt / pageSize + 1);
                showPageNation();
                maxReviewCnt <= 10 ? $('.next_btn').css("display", "none") : $(".next_btn").css("display", "block");
            },
            error   : function(){
                alert("error 리뷰 개수 불러오기 실패");
                alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
            }
        })};
    setReviewPage();
    showReviewAll(1, 0);

    let btnNoneBlock = () => {
        if(endNum != maxReviewCnt) {
            $('.next_btn').css("display", "block");
        } else {
            $('.next_btn').css("display", "none");
        }
        if(startNum != 1) {
            $('.prev_btn').css("display", "block");
        } else {
            $('.prev_btn').css("display", "none");
        }
    }
    $('.next_btn').click(() => {
        startNum += 10;
        endNum += 10;
        if(endNum > maxReviewCnt) {
            endNum = maxReviewCnt;
        }
        btnNoneBlock();
        showPageNation();
        showReviewAll(startNum, $('.select_r').val());
    });
    $('.prev_btn').click(() => {
        startNum -= 10;
        if(endNum - startNum != 9) {
            endNum = startNum + pageSize - 1;
        } else {
            endNum -= 10;
        }
        if(startNum < 1) {
            startNum = 1;
        }
        btnNoneBlock();
        showPageNation();
        showReviewAll(startNum, $('.select_r').val());
    });

    let toHtml = function(reviewList) {
        let review_result ="";
        reviewList.forEach(function(review) {
            let rvId = review.rvId;
            let userId = review.userId;
            let nickname = review.userNickname;
            let rvScore = review.rvScore;
            let rvContent = review.rvContent.replaceAll(" ", "&nbsp");
            let rvLike = review.rvLike;
            let rvLikeChk = review.rvLikeChk ? "like_color" : "";
            let dt = new Date(review.rvRegDate);
            let year=dt.getFullYear();
            let mon=dt.getMonth() + 1 < 10 ? "0"+ dt.getMonth() + 1 : dt.getMonth() +1 ;
            let date=dt.getDate() < 10 ? "0"+ dt.getDate() : dt.getDate();
            let fullDate = year + "-" + mon + "-" + date;
            review_result += "<div class='review_list_box'>"
            review_result += "<div class='list_line'></div>"
            review_result += "<div class='review_title_box'>"
            review_result += "<div class='nickname'>"+nickname+"</div>"
            review_result += "<div class='star_icon1'><img src='<c:url value='/img/star.png'/>'></div>"
            review_result += "<div class='movie_avg1'>"+rvScore+"</div>"
            review_result += "<div class='write_date'>"+fullDate+"</div></div>"
            review_result += "<textarea rows='1' class='review_content' readonly data-rvid='"+rvId+"'>"+rvContent+"</textarea>"
            if(userId == "${sessionId}") {
                review_result += "<div class='update_box'>"
                review_result += "<div class='update_btn review_update'>수정</div>"
                review_result += "<div class='update_btn review_delete' data-rvid='"+rvId+"'>삭제</div></div>"
            }
            review_result += "<div class='like_box_chk'>"
            review_result += "<input type='checkbox' id='like'>"
            review_result += "<div class='like_icon_box'><label for='like'><div class='like_icon rv_like_icon "+rvLikeChk+"' data-review='"+rvId+"' id='like_img"+rvId+"'><img src='<c:url value='/img/heart.png'/>' alt='찜'></div></label></div>"
            review_result += "<div class='like_cnt'>"+rvLike+"</div></div></div>"
        })
        return review_result;
    }
    $(
        $(document).on('click', '.rv_like_icon', function () {
            let rvId = $(this).data("review");
            $.ajax({
                type: 'POST',
                url: '/app/review/like/IoD', // IoD - Insert or Delete
                headers: {"content-type" : "application/json"},
                dataType:'text',
                data: JSON.stringify({movId: movId, rvId: rvId}),
                success: function (result) {
                    showReviewAll($(".page_clicked").text(), $('.select_r').val());
                    likeClick();
                },
                error: function (request, error) {
                    idChkPopup();
                }
            });
        })
    );
    $(document).on('change', '.select_r', function () {
        $('.num').removeClass('page_clicked');
        $('.num').eq(0).addClass('page_clicked');
        showReviewAll(1, $('.select_r').val());
        startNum = 1;
        endNum = maxReviewCnt < 10 ? maxReviewCnt : 10 ;
        showPageNation();
        btnNoneBlock();
    });
    $(document).on('click', '.num', function () {
        $('.num').removeClass('page_clicked');
        $(this).addClass('page_clicked');
        showReviewAll($(".page_clicked").text(), $('.select_r').val());
    })
    let inputText = "";
    $(document).on('click', '.review_update', function () {
        $(this).text("수정");
        $(this).next().text("취소");
        $(this).addClass("modify_btn");
        $(this).next().addClass("cancel_btn");
        let inputBox = $(this).parent().prev();
        inputBox.prop("readOnly", false);
        inputBox.css("color","black");
        inputBox.css("padding", "10px");
        inputBox.css("background", "white");
        inputText = inputBox.val();
        inputBox.focus();
        inputBox.prop("value", "");
        inputBox.prop("value",inputText);
    })

    $(document).on('click', '.modify_btn', function () {
        let updateContent = $(this).parent().prev().val();
        let rvId = $(this).parent().prev().data("rvid");
        $.ajax({
            type: 'POST',
            url: '/app/review/modify',
            headers: {"content-type" : "application/json"},
            dataType:'text',
            data: JSON.stringify({rvId: rvId, rvContent: updateContent}),
            success: function (result) {
                showReviewAll($(".page_clicked").text(), $('.select_r').val());
            },
            error: function (request, error) {
                idChkPopup();
            }
        })
    });

    $(document).on('click', '.review_delete', function () {
        if($(this).text() == "삭제") {
            let rvId = $(this).data("rvid");
            content_delete(rvId);
        } else {
            let inputBox = $(this).parent().prev();
            $(this).text("삭제");
            $(this).prev().removeClass("modify_btn");
            $(this).removeClass("cancel_btn");
            inputBox.prop("readOnly", true);
            inputBox.prop("style", "");
            inputBox.prop("value",inputText);
        }
    })
    function content_delete(rvId) {
        Swal.fire({
            title: '삭제하시겠습니까?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: "#AD8B73",
            cancelButtonColor: "#BEBCBA",
            confirmButtonText: '확인',
            cancelButtonText: '취소',
            reverseButtons: false,
        }).then(result => {
            if (!result.isConfirmed) return;
            $.ajax({
                type:'POST',
                url: '/app/review/delete',
                headers: {"content-type": "application/json"},
                data: JSON.stringify(rvId),
                success : function(data) {
                    showReviewAll(1, $('.select_r').val());
                    setReviewPage();
                },
                error : function(e) {
                    console.log(e);
                }
            });
        })
    };

</script>
</body>
</html>