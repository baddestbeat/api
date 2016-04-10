$(function () {
    //  delete
    $(".js-image-upload-block-delete").on("click", function(){
      $(this).parent().remove();
    });
    // submit
    $("form").submit(function() {
      $("#js-attention").remove();
      $("body").append('<div class="new-image-modal"><span class="gauge-loader">Loading&#8230;</span></div>');
    });

    // 翻訳ページUI
    var hasTapEvent = ('ontouchstart' in window);
    if(hasTapEvent){
      // sp
      $(".image-upload-words-wrapper").on( "touchstart", function () {
          var inputWidth=$(this).width();
          var hiddenInput = $(this).children("input");
          var wordWrapSpan = $(this).children(".image-upload-words");
          var interval = 1000;
          timer = setTimeout(function(){
              wordWrapSpan.css("display", "none");
              hiddenInput.css("display", "").css("width", inputWidth-4).focus();
              hiddenInput.blur(function() {
                  whenBlur($(this, wordWrapSpan, hiddenInput));
              });}
            , interval);
      })
    }else{
      // pc
      $(".image-upload-words-wrapper").on( "click", function(){
          var inputWidth=$(this).width();
          $(this).children(".image-upload-words").css("display", "none");
          $(this).children("input")
              .css("display", "").css("width", inputWidth-4).focus();
          $(this).children("input").blur(function() {
              whenBlur($(this));
          });
      })
    }

    function whenBlur(obj,span=undefined, input=undefined){
      if(obj.val() === ""){
        obj.parent().remove();
      };
      if(span && input){
        target.html(obj.val());
        span.css("display", "");
        input.css("display", "none");
      }else{
        obj.parent().children("span").html(obj.val());
        obj.parent().children().css("display", "");
        obj.css("display", "none");
      }
    }

});
