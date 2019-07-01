$(document).on('turbolinks:load', function(){

  if($(".alert").text() != ""){
    setTimeout(function(){
      $(".alert").addClass("removeAlert")
    },2000);

    setTimeout(function(){
      $(".alert").css("display", "none")
    },3400);

  }

});