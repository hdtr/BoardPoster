// Helpers

function show(box, btn) {
    $(box).attr('style', 'display: none');
    $(btn).click(function () {
        $(box).fadeToggle('slow');
    });
}
//DOM objects operations

$(document).ready(function () {
    show('#register_box', '#register_lnk');
});




// FLASH NOTICE ANIMATION
var fade_flash = function() {
    $("#flash_notice").delay(5000).fadeOut("slow");
    $("#flash_alert").delay(5000).fadeOut("slow");
    $("#flash_error").delay(5000).fadeOut("slow");
};
fade_flash();

var show_ajax_message = function(msg, type) {
    $("#flash_message").html('<div id="flash_'+type+'">'+msg+'</div>');
    fade_flash();
};

$(document).ajaxComplete(function(event, request) {
    var msg = request.getResponseHeader('X-Message');
    var type = request.getResponseHeader('X-Message-Type');
    if(type != null) show_ajax_message(msg, type);
});