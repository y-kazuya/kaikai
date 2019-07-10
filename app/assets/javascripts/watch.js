$(document).on('turbolinks:load', function(){

  $("body").find(".js-active_target").addClass("active")

  $('body').on('DOMSubtreeModified propertychange', function() {

    setTimeout(function(){
      $("body").find(".js-active_target").addClass("active")
    },100);

  });

});