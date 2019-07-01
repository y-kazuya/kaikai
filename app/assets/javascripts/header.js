$(document).on('turbolinks:load', function(){

  $(".auth_modal").on("click", function(){
    $(".modal-login").removeClass("active")
    $(".modal-new").removeClass("active")

    if ($(this).data("type") == "new"){
      $(".modal-new").addClass("active")
    } else{
      $(".modal-login").addClass("active")
    }
  })
});