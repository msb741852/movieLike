var c_path = (location.pathname).split("/")[1];
function genreClick(id, name) {
    location.href = "./list/chart?title=genr&val=" + id + "&valName=" + name
}
function moveList(type,count){
    let msg =""
    if(type=="myview"){
        msg="봤어요";
    }else{
        msg="찜";
    }

    if(count==0){
        Swal.fire('알림', ' 선택영화가 없습니다.', 'warning');
        return
    }
    location.href =  "./list/chart?title=" + type;

}


$('.btn_myreview a').click(function() {
    event.preventDefault();
    let href = $(this).attr('href')
    $('html, body').animate({
        scrollTop: $(href).offset().top
    }, 1000)
})

// 비밀번호 확인하고 회원정보 폼 뜨기
function updateCheck(str) {
    (async () => {
        const { value: user_password } = await Swal.fire({
            title: '비밀번호를 입력해주세요',
            text: str,
            input: 'password',
            confirmButtonColor: "#a785efb8"
        });
        if (user_password == ""){
            return updateCheck("");
        }
        if (user_password == undefined){
            return;
        }
        $.ajax({
            type:'POST',
            url: '/' + c_path + '/myPage/modifyInfo',
            headers: {"content-type": "application/json"},
            success : function(data) {
                if(data.user.userPw == user_password) {
                    $("#popup").css({
                        visibility : "visible",
                        opacity : "1",
                        zIndex : "9"
                    });
                    $("#popup #email").prop("value", data.user.userEmail);
                    $("#popup #password").prop("value", "");
                    $("#popup #password_chk").prop("value", "");
                    $("#popup #name").prop("value", data.user.userName);
                    let dt = new Date(data.user.userBirth);
                    let year = dt.getFullYear();
                    let month = dt.getMonth()+1 < 10 ? "0" + (dt.getMonth()+1) : dt.getMonth()+1;
                    let date = dt.getDate() < 10 ? "0" + dt.getDate() : dt.getDate();
                    $("#popup #birth_year").html(`<option value="${year}" selected disabled>${year}</option>`);
                    $("#popup #birth_month").html(`<option value="${month}" selected disabled>${month}</option>`);
                    $("#popup #birth_date").html(`<option value="${date}" selected disabled>${date}</option>`);
                    $("#popup .birthday").prop('disabled',true);
                    let phone = (data.user.userPhone).split("-");
                    $("#popup #hp1").prop("value", phone[0]);
                    $("#popup #hp2").prop("value", phone[1]);
                    $("#popup #hp3").prop("value", phone[2]);
                    $("#popup #nickname").prop("value", data.user.userNickname);
                    (data.userGenre).forEach(function (genre, index){
                        for (let i = 0; i < $(".genre_checkbox").length; i++){
                            if($(".genre_checkbox").eq(i).data("genr") == genre){
                                $(".genre_checkbox").eq(i).prop("checked", true);
                                break;
                            }
                        }
                    });
                } else {
                    return updateCheck("비밀번호가 일치하지 않습니다.");
                }
            },
            error : function(e) {
                Swal.fire({
                    title: "개인정보 수정 ERROR. \n 관리자에게 전달해주세요.",
                });
            }
        });
    })()
}

function closePopup() {
  var popup = document.getElementById("popup");
  popup.style.visibility = "hidden";
  popup.style.opacity = "0";
}

// esc눌렀을 때 팝업 닫기
$(document).keydown(function(event) {
    if ( event.keyCode == 27 || event.which == 27 ) {
        closePopup();
        location.replace(location.pathname);
    }
});
// $(document).mouseup(function (e){
//   var Popup = $(".popup");
//   if(Popup.has(e.target).length === 0){
//     closePopup();
//   }
// });

function checkIdModify(){
    let email = $('#email').val();
    if (!expEmailText.test(email)) {
        Swal.fire('알림', '이메일 형식으로 입력해주세요.', 'warning').then(() => {
            $('#email').focus();
        });
    }
}
function checkphModify(){
    let hp2 = $('#hp2').val().trim();
    let hp3 = $('#hp3').val().trim();

    if((hp2.length > 0 && hp3.length > 0) && (hp2.length < 4 || hp3.length < 4) ) {
        Swal.fire('알림', '010-xxxx-xxxx 형식으로 입력해주세요.', 'warning').then(() => {
            $('#hp2').focus();
        });
    }
}
function checkNickModify(){
    if (!expNameText.test($('#nickname').val())) {
        Swal.fire('알림', '닉네임이 올바르지 않습니다.\n(한글 초성 및 모음 제외한 2자 이상 16자 이하, 영어 또는 숫자 또는 한글로 구성으로만 가능합니다)', 'warning').then(() => {
            $('#nickname').focus();
        });
    }
}

