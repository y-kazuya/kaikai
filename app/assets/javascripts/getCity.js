$(document).on('turbolinks:load', function(){
  // const target = $(".js-citys")

  function replaceCitys(data,target){
    data.result.forEach(function(city){
      target.data("city_name")
      selected = target.data("city_name") == city.cityName ? 'selected' : '';
      let option = `<option value="${city.cityName}" ${selected}>${city.cityName}</option>`
      target.append(option)
    });
  }

  function startCity(state,target){
    target.empty()

    if ($(state).find('option:selected')[0] == undefined) {
      return false;
    }
    state = Number($(state).find('option:selected')[0].index)

    if (state == 0) {
      return false;
    }


    let url = `https://opendata.resas-portal.go.jp/api/v1/cities?prefCode=${state}`
    const api_key = "sLXRi2Ovt21lcBxeFykUus8r0XIiHIAqtPrxntoW"
    $.ajax({
      headers: {
        "X-API-KEY" : api_key
       },
      url: url,
      type: "GET",
      dataType: 'json',
    })
    .done(function(data){
      replaceCitys(data,target)

    })
    .fail(function() {
      alert("もう一度都道府県を選びなおしてください")
    });

  }


  if ($(".address_area").length ){

    $.each($(".js-pref"), function(i, state) {
      let insert_target = $(state).parent(".address_area").find(".js-citys")
      startCity(state, insert_target)
    });
  }



  $("form").on("change", ".js-pref", function(){
    console.log("aaa")
    state = this
    let insert_target = $(state).parent(".address_area").find(".js-citys")
    startCity(state, insert_target)

  });



});