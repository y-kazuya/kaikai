$(document).on('turbolinks:load', function(){
  const monthDays =  [31,29,31,30,31,30,31,31,30,31,30,31]
  const target = $(".js-days")

  function replaceDay(data){

    for(let count = 1; count < data + 1; count++) {
      selected = target.data("birth_day") == count ? 'selected' : '';
      let option = `<option value="${count}" ${selected}>${count}</option>`
      target.append(option)
    }

  }

  function startDay(){
    target.empty()

    if ($(".js-month option:selected").val() == "") {
      return false;
    }
    let month = Number($(".js-month option:selected").val())

    day_count = monthDays[month - 1]

    replaceDay(day_count)


  }


  if ($(".js-month").length ){
    startDay()
  }

  $(".js-month").on("change", function(){
    startDay()
  })
});