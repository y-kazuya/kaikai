$(document).on('turbolinks:load', function(){


  if ($(".chart_zone").length) {

  }

  $(".js-cart_title").on("click", function(){
    var user_id = $(this).data('userId')
    var check_id = $(this).data('checkId')
    $.ajax({
      url: `/api/users/${user_id}/check/${check_id}`,
      type: "get",
      dataType: 'json',
    })
    .done(function(data){
      console.log(data)
      makeChart(data)

    })
    .fail(function() {
      alert("通信に失敗しました")

    });
  })



  function makeChart(data) {

    var ctx = document.getElementById('myChart').getContext('2d');
    var myChart = new Chart(ctx, {
      type: 'line',
      data: {
          labels: data.dates,

          datasets: [{
              label: data.check.title,
              data: data.records,
              backgroundColor: [
                  'rgba(255, 99, 132, 0.2)',
                  'rgba(54, 162, 235, 0.2)',
                  'rgba(255, 206, 86, 0.2)',
                  'rgba(75, 192, 192, 0.2)',
                  'rgba(153, 102, 255, 0.2)',
                  'rgba(255, 159, 64, 0.2)'
              ],
              borderColor: [
                  'rgba(255, 99, 132, 1)',
                  'rgba(54, 162, 235, 1)',
                  'rgba(255, 206, 86, 1)',
                  'rgba(75, 192, 192, 1)',
                  'rgba(153, 102, 255, 1)',
                  'rgba(255, 159, 64, 1)'
              ],
              borderWidth: 1,
              lineTension: 0, //<===追加
              fill: false,    //<===追加
              pointBorderWidth: 7,  //ここを追加
          }]
      },
      options: {
        legend: {
          labels: {
            fontSize: 19
          }
        },
        responsive: true,
        scales: {
          yAxes: [{
            ticks: {
              beginAtZero: true
            }
          }]
        }
      }
    });
  }
});