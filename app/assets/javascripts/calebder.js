$(document).on('turbolinks:load', function(){
  $('#calendar').fullCalendar({ //カレンダーの表示
    //カレンダー設定//////////////////////////////////////////////////////
    //カレンダー上部を年月で表示させる
    default: 'bootstrap',
    titleFormat: 'YYYY年 M月',
    //曜日を日本語表示
    dayNamesShort: ['日', '月', '火', '水', '木', '金', '土'],

    header: {
      left: 'prev',
      center: 'title',
      right: 'today, next',
    },


    buttonText: {

      prevYear: '前年',
      nextYear: '翌年',
      today: '今日',
      month: '月',
      week: '週',
      day: '日'
  },

    Boolean, default: true,
    showNonCurrentDates: true,
    fixedWeekCount: false,
    //////////////////////////////////////////////////////////////////////////


    events: { //貸し出せるひを取得
      url: '/api/user_counts.json',
      type: 'GET',
      success: function(){

      },
      error: function() {
        alert('there was an error while fetching events!');
      },

    },

    eventRender: function (event, element, view) {

      // if (view.title.length == 9) {
      //   var view_m = Number(view.title.slice(5, 8))
      // }
      // else{
      //   var view_m = Number(view.title.slice(5, 7))
      // }

      // if (Number(event.start._i.slice(5, 7)) !=  view_m) {
      //    return false;
      // }

    },

    // selectable: true,
    // selectHelper: true,

    Boolean, default: true,
    showNonCurrentDates: true,
    fixedWeekCount: false,




    dayClick: function(data, view) {

      var date = $(this).data("date").split("-")
      var now_year_month = $(".fc-center").find("h2").text().split(" ")
      if (Number(now_year_month[1].replace( /月/g , "" )) != Number(date[1])) {
        return
      }

      $(".fc-day").css('background-color', '');
      $(this).css('background-color', 'gray');

      changeUserDate($(this).data("date"))

    },
    eventClick: function(calEvent, jsEvent, view) {
      // select_day(calEvent, jsEvent, view)

    },

    eventMouseover: function(calEvent, jsEvent, view) {
      // over_day(calEvent, jsEvent, view)

    },

    eventMouseout: function(calEvent, jsEvent, view) {
      // out_day(calEvent, jsEvent, view)

    },

  })

/////////////////////////////////////日付クリックイベント//////////////////////////////
  var date_year_target = $(".js-date-year")
  var date_month_target = $(".js-date-month")
  var date_day_target = $(".js-date-day")

  function changeUserDate(data){
    date = data.split('-')
    date_year_target.text(`${date[0]}年`)
    date_month_target.text(`${date[1]}月`)
    date_day_target.text(`${date[2]}日`)
  }

});