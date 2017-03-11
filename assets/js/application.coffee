---
---
# Toggle Navigation
$(".nav-toggle").bind "click", ->
  menus = $(this).siblings(".nav-menu")
  if menus.hasClass('is-active')
    menus.removeClass('is-active')
  else
    menus.addClass('is-active')

# Disqus Commenting System
if $("#disqus_thread").length
  do ->
    d = document
    s = d.createElement('script')
    s.src = '//aydineray.disqus.com/embed.js'
    s.setAttribute 'data-timestamp', +new Date
    return (d.head or d.body).appendChild s