$(document).ready(function(){
    var c_path = (location.pathname).split("/")[1];
    var nowPage = 0;
    var pageSize = 20;
// 위 키워드 선택 시 해당 키워드에 색 칠하기
    $(".m_tdItem, .m_tagItem").click(function (){
        $(".m_mvListBox").html("");
        $(".m_moreBox, .select_r").css({
            "display": "none"
        });
        let checkId = $(this).parent().prop("for"); // 체크박스 ID
        if(!$(`#${checkId}`).is(":checked") && $(`#${checkId}`).data("type") == "radio"){
            let checkName = $(`#${checkId}`).prop("name");
            let radio = $(`input[name = "${checkName}"]`);
            for(let i = 0; i < radio.length; i++){
                radio.eq(i).prop("checked", false);
                $(`label[for="${checkId}"]`).parent().children().eq(i).children(".m_tdItem").prop("class", "m_tdItem");
            }
        }
        $(`label[for="${checkId}"]`).children(".m_tdItem").toggleClass('m_tdItem_check');
    });

// 영화 리스트 불러오기
    $("input[type='checkbox']").change(function(){
        nowPage = 0;
        console.log("누름");
        showMovieList(0);
    });

// 정렬방법 다르게 선택 시 영화 리스트 다시 불러오기
    $(".select_r").change(function(){
        nowPage = 0;
        let sort = $('.select_r > option:checked').val() == "latest" ? 0 : 1;
        console.log(sort)
        $(".m_mvListBox").html("");
        $(".m_moreBox").css({
            "display": "none"
        });
        showMovieList(sort);
    });

    function showMovieList(sort){
        let genr=[];
        let country=[];
        let ott=[];
        let review= 0;
        let score= 0.0;
        let tag = $(".m_tagList .m_tagItem");
        let j = tag.length; //val()
        for (let i = 0; i < j; i++){
            if(tag.eq(i).css("display") == "inline-block"){
                tag.eq(i).data("genr") == undefined ? "" : genr.push(tag.eq(i).data("genr"));
                tag.eq(i).data("country") == undefined ? "" : country.push(tag.eq(i).data("country"));
                tag.eq(i).data("ott") == undefined ? "" : ott.push({"ottId" : parseInt(tag.eq(i).data("ott"))});
                review = tag.eq(i).data("review") == undefined ? 0 : parseInt(tag.eq(i).data("review"));
                score = tag.eq(i).data("score") == undefined ? 0 : parseInt(tag.eq(i).data("score"));
            }
        }
        if(genr == "" && country == "" && ott == "" && review == 0 && score == 0){
            return mvBox_null("키워드를 골라 원하는 영화를 찾아보세요");
        }
        $(".m_table, .m_tagBox").css({
            cursor: "wait"
        });
        $(".m_tagItem").parent().css({
            cursor: "wait"
        });
        $(".m_tdItem, .m_tagItem").css({
            cursor: "wait",
            pointerEvents: "none"
        });
        $("input[type='checkbox']").attr("disabled", true);
        let keyword = {genreList: genr, countryNameList: country, ottList: ott, movScore: score, movScoreCnt: review, nowPage: nowPage, pageSize: pageSize, sort: sort};
        $.ajax({
            type:'POST',       // 요청 메서드
            url: '/' + c_path + '/findKeyword',  // 요청 URI
            headers : { "content-type": "application/json"}, // 요청 헤더
            dataType : 'text', // 전송받을 데이터의 타입
            data : JSON.stringify(keyword),  // 서버로 전송할 데이터. stringify()로 직렬화 필요.
            success : function(result){
                //console.log("received="+result);       // result는 서버가 전송한 데이터
                $(".m_mvListBox").append(toHtml(result));
                showPage();
                $(".m_table, .m_tagBox").css({
                    cursor: "auto"
                });
                $(".m_tagItem").parent().css({
                    cursor: "pointer"
                });
                $(".m_tdItem, .m_tagItem").css({
                    cursor: "pointer",
                    pointerEvents: "auto"
                });
                $("input[type='checkbox']").removeAttr("disabled");
            },
            error : function(){
                mvBox_null("해당 키워드에 맞는 영화가 없습니다");
                $(".m_table, .m_tagBox").css({
                    cursor: "auto"
                });
                $(".m_tagItem").parent().css({
                    cursor: "pointer"
                });
                $(".m_tdItem, .m_tagItem").css({
                    cursor: "pointer",
                    pointerEvents: "auto"
                });
                $("input[type='checkbox']").removeAttr("disabled");
            }
        }); // $.ajax()
    }

    function mvBox_null(nodata){
        let txt = `<div class="nodata_txt">${nodata}</div>`
        $(".m_mvListBox").html(txt);
        $(".m_moreBox, .select_r").css({
            "display": "none"
        });
    }
    let toHtml = function(movieList) {
        let keywordList = "";
        movieList = JSON.parse(movieList);
        nowPage += movieList.length;

        movieList.forEach(function(movie) {
            let dt = new Date(movie.movDate);
            let year = dt.getFullYear();
            let month = dt.getMonth()+1 < 10 ? "0" + (dt.getMonth()+1) : dt.getMonth()+1;
            let date = dt.getDate() < 10 ? "0" + dt.getDate() : dt.getDate();
            let ottList = "";
            movie.ottList.forEach(function (ott, i){
                ottList += `<span class="m_mvOtt"><img src= "../img/ott/${ott.ottId}.png" alt="${ott.ottName}">${ott.ottName}</span>`;
            });

            let dirName = "감독 : ";
            movie.actorList.forEach(function (dir, i){
                dirName += dir.perName + ", ";
            });
            if (dirName != ""){dirName = dirName.slice(0, -2)}

            let cName = "";
            movie.countryNameList.forEach(function (country, i){
                cName += country + ", ";
            });
            if (cName != ""){cName = cName.slice(0, -2)}

            let genrName = "";
            movie.genreList.forEach(function (genre, i){
                genrName += genre + ", ";
            });
            if (genrName != ""){genrName = genrName.slice(0, -2)}

            keywordList += `<div class="m_mvList" data-movId=${movie.movId}>
                                <div class="m_mvPoster"><img src="https://image.tmdb.org/t/p/w500/${movie.movPoster}" alt="${movie.movName}"></div>
                                <div class="m_mvDesc">
                                    <div class="m_mvTitle">${movie.movName}</div>
                                    <div class="m_mvTitleEng">${movie.movNameEng}</div>
                                    <div class="m_mvDate">${year}-${month}-${date}</div>
                                    <div class="m_mvDescBox">
                                        <span class="m_mvDir">${dirName}</span><span class="m_mvCountry">${cName}</span>
                                    </div>
                                    <div class="m_mvDescBox">
                                        <span class="m_mvGen">${genrName}</span><span class="m_mvTime">${movie.movTime}분</span>
                                    </div>
                                    <div class="m_mvOttBox">`
                                        + ottList +
                                    `</div>
                                    <div class="avg_box">
                                        <div class="star_icon"><img src= "../img/star.png" alt="★"></div>
                                        <div class="movie_avg">${(movie.movScore).toFixed(1)}</div>
                                        <div class="movie_avg_cnt">( ${(movie.movScoreCnt).toLocaleString("ko")} )</div>
                                    </div>
                                </div>
                            </div>`;
        });
        return keywordList;
    };

// 페이징 작업
    function showPage(){
        $(".select_r").css({
            "display": "block"
        });
        if(nowPage % pageSize == 0) {
            $(".m_moreBox").css({
                "display": "block"
            });
        }else{
            $(".m_moreBox").css({
                "display": "none"
            });
        }
    }
    $(".m_moreBox").click(function (){
        let sort = $('.select_r > option:checked').val() == "latest" ? 0 : 1;
        console.log(sort)
        showMovieList(sort);
    });

// 영화 선택 시 상세 페이지로 가기
    $(".m_mvListBox").on('click', '.m_mvList', function(){
        let movId = $(this).data("movid");
        location.href = "../movie/detail?movId="+movId;
    });

    // 선택한 태그 체크해제
    $(".chk_delete_btn").click(function(){
        $(":checkbox").prop("checked",false);
        $(".m_tdItem").removeClass('m_tdItem_check');
        mvBox_null("키워드를 골라 원하는 영화를 찾아보세요");
    });
});