// 회원정보 수정
function updatePopup() {
    if ($("#password").val() != $("#password_chk").val()){
        $("input[name=userPw]").css("background-color", "#FFCECE");
        $(".ok-text").css("color", "rgb(255, 120, 203)");
        $(".ok-text").text("비밀번호를 확인해주세요.");
        return;
    }else if($("#name").val().trim() == ""){
        Swal.fire('알림', '이름을 입력해주세요 (한글만 가능)', 'warning').then(() => {
            $('#name').focus();
        });
    }else if($("#hp2").val().length < 4 || $("#hp3").val().length < 4){
        Swal.fire('알림', '010-xxxx-xxxx 형식으로 입력해주세요.', 'warning');
    }else if(sendit()) {
        let userPhone = $('#hp1').val() + "-" + $('#hp2').val() + "-" + $('#hp3').val()
        console.log("userPhone : " + userPhone);
        let user = {
            userId: sessionId,
            userEmail: $("#email").val(),
            userPw: $('#password').val(),
            userName: $('#name').val(),
            userNickname: $('#nickname').val(),
            userPhone: userPhone
        };
        let userGenre = [];
        for (let i = 0; i < $(".genre_checkbox").length; i++) {
            if ($(".genre_checkbox").eq(i).prop("checked") == true) {
                userGenre.push({genrId: $(".genre_checkbox").eq(i).data("genr"), userId: sessionId});
            }
        }
        console.log(userGenre);
        $.ajax({
            type: 'POST',
            url: '/' + c_path + '/myPage/modifyUser',
            headers: {"content-type": "application/json"},
            dataType: 'text',
            data: JSON.stringify({user: user, userGenre: userGenre}),
            success: function (data) {
                Swal.fire({
                    position: "center",
                    zIndex: 99999,
                    icon: "success",
                    title: "회원정보가 수정되었습니다.",
                    showConfirmButton: false,
                    timer: 1500
                }).then(() => {
                    location.replace(location.pathname);
                });
            },
            error: function (e) {
                if (e.responseText != ""){
                    let error = (e.responseText).split(",");
                    console.log(error);
                    console.log(error.length);
                    for(let i = 0; i < error.length-1; i++){
                        console.log(error[i]);
                        if (error[i] == "id"){
                            handleDuplicateCheck(1, '.id_ok', '.id_already', '#email');
                        }else if(error[i] == "nick"){
                            handleDuplicateCheck(1, '.nick_ok', '.nick_already', '#nickname');
                        }else if(error[i] == "phone"){
                            handleDuplicateCheck(1, '.ph_ok', '.ph_already', '.phone_input');
                        }else{
                            Swal.fire({
                                title: "개인정보 수정 ERROR. \n 관리자에게 전달해주세요.",
                            }).then(() => {
                                location.replace(location.pathname);
                            });
                        }
                    }
                }else {
                    Swal.fire({
                        title: "개인정보 수정 ERROR. \n 관리자에게 전달해주세요.",
                    }).then(() => {
                        location.replace(location.pathname);
                    });
                }
            }
        });
    }
}

function unregister() {
    (async () => {
        const { value: user_password } = await Swal.fire({
            title: '비밀번호를 입력해주세요',
            input: 'password',
            confirmButtonColor: "#a785efb8"
        });
        if (user_password == undefined){
            return;
        }
        $.ajax({
            type:'POST',
            url: '/' + c_path + '/myPage/selectUserId',
            headers: {"content-type": "application/json"},
            success : function(data) {
                if(data == user_password) {
                    Swal.fire({
                        title: "정말 탈퇴하시겠습니까?",
                        text: "탈퇴시 모든 개인정보가 삭제됩니다.",
                        icon: "warning",
                        showCancelButton: true,
                        confirmButtonColor: "#AD8B73",
                        cancelButtonColor: "#BEBCBA",
                        confirmButtonText: "네",
                        cancelButtonText: "아니요"
                    }).then((result) => {
                        if (result.isConfirmed) {
                            $.ajax({
                                type:'POST',
                                url: '/' + c_path + '/myPage/delete/user',
                                headers: {"content-type": "application/json"},
                                success : function(data) {
                                    if(data != null) {
                                        Swal.fire({
                                            title: "회원 탈퇴 성공",
                                        }).then(() => {
                                            location.replace(location.pathname);
                                        });
                                    }
                                },
                                error : function(e) {
                                    Swal.fire({
                                        title: "회원 탈퇴 실패. \n 관리자에게 전달해주세요.",
                                    });
                                }})
                        }
                    });
                } else {
                    Swal.fire({
                        title: "비밀번호가 일치하지 않습니다.",
                    });
                }
            },
            error : function(e) {
                Swal.fire({
                    title: "회원 탈퇴 ERROR. \n 관리자에게 전달해주세요.",
                });
            }})
    })()

}

