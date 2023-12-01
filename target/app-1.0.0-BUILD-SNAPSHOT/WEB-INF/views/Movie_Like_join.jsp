<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movie Like</title>
    <link rel="icon" href="<c:url value='/img/favicon.ico'/>">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <link rel="stylesheet" href="<c:url value='/css/common.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/join_page.css'/>">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
</head>
<body>
<div id="wrap">
    <div class="login_bg"></div>
    <main class="container">
        <div class="logo"><a href="<c:url value='/'/>"><img src="<c:url value='/img/logo.png'/>" alt="MovieLike"></a></div>
        <form action="<c:url value='/signUp/save'/>" class="join_form" name="form1" id=form1" method="post" onsubmit="return sendit()">
            <div class="title">회원가입</div>
            <table>
                <tr>
                    <th class="th1">이메일</th>
                    <th>
                        <span id="id_ok" class="id_ok confirm_sub">사용 가능한 이메일입니다.</span>
                        <span id="id_already" class="id_already confirm_sub">이미 사용중인 이메일입니다.</span>
                        <input type="email" class="login_input" id="email" name="userEmail" placeholder="이메일 형식으로 입력해주세요" onblur= "checkId()" minlength="10" maxlength="25" >
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
                        <input type="text" name="userPhone2" class="phone_input" id="hp2" minlength="4"   maxlength="4" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" placeholder="4자 이상"  onblur="checkph()">
                        <input type="text" name="userPhone3" class="phone_input" id="hp3" minlength="4"  maxlength="4" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" placeholder="4자 이상"  onblur="checkph()">
                    </th>
                </tr>
                <tr>
                    <th class="th1">닉네임</th>
                    <th> <p><span id="nick_ok" style="font-size:12px;" class="nick_ok confirm_sub">사용 가능한 닉네임입니다.</span><span id="nick_already" style="font-size:12px;" class="nick_already">이미 사용중인 닉네임입니다.</span>
                        <input type="text" name="userNickname" id="nickname" class="login_input" placeholder="한글 초성 및 모음 제외한 2자 이상 16자 이하," onblur="checkNick()"></th>
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
                    <th colspan="2"><input type="submit" class="login_btn"  value="회원가입" id= "joinSubmit" disabled></th>
                </tr>
            </table>
            <input style="display: none" name="genr_arr" />
        </form>
    </main>
</div>
<script src="<c:url value='/js/join.js'/>"></script>
</body>
</html>