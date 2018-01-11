---
---
# Hamburger Menu
document.addEventListener 'DOMContentLoaded', ->
  # Get all "navbar-burger" elements
  $navbarBurgers = Array::slice.call(document.querySelectorAll('.navbar-burger'), 0)
  # Check if there are any nav burgers
  if $navbarBurgers.length > 0
    # Add a click event on each of them
    $navbarBurgers.forEach ($el) ->
      $el.addEventListener 'click', ->
        # Get the target from the "data-target" attribute
        target = $el.dataset.target
        $target = document.getElementById(target)
        # Toggle the class on both the "navbar-burger" and the "navbar-menu"
        $el.classList.toggle 'is-active'
        $target.classList.toggle 'is-active'
        return
      return
  return

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
