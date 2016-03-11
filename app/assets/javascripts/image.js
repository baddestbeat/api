$(function () {
    // edit
    $(".image-upload-word-edit").on('click', function(){
        $(this).parent().children("a").css("display", "none");
        $(this).parent().children("input")
            .css("display", "")
            .focus();
        $(".image-upload-edit-word").blur(function() {
            var textVal = $(this).val();
            if(textVal !== ""){
                $(this).parent().children("span").html(textVal);
            };
            $(this).parent().children().css("display", "");
            $(this).css("display", "none");
        });
    })
    //  delete
    $(".image-upload-block-delete").on("click", function(){
      $(this).parent().remove();
    });
});
