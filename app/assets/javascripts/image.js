$(function () {
    // edit
    $(".js-image-upload-word-edit").on('click', function(){
        $(this).parent().children("a").css("display", "none");
        $(this).parent().children("input")
            .css("display", "")
            .focus();
        $(".js-image-upload-edit-word").blur(function() {
            var textVal = $(this).val();
            if(textVal !== ""){
                $(this).parent().children("span").html(textVal);
            };
            $(this).parent().children().css("display", "");
            $(this).css("display", "none");
        });
    })
    //  delete
    $(".js-image-upload-block-delete").on("click", function(){
      $(this).parent().remove();
    });
    // submit
    $("#new_image").submit(function() {
      if ($("input[name='image[file]']").val() == '') {
        $("#js-attention").remove();
        $("#image_file").focus();
        $("#new_image").prepend("<p id='js-attention'>ファイルを選択してください</p>");
        return false;
      }
      $("body").append('<div class="new-image-modal"><span class="gauge-loader">Loading&#8230;</span></div>');
      // $(":submit", this).prop("disabled", true);
    });
});
