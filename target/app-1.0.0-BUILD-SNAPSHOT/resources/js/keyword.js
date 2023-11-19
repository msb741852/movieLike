$(document).ready(function(){
    var nowPage = 0;
    var endPage = 0;
    var pageSize = 20;
    $(".m_tdItem, .m_tagItem").click(function (){
        $(".m_mvBox").html("");
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

    $("input[type='checkbox']").change(function(){
        if ($(".m_tagList .m_tagItem"))
        showMovieList();
    });

    function showMovieList(){
        let genr=[];
        let ott=[];
        let review= 0;
        let score= 0.0;
        let tag = $(".m_tagList .m_tagItem");
        let j = tag.length; //val()
        for (let i = 0; i < j; i++){
            if(tag.eq(i).css("display") == "inline-block"){
                // genr += tag.eq(i).data("genr") == undefined ? "" : tag.eq(i).data("genr") + "|";
                tag.eq(i).data("genr") == undefined ? "" : genr.push(tag.eq(i).data("genr"));
                // ott += tag.eq(i).data("ott") == undefined ? "" : tag.eq(i).data("ott") + "|";
                tag.eq(i).data("ott") == undefined ? "" : ott.push({"ottName" : tag.eq(i).data("ott")});
                review = tag.eq(i).data("review") == undefined ? 0 : parseInt(tag.eq(i).data("review"));
                score = tag.eq(i).data("score") == undefined ? 0 : parseInt(tag.eq(i).data("score"));
            }
        }
        // console.log("genr : " + genr);
        // console.log("ott : " + ott);
        // console.log("review : " + review);
        // console.log("score : " + score);
        if(genr == "" && ott == "" && review == 0 && score == 0){
            return mvBox_null("키워드를 골라 원하는 영화를 찾아보세요");
        }
        let keyword = {movScore: score, movScoreCnt: review, ottList: ott, genreList: genr, nowPage: nowPage, pageSize: pageSize};
        //httpRequest.abort();
        $.ajax({
            type:'POST',       // 요청 메서드
            url: '/app/findKeyword',  // 요청 URI
            headers : { "content-type": "application/json"}, // 요청 헤더
            dataType : 'text', // 전송받을 데이터의 타입
            data : JSON.stringify(keyword),  // 서버로 전송할 데이터. stringify()로 직렬화 필요.
            success : function(result){
                console.log("received="+result);       // result는 서버가 전송한 데이터
                $(".m_mvBox").append(toHtml(result));
                showPage();
            },
            error : function(){
                mvBox_null("해당 키워드에 맞는 영화가 없습니다");
            }
        }); // $.ajax()
    }

    var c_path = (location.pathname).split("/")[1];
    console.log("c_path : " + c_path);

    function mvBox_null(nodata){
        let txt = `<div class="nodata_txt">${nodata}</div>`
        $(".m_mvBox").html(txt);
        $(".m_moreBox").html("");
    }
    let toHtml = function(movieList) {
        let keywordList = "";
        movieList = JSON.parse(movieList);
        endPage += movieList.length;

        movieList.forEach(function(movie) {
            let dt = new Date(movie.movDate);
            let year = dt.getFullYear();
            let month = dt.getMonth()+1 < 10 ? "0" + (dt.getMonth()+1) : dt.getMonth()+1;
            let date = dt.getDate() < 10 ? "0" + dt.getDate() : dt.getDate();
            // let ottId = movie.ottId;
            // let ottName = movie.ottName;
            // if(movie.ottList.length > 0) {
            //     console.log("ott 값 있음");
            //     ottList = "";
            //     let ottIdList = ottId.split(",");
            //     let ottNameList = ottName.split(",");
            //     for (let j = 0; j < ottIdList.length; j++) {
            //         ottList += `<div class="m_mvOttBox">
            //                     <span class="m_mvOtt"><img src= "../img/ott/${ottIdList[j]}.png" alt="${ottNameList[j]}">${ottNameList[j]}</span>
            //                 </div>`;
            //     }
            // }
            let ottList = "";
            movie.ottList.forEach(function (ott, i){
                ottList += `<div class="m_mvOttBox">
                                <span class="m_mvOtt"><img src= "../img/ott/${ott.ottId}.png" alt="${ott.ottName}">${ott.ottName}</span>
                            </div>`;
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
                                <div class="m_mvPoster"><img src="https://image.tmdb.org/t/p/w500/${movie.movPoster}" alt=""></div>
                                <div class="m_mvDesc">
                                    <div class="m_mvTitle">${movie.movName}</div>
                                    <div class="m_mvTitleEng">${movie.movNameEng}</div>
    <!--                                    <div class="m_mvDate">${movie.movDate}</div>-->
                                    <div class="m_mvDate">${year}-${month}-${date}</div>
                                    <div class="m_mvDescBox">
                                        <span class="m_mvDir">${dirName}</span><span class="m_mvCountry">${cName}</span>
                                    </div>
                                    <div class="m_mvDescBox">
                                        <span class="m_mvGen">${genrName}</span><span class="m_mvTime">${movie.movTime}분</span>
                                    </div>`
                                    + ottList +
                                    `<div class="avg_box">
                                        <div class="star_icon"><img src= "../img/star.png" alt="★"></div>
                                        <div class="movie_avg">${movie.movScore}</div>
                                        <div class="movie_avg_cnt">( ${(movie.movScoreCnt).toLocaleString("ko")} )</div>
                                    </div>
                                </div>
                            </div>`;
        });
        return keywordList;
    };

    // 페이징 작업
    function showPage(){
        console.log("endPage : " + endPage);
        console.log("pageSize : " + pageSize);
        console.log("endPage % pageSize : " + endPage % pageSize);
        if(endPage % pageSize == 0) {
            $(".m_moreBox").html("<span>더보기▽</span>");
        }else{
            $(".m_moreBox").html("");
        }
        nowPage = endPage;
        console.log("nowPage : " + nowPage);
    }
    $(".m_moreBox").click(function (){
        showMovieList();
    });

});