// 차트
function chartInit(data) {
    const ctx = document.getElementById('myChart');
    const chart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['1', '2', '3', '4', '5'],
            datasets: [{
                data: data,
                backgroundColor: [
                    'rgba(255, 99, 132, 0.5)',
                    'rgba(54, 162, 235, 0.5)',
                    'rgba(255, 206, 86, 0.5)',
                    'rgba(75, 192, 192, 0.5)',
                    'rgba(153, 102, 255, 0.5)'
                ],
                borderWidth: 2,
                borderColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)',
                    'rgba(75, 192, 192, 1)',
                    'rgba(153, 102, 255, 1)'
                ],
                fill: false
            }]
        },
        options: {
            onClick: (e) => {
                // label값을 가져와서 링크이동시켜준다.
                const canvasPosition = Chart.helpers.getRelativePosition(e, chart);
                const dataX = chart.scales.x.getValueForPixel(canvasPosition.x);
                location.href = "./list/chart?title=myScore&val=" + (dataX + 1)
            },
            maxBarThickness: 50,
            scales: { // 눈금선 없애기
                x: {
                    grid: {
                        display: false
                    },
                    ticks: {
                        color: "rgba(255, 255, 255, 1)", // 글자 색
                        font: {
                            size: 20
                        }
                    },
                    border: {
                        color: "rgba(255, 255, 255, 1)" // 축 색
                    },
                    barPercentage: 1,
                    categoryPercentage: 1,
                    barThickness : 45
                },
                y: {
                    grid: {
                        display: false
                    },
                    ticks: {
                        color: "rgba(255, 255, 255, 1)",
                        font: {
                            size: 0
                        }
                    },
                    border: {
                        display: false
                    }
                },
            },

            scaleShowLabels : false,
            plugins: {
                legend: {
                    display: false,
                }
            }
        }
    });
}


let updateButtons = document.querySelectorAll('.review_update');
updateButtons.forEach(function(button) {
    button.addEventListener('click', function(event) {
        let parentElement = event.target.closest('.review_list_box');

        let reviewContentElement = parentElement.querySelector('.review_content');

        reviewContentElement.readOnly = false;
        reviewContentElement.style.color = "black";
        reviewContentElement.style.padding = "10px";
        reviewContentElement.style.background = "white";
    });
});

var txtArea = $(".review_content");
    if (txtArea) {
        txtArea.each(function(){
            $(this).height(this.scrollHeight);
        });
    }

const DEFAULT_HEIGHT = 30; // textarea 기본 height
const $textarea = document.querySelector('.review_content');

$textarea.oninput = (event) => {
  const $target = event.target;

  $target.style.height = 0;
  $target.style.height = DEFAULT_HEIGHT + $target.scrollHeight + 'px';
};

var inputText = "";
$(document).on('click', '.review_update', function () {
    $(this).text("수정");
    $(this).next().text("취소");
    $(this).addClass("modify_btn");
    $(this).next().addClass("cancel_btn");
    let inputBox = $(this).parent().parent().find("textarea")
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
    let inputBox = $(this).parent().parent().find("textarea");
    let rvId = $(this).parent().parent().find("#reviewId");

    $.ajax({
        type: 'POST',
        url: '/' + c_path + '/review/modify',
        headers: {"content-type" : "application/json"},
        dataType:'text',
        data: JSON.stringify({rvId: rvId.val(), rvContent: inputBox.val()}),
        success: function (result) {
            location.reload();
        }
    })
});

$(document).on('click', '.review_delete', function () {
    if($(this).text() == "삭제") {
        let rvId = $(this).parent().parent().find("#reviewId").val();
        reviewDelete(rvId);
    } else {
        let inputBox = $(this).parent().parent().find("textarea");
        $(this).text("삭제");
        $(this).prev().removeClass("modify_btn");
        $(this).removeClass("cancel_btn");
        inputBox.prop("readOnly", true);
        inputBox.prop("style", "");
        inputBox.prop("value",inputText);
        inputBox.css("height", 0);
        inputBox.css("height", DEFAULT_HEIGHT + inputBox[0].scrollHeight + 'px');
    }
})

function reviewDelete(rvId) {
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
            url: '/' + c_path + '/review/delete',
            headers: {"content-type": "application/json"},
            data: JSON.stringify(rvId),
            success : function(data) {
                location.reload();
            },
            error : function(e) {
                console.log(e);
            }
        });
    })}
