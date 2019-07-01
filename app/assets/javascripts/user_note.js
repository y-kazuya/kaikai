$(document).on('turbolinks:load', function(){



  function htmlUserNote(index) {
    var html = `<div class="js-note-list add_list display_none">
    <p class="remove_content_text">
      <span class="js-remove_note">X</span>
    </p>
    <div class="my_grid grid-1-2-28 my_grid-pc">
    <div class="my_grid_item">
    <div class="form_item need_item">
    <label for="user_notes_attributes_${index}_note_category_id">事柄のカテゴリ</label>
    <select class="form-control js-note_category_area" name="user[notes_attributes][${index}][note_category_id]" id="user_notes_attributes_${index}_note_category_id"><option value="">---未選択---</option></select>
    </div>
    </div>
    <div class="my_grid_item">
    <div class="form_item need_item">
    <label for="user_notes_attributes_${index}_content">内容</label>
    <textarea class="form-control" name="user[notes_attributes][${index}][content]" id="user_notes_attributes_0_content"></textarea>
    </div>
    </div>
    </div>
    </div>`

    return html
  }

  function appendNoteCategories(target, categories){
    console.log(target)
    categories.forEach(function(category){
      let option = `<option value="${category.id}">${category.name}</option>`
      target.append(option)
    });
  }

  function ajaxGetNoteCategories(target) {
    $.ajax({
      url: "/api/note_categories",
      type: "GET",
      dataType: 'json'
    })
    .done(function(data){
      appendNoteCategories(target, data)
    })
    .fail(function() {
      alert("エラーです")
    });
  }

  function addUserNoteCategory(){
    let target = $(".js-note_category_area:last")
    ajaxGetNoteCategories(target)
  }


  function addUserNote(t){
    var target = $(".js-note-lists")
    let index = $(".js-note-list").length
    if (index > 5){
      return false
    }
    target.append(htmlUserNote(index))
    $('body').find('.js-note-list:last').animate( { opacity: 'show',}, { duration: 1000, easing: 'swing', } )
    addUserNoteCategory()

  }

  function removeUserNote(target) {
    if(!confirm('本当に削除しますか？')){
      return false;
    }else{
      target.remove()
    }
  }

  $(".js-add_note").on("click", function(){
    addUserNote(this)
  })

  $("form").on("click", ".js-remove_note", function(){
    let target =$(this).parents(".js-note-list")
    removeUserNote(target)
  });
////////////////////////////////////////////////////////////
  var noteCategoryField = $(".js-note_category_name_field")



  function ajaxCreateNoteCategory(name) {
    $.ajax({
      url: "/api/create_note_category",
      type: "post",
      data: {name: name},
      dataType: 'json',
    })
    .done(function(data){
      if (data.id) {
        noteCategoryField.val("")
        appendNoteCategory(data)
      }else{
        ajaxCreateNoteCategoryError()
      }
    })
    .fail(function() {
      ajaxCreateNoteCategoryError()
    });

  }

  function appendNoteCategory(data) {
    html =`<option value="${data.id}" selected>${data.name}</option>`

    $(".js-note_category_area:last").append(html)
    $("html,body").animate({scrollTop:$(".js-note_category_area:last").offset().top});
  }

  function ajaxCreateNoteCategoryError() {
    alert("保存に失敗しました。同じ名前のタイプが存在する可能性があります")
  }

  function addNoteCategory() {
    let noteCategoryName = noteCategoryField.val()

    if (noteCategoryName == "") {
      return false
    }

    ajaxCreateNoteCategory(noteCategoryName)
  }


  $(".js-add_category_name").on("click", function(){
    addNoteCategory()

  })



});