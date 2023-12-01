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
            <div class="logo"><a href="#"><img src="<c:url value='/img/logo.png'/>" alt="movielike"></a></div>
            <form action="" class="search_form">
                <div class="title">비밀번호 찾기</div>
                <table>
                    <tr>
                        <th class="th1">이메일</th>
                        <th><input type="text" name="email" class="login_input" id="email_input"></th>
                    </tr>
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
                        <th colspan="2"><div class="search_btn" id="find_password">확인</div></th>
                    </tr>
                </table>
            </form>
            <div class="popup">
                <div class="popup_content">
                  <div class="title">새 비밀번호</div>
                        <input type="password" name="password" id="password" class="password_input" minlength="6" placeholder="소문자,대문자,특수문자,숫자 1개씩 꼭 입력 및 8자이상">
                        <input type="password" name="password_chk" id="password_chk" class="password_input" placeholder="비밀번호 확인">
                        <input type="button" class="update_btn" id="change_password_btn" value="수정">
                </div>
            </div>
        </main>
    </div>
    <script>
        function updatePw(userEmail) {
            let password = document.getElementById('password');
            let password_chk = document.getElementById('password_chk');
            const expPwText = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$/;
            if (password.value == '' || password.value == null || password_chk.value == '' || password_chk.value == null) {
                Swal.fire({
                    text: "비밀번호를 입력해주세요."
                });
                return false;
            } else if (password.value != password_chk.value) {
                Swal.fire({
                    text: "비밀번호를 확인해주세요."
                });
                return false;
            } else if (!expPwText.test(password.value)) {
                Swal.fire({
                    text: "비밀번호 형식확인  \n 소문자,대문자,특수문자,숫자 1개씩 꼭 입력 및 8자이상 입력해주세요"
                });
                return false;
            } else {
                $.ajax({
                    type: 'POST',
                    url: '/app/update/userPassword',
                    headers: {"content-type": "application/json"},
                    dataType: 'text',
                    data: JSON.stringify({userEmail: userEmail, userPw: $('#password').val()}),
                    success: function () {
                        Swal.fire({
                            text: "비밀번호를 변경하였습니다."
                        }).then(() => {
                            location.replace("<c:url value='/'/>");
                        })
                    },
                    error: function () {

                    }
                });
            }
        }

        $('.phone_input').on('keyup', function() {
            if(this.value.length == this.maxLength) {
                $(this).next('.phone_input').focus();
            }
        });
        $(document).on('click', '#find_password', function () {
            let userName = $('#name_input').val();
            let userPhone = $('input[name=phone1]').val() + "-" + $('input[name=phone2]').val() + "-" + $('input[name=phone3]').val();
            let userEmail = $('#email_input').val();
            let chk;
            // 이름 인풋창이 비어있을 때
            if($('#email_input').val().trim() == null || $('#email_input').val().trim() == "") {
                Swal.fire({
                    text: "이메일을 입력해주세요!",
                }).then(() => {
                    $("#email_input").focus();
                });
                chk = false;
            } else if ($('#name_input').val().trim() == null || $('#name_input').val().trim() == "") {
                Swal.fire({
                    text: "이름을 입력해주세요!",
                })
            } else if (($('input[name=phone1]').val().trim() == null || $('input[name=phone1]').val().trim() == "") ||
                ($('input[name=phone2]').val().trim() == null || $('input[name=phone2]').val().trim() == "") ||
                ($('input[name=phone3]').val().trim() == null || $('input[name=phone3]').val().trim() == "")) {
                Swal.fire({
                    text: "핸드폰 번호를 입력해주세요!",
                }).then(() => {
                    $("input[name=phone1]").focus();
                });
                chk = false;
            } else {
                chk = true;
            }
            if(chk){
                $.ajax({
                    type: 'POST',
                    url: '/app/find/password',
                    headers: {"content-type": "application/json"},
                    dataType: 'text',
                    data: JSON.stringify({
                        userName: userName, userPhone: userPhone, userEmail: userEmail
                    }),
                    success: function (result) {
                        if (result == null || result == "") {
                            Swal.fire({
                                text: "등록된 회원정보가 없습니다."
                            });
                        } else {
                            $('.popup').css("display", "block");
                            $(document).on('click', '#change_password_btn', function () {
                                updatePw(userEmail);
                            });
                        }
                    },
                    error: function () {
                        alert("실패");
                    }
                })
            }
        });

    </script>

</body>
</html>