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
    <link rel="stylesheet" href="<c:url value='/css/find_id.css'/>">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
</head>
<body>
    <div id="wrap">
        <div class="login_bg"></div>
        <main class="container">
            <div class="logo"><a href="<c:url value='/'/>"><img src="<c:url value='/img/logo.png'/>" alt="movielike"></a></div>
            <form action="" class="search_form">
                <div class="title">아이디 찾기</div>
                <table>
                    <tr>
                        <th class="th1">이름</th>
                        <th><input type="text" name="name" class="login_input" id="name_input"></th>
                    </tr>
                    <tr>
                        <th class="th1">휴대폰</th>
                        <th>
                            <input type="text" name="phone1" class="phone_input" maxlength="3"  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
                            <input type="text" name="phone2" class="phone_input" maxlength="4" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
                            <input type="text" name="phone3" class="phone_input" maxlength="4" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
                        </th>
                    </tr>
                    <tr>
                        <th class="th1">생년월일</th>
                        <th>
                            <select class="birthday" name="birth_year" id="birth_year">
                                <option selected>연도</option>
                            </select>
                            <select class="birthday" name="birth_month" id="birth_month">
                                <option value="월" selected disabled>월</option>
                            </select>
                            <select class="birthday" name="birth_date" id="birth_date">
                                <option value="일" selected>일</option>
                            </select>
                        </th>
                    </tr>
                    <tr>
                        <th colspan="2"><div class="search_btn" id="find_id">확인</div></th>
                    </tr>
                </table>
            </form>
        </main>
    </div>
    <script>
        $(document).on('click', '#find_id', function () {
        let userName = $('input[name=name]').val();
        let userPhone = $('input[name=phone1]').val() + "-" + $('input[name=phone2]').val() + "-" + $('input[name=phone3]').val();
        let birth_year = $('#birth_year').val();
        let birth_month = $('#birth_month').val();
        let birth_date = $('#birth_date').val();
        let chk = true;

        // 이름 인풋창이 비어있을 때
        if($('#name_input').val().trim() == null || $('#name_input').val().trim() == "") {
            Swal.fire({
                text: "이름을 입력해주세요!",
            }).then(() => {
                $("#name_input").focus();
            });
            chk = false;
        } else if (($('input[name=phone1]').val().trim() == null || $('input[name=phone1]').val().trim() == "") ||
            ($('input[name=phone2]').val().trim() == null || $('input[name=phone2]').val().trim() == "") ||
            ($('input[name=phone3]').val().trim() == null || $('input[name=phone3]').val().trim() == "")) {
            Swal.fire({
                text: "핸드폰 번호를 입력해주세요!",
            }).then(() => {
                $("input[name=phone1]").focus();
            });
            chk = false;
        } else if ((birth_year == "연도") || (birth_month == "월") || (birth_date == "일")) {
            Swal.fire({
                text: "생년월일을 선택해주세요!"
            });
            chk = false;
        } else {
            chk = true;
        }



        if(chk){
            $.ajax({
                type: 'POST',
                url: '/app/find/email',
                headers: {"content-type": "application/json"},
                dataType: 'text',
                data: JSON.stringify({
                    userName: userName, userPhone: userPhone,
                    birth_year: birth_year, birth_month: birth_month, birth_date: birth_date
                }),
                success: function (result) {
                    let text = result == null || result == "" ? "등록된 회원정보가 없습니다." : "회원님의 이메일은 '" + result + "'입니다.";
                    Swal.fire({
                        text: text
                    });
                },
                error: function () {
                    alert("실패");
                }
            })
        }
    });
    </script>
    <script src="<c:url value='/js/join.js'/>"></script>
</body>
</html>