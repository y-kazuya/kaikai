$(document).on('turbolinks:load', function(){



  function htmlUserEM(index) {

    var html = `<div class="js-em-list add_list display_none">
    <p class="remove_content_text">
      <span class="js-remove_em">X</span>
    </p>
    <div class="form-items">
    <div class="my_grid grid-1-2-55">
    <div class="my_grid_item">
    <div class="form_item need_item">
    <label for="user_emergency_contacts_attributes_${index}_name">名前</label>
    <input class="form-control" type="text" name="user[emergency_contacts_attributes][${index}][name]" id="user_emergency_contacts_attributes_${index}_name">
    </div>
    </div>
    <div class="my_grid_item">
    <div class="form_item need_item">
    <label for="user_emergency_contacts_attributes_${index}_relation">続柄</label>
    <input class="form-control small_input" type="text" name="user[emergency_contacts_attributes][${index}][relation]" id="user_emergency_contacts_attributes_${index}_relation">
    </div>
    </div>
    </div>
    <div class="my_grid grid-1-2-55 my_grid-pc">
    <div class="my_grid_item">
    <div class="form_item need_item">
    <label for="user_emergency_contacts_attributes_${index}_tel">電話番号</label>
    <input class="form-control" type="number" name="user[emergency_contacts_attributes][${index}][tel]" id="user_emergency_contacts_attributes_${index}_tel">
    </div>
    </div>
    <div class="my_grid_item">
    <div class="form_item need_item">
    <label for="user_emergency_contacts_attributes_${index}_email">メールアドレス</label>
    <input class="form-control" type="email" name="user[emergency_contacts_attributes][${index}][email]" id="user_emergency_contacts_attributes_${index}_email">
    </div>
    </div>
    </div>
    <div class="address_area my_grid fit-grid-half">
    <div class="my_grid_item">
    <div class="form_item need_item">
    <label for="user_emergency_contacts_attributes_${index}_pref">都道府県</label>
    <select class="form-control js-pref half_input" name="user[emergency_contacts_attributes][${index}][pref]" id="user_emergency_contacts_attributes_${index}_pref"><option value="▼選択して下さい">▼選択して下さい</option>
    <option value="北海道">北海道</option>
    <option value="青森県">青森県</option>
    <option value="岩手県">岩手県</option>
    <option value="宮城県">宮城県</option>
    <option value="秋田県">秋田県</option>
    <option value="山形県">山形県</option>
    <option value="福島県">福島県</option>
    <option value="茨城県">茨城県</option>
    <option value="栃木県">栃木県</option>
    <option value="群馬県">群馬県</option>
    <option value="埼玉県">埼玉県</option>
    <option value="千葉県">千葉県</option>
    <option value="東京都">東京都</option>
    <option value="神奈川県">神奈川県</option>
    <option value="新潟県">新潟県</option>
    <option value="富山県">富山県</option>
    <option value="石川県">石川県</option>
    <option value="福井県">福井県</option>
    <option value="山梨県">山梨県</option>
    <option value="長野県">長野県</option>
    <option value="岐阜県">岐阜県</option>
    <option value="静岡県">静岡県</option>
    <option value="愛知県">愛知県</option>
    <option value="三重県">三重県</option>
    <option value="滋賀県">滋賀県</option>
    <option value="京都府">京都府</option>
    <option value="大阪府">大阪府</option>
    <option value="兵庫県">兵庫県</option>
    <option value="奈良県">奈良県</option>
    <option value="和歌山県">和歌山県</option>
    <option value="鳥取県">鳥取県</option>
    <option value="島根県">島根県</option>
    <option value="岡山県">岡山県</option>
    <option value="広島県">広島県</option>
    <option value="山口県">山口県</option>
    <option value="徳島県">徳島県</option>
    <option value="香川県">香川県</option>
    <option value="愛媛県">愛媛県</option>
    <option value="高知県">高知県</option>
    <option value="福岡県">福岡県</option>
    <option value="佐賀県">佐賀県</option>
    <option value="長崎県">長崎県</option>
    <option value="熊本県">熊本県</option>
    <option value="大分県">大分県</option>
    <option value="宮崎県">宮崎県</option>
    <option value="鹿児島県">鹿児島県</option>
    <option value="沖縄県">沖縄県</option></select>
    </div>
    </div>
    <div class="my_grid_item">
    <div class="form_item need_item">
    <label for="user_emergency_contacts_attributes_${index}_city">市町村</label>
    <select class="form-control js-citys half_input" data-city_name="" name="user[emergency_contacts_attributes][${index}][city]" id="user_emergency_contacts_attributes_${index}_city"></select>
    </div>
    </div>
    <div class="my_grid_item">
    <div class="form_item">
    <label for="user_emergency_contacts_attributes_${index}_address">町名・番地</label>
    <input class="form-control" type="text" name="user[emergency_contacts_attributes][${index}][address]" id="user_emergency_contacts_attributes_${index}_address">
    </div>
    </div>
    </div>
    </div>
    </div>`

    return html
  }


  function addUserEM(t){
    var target = $(".js-em-lists")
    let index = $(".js-em-list").length
    if (index > 2){
      return false
    }
    target.append(htmlUserEM(index))
    $('body').find('.js-em-list:last').animate( { opacity: 'show',}, { duration: 1000, easing: 'swing', } )

  }

  function removeUserEM(target) {
    if(!confirm('本当に削除しますか？')){
      return false;
    }else{
      target.remove()
    }
  }

  $(".js-add_em").on("click", function(){
    addUserEM(this)
  })

  $("body").on("click", ".js-remove_em", function(){
    let target = $(this).parents(".js-em-list")

    removeUserEM(target)
  });


  $('body').on({
    mouseenter: function() {
      let target = $(this).parents(".js-em-list")
      target.css("opacity", "0.6")
    },
    mouseleave: function() {
      let target = $(this).parents(".js-em-list")
      target.css("opacity", "1.0")
    }
  }, '.js-remove_em')

});