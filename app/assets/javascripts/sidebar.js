$(document).on('turbolinks:load', function(){

  $(".js-modal-torriger").on("click", function(){

    $('.sidebar_warpper').toggleClass("js-open_sidebar");
    $('.sidebar_warpper').toggleClass("js-close_sidebar");

    $('.sidebar_open_button').toggleClass("js-open_sidebar_button");
    $('.sidebar_open_button').toggleClass("js-close_sidebar");
    $(".modal-back").toggleClass("js-db");
    if ($('.sidebar_warpper').hasClass("js-open_sidebar")){
      $("body").css("overflow", "hidden")
      $(window).on('touchmove.noScroll', function(e) {
        e.preventDefault();
      });
    } else{
      $("body").css("overflow", "scroll")
      $(window).off('.noScroll');
    }



  })
});