$(document).on('turbolinks:load', function(){
  const target = $(".js-citys")

  function replaceCitys(data){
    data.result.forEach(function(city){
      target.data("city_name")
      selected = target.data("city_name") == city.cityName ? 'selected' : '';
      let option = `<option value="${city.cityName}" ${selected}>${city.cityName}</option>`
      target.append(option)
    });
  }

  function startCity(){
    target.empty()
    console.log(target.data("city_name"))

    if ($(".js-pref").find('option:selected')[0] == undefined) {
      return false;
    }
    let state = Number($(".js-pref").find('option:selected')[0].index)
    state += 1

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
      replaceCitys(data)

    })
    .fail(function() {
      alert("もう一度都道府県を選びなおしてください")
    });

  }


  if ($(".js-pref").length ){
    startCity()
  }

  $(".js-pref").on("change", function(){
    target.empty()
    startCity()
  })
});