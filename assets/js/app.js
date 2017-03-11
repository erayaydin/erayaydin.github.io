/**
 * Toggle Navigation
 */
$('.nav-toggle').bind('click', function(){
    var menus = $(this).siblings(".nav-menu");
    if(menus.hasClass('is-active')){
        menus.removeClass('is-active');
    } else {
        menus.addClass('is-active');
    }
});

/**
 * Disqus Comment System
 */
(function() {
    var d = document, s = d.createElement('script');
    s.src = '//aydineray.disqus.com/embed.js';
    s.setAttribute('data-timestamp', +new Date());
    (d.head || d.body).appendChild(s);
})();