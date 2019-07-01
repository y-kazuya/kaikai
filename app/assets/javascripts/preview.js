$(document).on('turbolinks:load', function(){

  $(document).on("change",".image" ,function(e) {
    var file = e.target.files[0];
    var reader = new FileReader();
    var target = $(this).parent(".picture_field").find("img")
    if(file.type.indexOf("image") != 0){
      alert("画像ファイルを選択してください");
      return false;
    }

    reader.onload = (function(){
      return function(e){
        target.attr("src", e.target.result);
      };
    })(file);
    reader.readAsDataURL(file);
  })
})