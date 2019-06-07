$(document).on('turbolinks:load', function(){

  var checkNameField = $(".js-check_name_field")
  var checkKindField = $(".js-check_kind_field")

  function ajaxCreateCheck(name, kind) {
    $.ajax({
      url: "/api/create_check",
      type: "post",
      data: {title: name, kind: kind},
      dataType: 'json',
    })
    .done(function(data){
      if (data.id) {
        checkNameField.val("")
        appendCheck(data)
      }else{
        ajaxCreateCheckError()
      }
    })
    .fail(function() {
      ajaxCreateCheckError()
    });

  }

  function appendCheck(data) {
    html =`<div class="js-check_list">
    <label for="user_check_ids_${data.id}"><input type="checkbox" value="${data.id}" name="user[check_ids][]" id="user_check_ids_${data.id}"></label>
    <div class="check-list-name">
    ${data.title}(${data.kind})
    </div>
    </div>`

    $(".js-check_lists").append(html)
  }

  function ajaxCreateCheckError() {
    alert("保存に失敗しました。同じ名前のタイプが存在する可能性があります")
  }

  function addCheck() {
    let checkyName = checkNameField.val()
    let checkKind  = checkKindField.val()

    if (checkyName == "" || checkKind == "") {
      alert("正しく入力してください")
      return false
    }

    ajaxCreateCheck(checkyName, checkKind)
  }


  $(".js-add_check").on("click", function(){
    addCheck()

  })



});