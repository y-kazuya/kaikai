$(document).on('turbolinks:load', function(){
////////////////////////////////
  //////////////validation/////////////////////
  ////////////////////////////////

///////////初期化////////////////////


  PASSWORD_MIN = 6
  MAX_50 = 50 //use_email name
  PASSWORD_NAME = "account[password]"
  RE_PASSWORD_NAME = "account[password_confirmation]"
  $(".ajax-validation").find(".btn").prop("disabled", true);
  var form_validation = false
  var errors ={}


///////////////////////////////////////

/////////////////////ばりテーション発火////////////


  ////////////////// ロード時ばりテーション////////////////
  $.each($(".ajax-validation").find(".v-input").find("input"), function(index, value) {
    var target = $(this)
    var target_name = target.attr("name")
    errors[target_name] = []
    pw_same_validation(target)


    if (target.parents(".form_item").hasClass("v-max-50")){
      v_max_word(target)
    }
    append_v_message(target)
    check_form_validation(target)
  })
  /////////////////////////////////////////////////////
  ///////////入力じバーリテーション(基本全てのバリテーションを行う)///////////////
  $(".ajax-validation").find(".v-input").find("input").on('input', function(event) {
    var target = $(this)
    var target_name = target.attr("name")
    errors[target_name] = []
    pw_same_validation(target)
    pw_min_validation(target)

    if (target.parents(".form_item").hasClass("v-max-50")){
      v_max_word(target)
    }
    append_v_message(target)
    check_form_validation(target)
  })
  ////////////////////////////////////
////////////////////////////////////////////////////////////////////////


/////////////////////ばりテーション一覧/////////////////

////////////////////////password_validation///////////////////////////////////////////////////////////////////////////////////////////////////
  function v_need_same_pasword(target){
    if (target.parents(".form_item").hasClass("v-password")) {
      var tar2 = target.parents(".ajax-validation").find(".v-password-re").find("input")
    } else{
      var tar2 = target.parents(".ajax-validation").find(".v-password").find("input");
    }
    if(target.val() == tar2[0].value){
      //ok//
    }
    else{
      errors[RE_PASSWORD_NAME].push("パスワードが一致しません")
    }
  }

  function v_min_pass_words(target){
    if (target.val().length < PASSWORD_MIN){
      errors[PASSWORD_NAME].push("パスワードは6文字以上にしてください")
    }
  }

  function pw_same_validation(target) {

    if (target.parents(".form_item").hasClass("v-password") || target.parents(".form_item").hasClass("v-password-re")){
      errors[RE_PASSWORD_NAME] = []
      v_need_same_pasword(target)
    }
  }

  function pw_min_validation(target){
    if (target.parents(".form_item").hasClass("v-password")){
      errors[PASSWORD_NAME] = []
      v_min_pass_words(target)
    }
  }

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


  function v_max_word(target){
    if (target.val().length > MAX_50){
      errors[target.attr("name")].push("50文字以下にしてください")
    }
  }




  function all_need_check(target){      ////////inputがあったフォームで、入力が必要な要素に全て入力してるか？
    var summry = true
    var target_form = $(target).parents(".ajax-validation")


    $.each($(target_form).find(".v-need").find("input"), function(index, value) {
      if ($(value).val() == ""){
        summry = false
      }
    })

    return summry

  }



  function append_v_message(target){
    var pare = target.parents(".ajax-validation") ///////////////////
    pare.find(".ajax-error-content").remove()
    v_words =[]
    form_validation = true                         //////初期化/////////
    $.each( errors, function( key, value ) { ///////////////////////

      var validatin_content_input = $(pare).find(`[name="${key}"]`)
      var validatin_content_parent =  validatin_content_input.parents(".form_item")
      $(validatin_content_input).removeClass("validation_input-red")

      if(validatin_content_parent.find(".ajax-error-content").length){
        $.each(validatin_content_parent.find(".ajax-error-content"), function(index, value) {
          v_words.push($(value)[0].innerText)
        })
      }

      if(value.length > 0){
        form_validation = false
        $.each(value, function(index, value) {
          if ($.inArray(value, v_words) < 0) {
            $(validatin_content_input).addClass("validation_input-red")
            $(validatin_content_parent).append(make_v_message(value))

          }
        })
      }
    });


  }


  function make_v_message(word){
    html = `<p class="ajax-error-content">
    <span>${word}</span>
    </p>`

    return html
  }


  function check_form_validation(target) {

    if (form_validation && all_need_check(target)){
      target.parents(".ajax-validation").find(".btn").prop("disabled", false);
    }
    else{
      target.parents(".ajax-validation").find(".btn").prop("disabled", true);
    }
  }

});