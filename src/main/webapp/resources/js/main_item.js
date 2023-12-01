$(document).ready(function() {
    var c_path = (location.pathname).split("/")[1];

    // 베스트, 많이 보고 싶어하는 영화, 시리즈 출력
    function showMovieList(movieList, parentClass, viewSize, ranking){
        let i = 0;
        movieList.forEach(function(movie){
            let movie_item = "";
            if (viewSize == 10){ //랭킹
                movie_item = `<a href="/${c_path}/movie/detail?movId=${movie.movId}">
                                <img src="https://image.tmdb.org/t/p/w500/${movie.movPoster}" alt="${movie.movName}">
                            </a>`;
                movie_item += (ranking == "ranking" ? `<div class=\"ranking\">${i+1}</div>` : "");
            }else if(viewSize == 5){ //메인배너
                src=""
                movie_item = `  <a href="/${c_path}/movie/detail?movId=${movie.movId}"></a>
                                <iframe width="100%" height="100%"
                                    src="https://www.youtube.com/embed/${movie.movTrailer}?si=MLICGmo6npmC-CJj&amp;controls=0&autoplay=1&loop=1&rel=0&mute=1&playlist=${movie.movTrailer}"
                                    title="${movie.movName}"
                                    frameborder="0"
                                    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                                    allowfullscreen
                                ></iframe>`;
            }else{
                movie_item = `<div class="poster" data-movId="${movie.movId}">
                                    <a href="/${c_path}/movie/detail?movId=${movie.movId}" class="poster">
                                        <img src="https://image.tmdb.org/t/p/w500/${movie.movPoster}" alt="${movie.movName}">
                                    </a>
                                </div>`;
            }
            if (viewSize == 6){
                $(parentClass).append(movie_item);
            }else{
                $(parentClass).eq(i).append(movie_item);
            }
            i += 1;
        });
    }
    showMovieList(bannerList, ".mainbanner_list", 5, "");
    showMovieList(allBestList, ".allBox .swiper-slide", 10, "ranking");
    showMovieList(netflixBestList, ".netflixBox .swiper-slide", 10, "ranking");
    showMovieList(searchBestList, ".wannerBox .swiper-slide", 10, "");
    showMovieList(gibliList, ".gibliBox", 6, "");
    showMovieList(marbleList, ".marbleBox", 6, "");
    showMovieList(harryList, ".harryBox", 6, "");

// 베스트 댓글 클릭했을 때 상세페이지로 이동
    $(".review_box").on('click', '.review', function(){
        let movId = $(this).data("movid");
        location.href = "/" + c_path + "/movie/detail?movId="+movId;
    });

// 검색버튼 눌렀을 때, 엔터쳤을 때 리스트 페이지로 이동
    $(".search_bar").on('click', '.s_icon', function(){
        location.href = "/" + c_path + '/list/chart?title=search&val=' + $(".search").val();
    });
    $(".search").keydown(function(){
        if(event.keyCode == 13){
            location.href = "/" + c_path + '/list/chart?title=search&val=' + $(".search").val();
        }
    });
// 베스트 댓글 출력
//     function review_content() {
//         let review_item = `<div class="review_movie_name">영화제목</div>
//                         <div class="review_txt">리뷰 작성</div>
//                         <div class="review_title">닉네임</div>
//                         <div class="star_icon"><img src="./img/star.png" alt=""></div>
//                         <div class="movie_star">4.2</div>
//                         <div class="like_box">
//                             <div class="like_icon"><img src="./img/heart_cnt.png" alt=""></div>
//                             <div class="like_cnt">256</div>
//                         </div>`
//         $(review_item).appendTo('.review')
//     }
//     review_content();

// 순위(스와이퍼)
    var swiper = new Swiper(".mySwiper", {
        slidesPerView: 2.3, // 칸 수
        spaceBetween: 30,
        autoHeight : true,
        // freeMode: true,
        pagination: {
            el: ".swiper-pagination",
            clickable: true,
        },
        breakpoints: {
            768: {
                slidesPerView: 4,  //브라우저가 768보다 클 때
                spaceBetween: 40,
            },
            1024: {
                slidesPerView: 5,  //브라우저가 1024보다 클 때
                spaceBetween: 70,
            },
        },
        // Navigation arrows
        navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
        },
        loop: false,
        direction: 'horizontal', //horizontal,vertical 배치 방향
        effect: 'slide' // 'slide', 'fade', 'cube', 'coverflow', 'flip' or 'creative'
    });


// 메인베너
    var idx_lgth = $(".main_banner>div").length;
    var srt = 1;
    var idx = 0;

    $("section>a").click(function(){
        idx = $(this).index();
        srt = idx;
        $(this).addClass('on').siblings().removeClass('on');
        $(".main_banner>div").eq(idx).addClass('on').siblings().removeClass('on');
    });

    var AutoSlide = setInterval(AutoRun, 5000);

    function AutoRun(){

        if(srt == idx_lgth){
            srt = 0;
        }
        $("section>a").eq(srt).addClass('on').siblings().removeClass('on');
        $(".main_banner>div").eq(srt).addClass('on').siblings().removeClass('on');
        srt++;
    }

    $(".main_banner").mouseover(function(){
        clearInterval(AutoSlide);
        $(".right_btn").css({opacity : '1'});
        $(".left_btn").css({opacity : '1'});
    });
    $(".main_banner").mouseleave(function(){
        AutoSlide = setInterval(AutoRun, 5000);
        $(".right_btn").css({opacity : '0'});
        $(".left_btn").css({opacity : '0'});
    });

    $(".right_btn").click(function(){
        srt++;
        if(srt == idx_lgth){
            srt = 0;
        }
        $(".main_banner>div").eq(srt).addClass('on').siblings().removeClass('on'); $("section>a").eq(srt).addClass('on').siblings().removeClass('on');
    });

    $(".left_btn").click(function(){
        srt--;
        if(srt == -1){
            srt = idx_lgth-1;
        }
        $(".main_banner>div").eq(srt).addClass('on').siblings().removeClass('on');
        $("section>a").eq(srt).addClass('on').siblings().removeClass('on');
    });
});