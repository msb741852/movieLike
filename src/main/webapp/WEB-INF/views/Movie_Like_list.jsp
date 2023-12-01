<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movie Like</title>
    <link rel="icon" href="<c:url value='/img/favicon.ico'/>">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <link rel="stylesheet" href="<c:url value='/css/common.css'/> ">
    <link rel="stylesheet" href="<c:url value='/css/list_page.css'/> ">
</head>
<body>
    <div id="wrap">
        <jsp:include page="header.jsp"/>
        <main class="container">
            <div class="title_box"></div>
            <div class="content_box">
                <c:choose>
                    <c:when test="${error == 'blank'}">
                        <div class="nodata_txt">검색어를 입력해 원하는 영화를 찾아보세요</div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="movie" items="${movieList}">
                            <div class="content" data-movId="${movie.movId}">
                                <div class="poster"><img src="<c:url value='https://image.tmdb.org/t/p/w500/${movie.movPoster}'/>" alt="${movie.movName}"></div>
                                <div class="movie_name">${movie.movName}</div>
                                <fmt:formatDate var="year" value="${movie.movDate}" pattern="yyyy"/>
                                <div class="movie_year">${year}</div>
                                <div class="avg_box">
                                    <div class="star_icon"><img src="<c:url value='/img/star.png'/>" alt="★"></div>
                                    <div class="movie_avg"><fmt:formatNumber value="${movie.movScore}" pattern="0.0"/></div>
                                    <div class="movie_avg_cnt">( <fmt:formatNumber value="${movie.movScoreCnt}" pattern="#,###"/> )</div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>
        <jsp:include page="footer.jsp"/>
    </div>
    <script>
        var s_title = "${param.title}";
        var s_val = "${param.val}";
        var s_valName = "${param.valName}";
        var movieLength = ${fn:length(movieList)};
        <%--var error = "#{error}";--%>
    </script>
    <script src="<c:url value='/js/list_item.js'/>"></script>
</body>
</html>