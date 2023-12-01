<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movie Like</title>
    <link rel="icon" href="./img/favicon.ico">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <link rel="stylesheet" href="<c:url value='/css/common.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/login_page.css'/>">
</head>
<body>
<div id="wrap">
    <div class="login_bg"></div>
    <main class="container">
        <div class="logo"><a href="<c:url value='/'/>"><img src="<c:url value='/img/logo.png'/>" alt="MovieLike"></a></div>
        <form action="<c:url value='/login/login'/>" method="post" onsubmit="return formCheck(this);" class="login_form">
            <div class="title">
                <span>로그인</span>
                <div id="msg">
                    <c:if test="${not empty error}">
                        <span id="errorMessage" style="display: none;">일치하는 회원정보가 없습니다. ${URLDecoder.decode(error)}</span>
                        <script>
                            // 새로 고침을 하지 않을 때만 메시지 표시
                            if (performance.navigation.type !== 1) {
                                $('#errorMessage').fadeIn('fast');
                                setTimeout(function () {
                                    $('#errorMessage').fadeOut('fast');
                                }, 5000);
                            }
                        </script>
                    </c:if>
                    <c:if test="${not empty msg}">
                        <span id="infoMessage">${URLDecoder.decode(msg)}</span>
                    </c:if>
                </div>
            </div>
            <hr>
            <div class="input_box">
                <input type="text" name="id" value="${cookie.liogdinc.value}" class="login_input_text" placeholder="아이디(이메일)을 입력하세요." autofocus autocomplete="username">
            </div>
            <div class="input_box">
                <input type="password" name="pw" value="" id="pwInput" class="login_input_text" placeholder="비밀번호를 입력하세요" autocomplete="current-password">
            </div>
            <div class="input_box id_chk_box">
                <label>
                    <input type="checkbox" class="input_checkbox" name="rememberId" ${empty cookie.liogdinc.value?"":"checked"}>
                    아이디 기억하기
                </label>
            </div>
            <div class="input_box"><input type="submit" class="login_input input_btn" value="로그인"></div>
            <div class="id_search_box">
                <div class="id_search"><a href="<c:url value='/show/findEmail'/>">아이디 찾기</a></div>
                <div class="h_line"></div>
                <div class="id_search"><a href="<c:url value='/show/findPassword'/>">비밀번호 찾기</a></div>
                <div class="h_line"></div>
                <div class="id_search"><a href="<c:url value='/signUp/add'/>">회원가입</a></div>
            </div>
        </form>
    </main>
</div>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        function formCheck(frm) {
            let msg = '';
            if (frm.id.value.length == 0) {
                setMessage('아이디(이메일)을 입력하세요.', frm.id);
                return false;
            }
            if (frm.pw.value.length == 0) {
                setMessage('비밀번호를 입력하세요.', frm.pw);
                return false;
            }
            return true;
        }

        function setMessage(msg, element) {
            let msgElement = document.getElementById("msg");
            msgElement.innerHTML = `<span id="infoMessage">${msg}</span>`;
            if (element) {
                element.select();
            }
        }
    });
</script>
</body>
</html>
