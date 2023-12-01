$(document).ready(function() {
    var c_path = (location.pathname).split("/")[1];
    let nowPage = movieLength;
    let ajaxCheck = true;
// 들어온 위치에 따른 title설정.
    let select_r = `<select class="select_r">
                                <option value="latest" selected>최신순</option>
                                <option value="popularity">인기순</option>
                            </select>`;
    $(".title_box").html("");
    if (s_title == "search"){
        let searchBar = `<div class="search_bar">
                                    <input type="text" class="search" placeholder="영화 제목, 감독 배우를 검색해주세요" value="${s_val}">
                                    <div class="s_icon"><img src="../img/search.png" alt="search"></div>
                                </div>`;
        if(s_val == ""){
            $(searchBar).appendTo(".title_box");
            mvBox_null("검색어를 입력해 원하는 영화를 찾아보세요");
        } else if (nowPage == 0){
            $(searchBar).appendTo(".title_box");
            mvBox_null("해당 검색어에 맞는 영화가 없습니다");
        } else {
            $(searchBar + select_r).appendTo(".title_box");
        }
    }else{
        let title = "";
        if(s_title == "all"){ title = `영화 전체 보기`; }
        else if (s_title == "year"){ title = (s_val == "1989" ? "1990년대 이전" : (s_val + `년대`)) + " 영화 보기"; }
        else if (s_title == "age"){ title = s_val + `대` + (s_val == "50" ? " 이상" : "") + " 영화 보기"; }
        else if (s_title == "myView"){ title = `내가 본 영화`; }
        else if (s_title == "myLike"){ title = `내가 찜한 영화`; }
        else if (s_title == "myScore"){ title = `내가 ` + s_val + `점 준 영화`; }
        else if (s_title == "country"){ title = s_val + `영화 보기`; }
        else { title = s_valName  + ` 영화 보기`; }
        let group_title = `<div class="group_title">${title}</div>`;
        $(group_title + select_r).appendTo(".title_box");
    }

// 검색버튼 눌렀을 때, 엔터쳤을 때 리스트 페이지로 이동
    $(".search_bar").on('click', '.s_icon', function(){
        location.href = "/" + c_path + "/list/chart?title=search&val="+$(".search").val();
    });
    $(".search").keydown(function(){
        if(event.keyCode == 13){
            location.href = "/" + c_path + "/list/chart?title=search&val="+$(".search").val();
        }
    });

// 영화 누르면 상세페이지로 이동
    $(".content_box").on('click', '.content', function(){
        let movId = $(this).data("movid");
        location.href = "/" + c_path + "/movie/detail?movId="+movId;
    });

//무한 스크롤 영화 리스트 출력
    let scroll_chk = true;
    let pageSize = 20;
    let d_height = $(document).height();
    // $(window).scroll(function () {
    $(window).on('mousewheel DOMMouseScroll', function(){
        let s_bot = $(window).scrollTop() + $(window).height();
        if(scroll_chk && ajaxCheck && nowPage % pageSize == 0 && s_bot + 600 >= d_height && event.wheelDelta < 0){
            event.preventDefault();
            scroll_chk = false;

            let sort = $('.select_r > option:checked').val() == "latest" ? 0 : 1;
            showMovieList(sort);
        }
    });

// 정렬방법 다르게 선택 시 영화 리스트 다시 불러오기
    $(".select_r").change(function(){
        nowPage = 0;
        let sort = $('.select_r > option:checked').val() == "latest" ? 0 : 1;
        $(".content_box").html("");
        showMovieList(sort);
    });

// 영화 리스트 출력 메소드
    function showMovieList(sort){
        if(s_title == "search" && s_val == ""){
            $(".select_r").css({
                "display": "none"
            });
            return mvBox_null("검색어를 입력해 원하는 영화를 찾아보세요");
        }
        let keyword = {s_title: s_title, s_val: s_val, s_valName: s_valName, nowPage: nowPage, sort: sort};
        $.ajax({
            type:'POST',       // 요청 메서드
            url: '/' + c_path + '/list/chart',  // 요청 URI
            headers : { "content-type": "application/json"}, // 요청 헤더
            dataType : 'text', // 전송받을 데이터의 타입
            data : JSON.stringify(keyword),  // 서버로 전송할 데이터. stringify()로 직렬화 필요.
            success : function(result){
                //console.log("received="+result);       // result는 서버가 전송한 데이터
                $(".content_box").append(toHtml(result));
                $(".select_r").css({
                    "display": "block"
                });
                scroll_chk = true;
                d_height = $(document).height();
                ajaxCheck = true;
            },
            error : function(){
                if (nowPage == 0){
                    if (s_title == "search") { mvBox_null("해당 검색어에 맞는 영화가 없습니다"); }
                    else{ mvBox_null("해당 분류에 맞는 영화가 없습니다"); }
                    $(".select_r").css({
                        "display": "none"
                    });
                }
                scroll_chk = true;
                ajaxCheck = false;
            }
        }); // $.ajax()
    }
    function mvBox_null(nodata){
        let txt = `<div class="nodata_txt">${nodata}</div>`
        $(".content_box").html(txt);
    }

    let toHtml = function(movieList) {
        let keywordList = "";
        movieList = JSON.parse(movieList);
        nowPage += movieList.length;

        movieList.forEach(function(movie) {
            let dt = new Date(movie.movDate);
            let year = dt.getFullYear();

            keywordList += `<div class="content" data-movId="${movie.movId}">
                                <div class="poster"><img src="https://image.tmdb.org/t/p/w500/${movie.movPoster}" alt="${movie.movName}"></div>
                                <div class="movie_name">${movie.movName}</div>
                                    <div class="movie_year">${year}</div>
                                <div class="avg_box">
                                    <div class="star_icon"><img src="../img/star.png" alt="★"></div>
                                    <div class="movie_avg">${(movie.movScore).toFixed(1)}</div>
                                    <div class="movie_avg_cnt">( ${(movie.movScoreCnt).toLocaleString("ko")} )</div>
                                </div>
                            </div>`;
        });
        return keywordList;
    };
})