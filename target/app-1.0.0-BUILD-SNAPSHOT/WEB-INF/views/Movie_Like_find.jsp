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
    <link rel="stylesheet" href="<c:url value='/css/common.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/find_page.css'/>">
</head>
<body>
<div id="wrap">
    <jsp:include page="header.jsp"/>
    <main class="container">
        <div class="content">
            <div class="content_box">
                <div class="title_box">
                    <div class="title">장르별</div>
                </div>
                <div class="find_content_box">
                    <div class="content_list content_list5 genre_height content_hover">
                        <a href="<c:url value='/list/chart?title=genr&val=12&valName=모험'/>">
                            <div class="adventure"></div>
                            <div class="content_list_title">모험</div>
                        </a>
                    </div>
                    <div class="content_list content_list5 genre_height content_hover">
                        <a href="<c:url value='/list/chart?title=genr&val=14&valName=판타지'/>">
                            <div class="fantasy"></div>
                            <div class="content_list_title">판타지</div>
                        </a>
                    </div>
                    <div class="content_list content_list5 genre_height content_hover">
                        <a href="<c:url value='/list/chart?title=genr&val=16&valName=애니메이션'/>">
                            <div class="animation"></div>
                            <div class="content_list_title">애니메이션</div>
                        </a>
                    </div>
                    <div class="content_list content_list5 genre_height content_hover">
                        <a href="<c:url value='/list/chart?title=genr&val=18&valName=드라마'/>">
                            <div class="drama"></div>
                            <div class="content_list_title">드라마</div>
                        </a>
                    </div>
                    <div class="content_list content_list5 genre_height content_hover">
                        <a href="<c:url value='/list/chart?title=genr&val=27&valName=공포'/>">
                            <div class="horror"></div>
                            <div class="content_list_title">공포</div>
                        </a>
                    </div>
                    <div class="content_list content_list5 genre_height content_hover">
                        <a href="<c:url value='/list/chart?title=genr&val=28&valName=액션'/>">
                            <div class="action"></div>
                            <div class="content_list_title">액션</div>
                        </a>
                    </div>
                    <div class="content_list content_list5 genre_height content_hover">
                        <a href="<c:url value='/list/chart?title=genr&val=35&valName=코미디'/>">
                            <div class="comedy"></div>
                            <div class="content_list_title">코미디</div>
                        </a>
                    </div>
                    <div class="content_list content_list5 genre_height content_hover">
                        <a href="<c:url value='/list/chart?title=genr&val=36&valName=역사'/>">
                            <div class="history"></div>
                            <div class="content_list_title">역사</div>
                        </a>
                    </div>
                    <div class="content_list content_list5 genre_height content_hover">
                        <a href="<c:url value='/list/chart?title=genr&val=37&valName=서부'/>">
                            <div class="western"></div>
                            <div class="content_list_title">서부</div>
                        </a>
                    </div>
                    <div class="content_list content_list5 genre_height content_hover">
                        <a href="<c:url value='/list/chart?title=genr&val=53&valName=스릴러'/>">
                            <div class="thriller"></div>
                            <div class="content_list_title">스릴러</div>
                        </a>
                    </div>
                    <div class="content_list content_list5 genre_height content_hover">
                        <a href="<c:url value='/list/chart?title=genr&val=80&valName=범죄'/>">
                            <div class="crime"></div>
                            <div class="content_list_title">범죄</div>
                        </a>
                    </div>
                    <div class="content_list content_list5 genre_height content_hover">
                        <a href="<c:url value='/list/chart?title=genr&val=99&valName=다큐멘터리'/>">
                            <div class="documentary"></div>
                            <div class="content_list_title">다큐멘터리</div>
                        </a>
                    </div>
                    <div class="content_list content_list5 genre_height content_hover">
                        <a href="<c:url value='/list/chart?title=genr&val=878&valName=SF'/>">
                            <div class="sf_image"></div>
                            <div class="content_list_title">SF</div>
                        </a>
                    </div>
                    <div class="content_list content_list5 genre_height content_hover">
                        <a href="<c:url value='/list/chart?title=genr&val=9648&valName=미스터리'/>">
                            <div class="mystery"></div>
                            <div class="content_list_title">미스터리</div>
                        </a>
                    </div>
                    <div class="content_list content_list5 genre_height content_hover">
                        <a href="">
                            <a href="<c:url value='/list/chart?title=genr&val=10402&valName=음악'/>">                                <div class="music"></div>
                                <div class="content_list_title">음악</div>
                            </a>
                    </div>
                    <div class="content_list content_list5 genre_height content_hover">
                        <a href="<c:url value='/list/chart?title=genr&val=10749&valName=로맨스'/>">
                            <div class="romance"></div>
                            <div class="content_list_title">로맨스</div>
                        </a>
                    </div>
                    <div class="content_list content_list5 genre_height content_hover">
                        <a href="<c:url value='/list/chart?title=genr&val=10751&valName=가족'/>">
                            <div class="family"></div>
                            <div class="content_list_title">가족</div>
                        </a>
                    </div>
                    <div class="content_list content_list5 genre_height content_hover">
                        <a href="<c:url value='/list/chart?title=genr&val=10752&valName=전쟁'/>">
                            <div class="war"></div>
                            <div class="content_list_title">전쟁</div>
                        </a>
                    </div>
                    <div class="content_list content_list5 genre_height content_hover">
                        <a href="<c:url value='/list/chart?title=genr&val=10770&valName=TV&nbsp;영화'/>">
                            <div class="tv"></div>
                            <div class="content_list_title">TV 영화</div>
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <div class="content">
            <div class="content_box">
                <div class="title_box">
                    <div class="title">국가별</div>
                </div>
                <div class="find_content_box">
                    <div class="content_list5 country_hover">
                        <a href="<c:url value='/list/chart?title=country&val=대한민국'/>">
                            <div class="korea_movie"></div>
                            <div class="content_list_title">대한민국</div>
                        </a>
                    </div>
                    <div class="content_list5 country_hover">
                        <a href="<c:url value='/list/chart?title=country&val=미국'/>">
                            <div class="america_movie"></div>
                            <div class="content_list_title">미국</div>
                        </a>
                    </div>
                    <div class="content_list5 country_hover">
                        <a href="<c:url value='/list/chart?title=country&val=영국'/>">
                            <div class="uk_movie"></div>
                            <div class="content_list_title">영국</div>
                        </a>
                    </div>
                    <div class="content_list5 country_hover">
                        <a href="<c:url value='/list/chart?title=country&val=일본'/>">
                            <div class="japan_movie"></div>
                            <div class="content_list_title">일본</div>
                        </a>
                    </div>
                    <div class="content_list5 country_hover">
                        <a href="<c:url value='/list/chart?title=country&val=중국'/>">
                            <div class="china_movie"></div>
                            <div class="content_list_title">중국</div>
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <div class="content">
            <div class="content_box">
                <div class="title_box">
                    <div class="title">OTT별</div>
                </div>
                <div class="find_content_box">
                    <div class="content_list5 country_hover"><a href="<c:url value='/list/chart?title=ott&val=8&valName=넷플릭스'/>"><div class="netflex_movie h_100"></div></a></div>
                    <div class="content_list5 country_hover"><a href="<c:url value='/list/chart?title=ott&val=337&valName=디즈니+'/>"><div class="disnep h_100"></div></a></div>
                    <div class="content_list5 country_hover"><a href="<c:url value='/list/chart?title=ott&val=97&valName=왓챠'/>"><div class="watcha h_100"></div></a></div>
                    <div class="content_list5 country_hover"><a href="<c:url value='/list/chart?title=ott&val=356&valName=웨이브'/>"><div class="wavve h_100"></div></a></div>
                    <div class="content_list5 country_hover"><a href="<c:url value='/list/chart?title=ott&val=350&valName=Apple&nbsp;TV+'/>"><div class="appletv h_100"></div></a></div>
                    <%--                        <div class="content_list6"><a href="<c:url value='/list/chart?title=ott&val=96&valNam=네이버시리즈온'/>"><div class="naver_series h_100"></div></a></div>--%>
                </div>
            </div>
        </div>
        <div class="content">
            <div class="content_box">
                <div class="title_box">
                    <div class="title">연도별</div>
                </div>
                <div class="find_content_box">
                    <div class="content_list5">
                        <a href="<c:url value='/list/chart?title=year&val=1989'/>">
                            <div class="bg1"></div>
                            <div class="content_list_title">1990년대 이전</div>
                        </a>
                    </div>
                    <div class="content_list5">
                        <a href="<c:url value='/list/chart?title=year&val=1990'/>">
                            <div class="bg2"></div>
                            <div class="content_list_title">1990년대</div>
                        </a>
                    </div>
                    <div class="content_list5">
                        <a href="<c:url value='/list/chart?title=year&val=2000'/>">
                            <div class="bg3"></div>
                            <div class="content_list_title">2000년대</div>
                        </a>
                    </div>
                    <div class="content_list5">
                        <a href="<c:url value='/list/chart?title=year&val=2010'/>">
                            <div class="bg4"></div>
                            <div class="content_list_title">2010년대</div>
                        </a>
                    </div>
                    <div class="content_list5">
                        <a href="<c:url value='/list/chart?title=year&val=2020'/>">
                            <div class="bg5"></div>
                            <div class="content_list_title">2020년대</div>
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <div class="content">
            <div class="content_box">
                <div class="title_box">
                    <div class="title">나이대별</div>
                </div>
                <div class="find_content_box">
                    <div class="content_list5">
                        <a href="<c:url value='/list/chart?title=age&val=10'/>">
                            <div class="age10"></div>
                            <div class="content_list_title">10대</div>
                        </a>
                    </div>
                    <div class="content_list5">
                        <a href="<c:url value='/list/chart?title=age&val=20'/>">
                            <div class="age20"></div>
                            <div class="content_list_title">20대</div>
                        </a>
                    </div>
                    <div class="content_list5">
                        <a href="<c:url value='/list/chart?title=age&val=30'/>">
                            <div class="age30"></div>
                            <div class="content_list_title">30대</div>
                        </a>
                    </div>
                    <div class="content_list5">
                        <a href="<c:url value='/list/chart?title=age&val=40'/>">
                            <div class="age40"></div>
                            <div class="content_list_title">40대</div>
                        </a>
                    </div>
                    <div class="content_list5">
                        <a href="<c:url value='/list/chart?title=age&val=50'/>">
                            <div class="age50"></div>
                            <div class="content_list_title">50대 이상</div>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <jsp:include page="footer.jsp"/>
</div>
</body>
</html>