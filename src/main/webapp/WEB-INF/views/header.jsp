<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session = "false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="sessionId" value="${ pageContext.request.getSession(false).getAttribute('liogdin')!=null? pageContext.request.getSession(false).getAttribute('liogdin'):null}" />
<c:set var="sessionNick" value="${ pageContext.request.getSession(false).getAttribute('liogdinn')!=null? pageContext.request.getSession(false).getAttribute('liogdinn'):null}" />

<c:set var="logIO_link" value="${ sessionId==null?'/login/login':'/login/logout'}" />
<c:set var="logIO_txt" value="${ sessionId==null?'로그인':'로그아웃'}" />

<c:set var="signIO_link" value="${ sessionId==null?'/signUp/add':'/myPage'}" />
<c:set var="signIO_txt" value="${ sessionId==null?'회원가입':'마이페이지'}" />
<head>
    <meta charset="UTF-8">
    <title>Movie Like</title>
    <link rel="stylesheet" href="<c:url value='/css/common.css'/> ">
    <link rel="stylesheet" href="<c:url value='/css/header.css'/> ">
</head>
<header class="header">
    <div class="main_logo"><a href="<c:url value='/'/>"><img src="<c:url value='/img/logo.png'/>" alt="MovieLike"></a></div>
    <div class="h_left">
        <div><a href="<c:url value='/list/chart?title=all'/>">영화 전체보기</a></div>
        <div><a href="<c:url value='/find/chart'/>">차트</a></div>
        <div><a href="<c:url value='/find/keyword'/>">키워드 찾기</a></div>
    </div>
    <div class="h_right">
        <div class="login"><a href="<c:url value='${logIO_link}'/>">${logIO_txt}</a></div>
        <div class="line"></div>
        <div class="join"><a href="<c:url value='${signIO_link}'/>">${signIO_txt}</a></div>
    </div>
</header>
