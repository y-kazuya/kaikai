$(document).on('turbolinks:load', function(){



  $(".ajax-form").on("ajax:error", function(event, xhr) {
    alert("通信エラーです。しばらくしてからやり直してください")
  });


  $(".login_form").on("ajax:success", function(event, xhr, settings) {
    console.log(event.detail[0])　
    if (event.detail[0]["fail_login"]){
      var message = "メールアドレスもしくは、パスワードが違います。"
      fail_session(this, message)
      $(this).find(".btn").prop("disabled", true);
    }
  });



  function fail_session(thi, message){
    var target = $(thi).find(".form-error").find(".form-error-title")
    if (!target.length){
      $(thi).find(".form-error").append(errorMessage(message))
      setTimeout(function(){
        $(thi).find(".form-error").find(".form-error-title").addClass("active")
      },100);
    }
    else{
      $(thi).find(".form-error").find(".form-error-title").addClass("bib")
      setTimeout(function(){
        $(thi).find(".form-error").find(".form-error-title").removeClass("bib")
      },2000);
    }
  }

  function errorMessage(message){
    var html = `<div class="form-error-title">
      <span>${message}</span>
    </div>`
    return html
  }

  //////////////////////////////////////////////////////////////////
  ////////////////sign in//////////////////////////////////////////

  $(".signup_form").on("ajax:success", function(event, xhr, settings) {　
    if (event.detail[0].errors["email"].length) {
      var message = "そのemailはすでに登録されています。"
      fail_session(this,message)
    }
  });



});