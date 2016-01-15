/*
* Window.onload will be triggered on the first page load as normal,
* and then manually for Turbolinks pages.
* taken from: https://github.com/rails/turbolinks/issues/295#issuecomment-70036212
*/
window.loadEventsBound = false;
$(document).on('page:change', function(){
    if(window.loadEventsBound) {
        $(window).trigger('load');
    }
});
$(window).on('load', function(){
    window.loadEventsBound = true;
});
