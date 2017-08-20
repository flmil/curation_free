
$(function(){
  alert("DONE");
  $("#more").click(function() {
    alert("click!!!")
    var h = $(window).height();
    $('#wrap').css('display','none');
    $('#loader-bg ,#loader').height(h).css('display','block');

    var data = {
      word: $("#search").val(),
      pages: $("#more").val(),
    };

    $("#more").remove();

    $.ajax({
      type:"post",                // method = "POST"
        url: window.location.origin + "/more",        // POST送信先のURL
        data:JSON.stringify(data),  // JSONデータ本体
        contentType: 'application/json', // リクエストの Content-Type
        dataType: "json",           // レスポンスをJSONとしてパースする
        success: function(json_data) {   // 200 OK時
          // JSON Arrayの先頭が成功フラグ、失敗の場合2番目がエラーメッセージ
          if (!json_data[0]) {    // サーバが失敗を返した場合
            alert("Transaction error. " + json_data[1]);
            return;
          } else {
            for(var i=0; i < json_data.length; i++){
              $("#search_value").append(
                "<ul class='foo'>" +
                "<li>" + "<a href='" + json_data[i].url + "'><img border='1' src='" + json_data[i].image + "' width='70%' height='auto'> </a>" + "</li>" +
                "<li>" + "<a href='" + json_data[i].url + "'><h6>" + json_data[i].name + "</h6>" + "</li>" + 
                "<li>" + "<a href='" + json_data[i].url + "'><h5>" + json_data[i].money + "</h5>" + "</li>" + 
                "<form action='add_list' method='post'>" +
                "<input type='hidden' name='name' value='" + json_data[i].name + "'>" +
                "<input type='hidden' name='money' value='" + json_data[i].money + "'>" +
                "<input type='hidden' name='url' value='" + json_data[i].url + "'>" +
                "<input type='hidden' name='image' value='" + json_data[i].image + "'>" +
                "<input type='hidden' name='site' value='" + json_data[i].site + "'>" +
                "<button  type='submit'>気になるリストに追加する</button>" + 
                "</form>" +
                "</ul>"
              )
            }
            $("#search_value").append("<div id='more' value='" + ($("#more").val()+1) + "'>もっとみる</div>")
            stopload()
          }
        },
        error: function() {         // HTTPエラー時
          alert("Server Error. Pleasy try again later.");
          stopload()
        },
        complete: function() {      // 成功・失敗に関わらず通信が終了した際の処理
          stopload()
        }
    });
    function stopload(){
      $('#wrap').css('display','block');
      $('#loader-bg').delay(900).fadeOut(800);
      $('#loader').delay(600).fadeOut(300);
    }
  });
});
