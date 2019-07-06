$(document).on('turbolinks:load', function(){

  if($(".alert").text() != ""){
    setTimeout(function(){
      $(".alert").addClass("removeAlert")
    },2000);

    setTimeout(function(){
      $(".alert").css("display", "none")
    },3400);

  }

  $('#js-flash_messages').on('DOMSubtreeModified propertychange', function() {
    setTimeout(function(){
      $('#js-flash_messages').find(".alert").addClass("removeAlert")
    },2000);

    setTimeout(function(){
      $('#js-flash_messages').find(".alert").css("display", "none")
    },3400);
  });

});