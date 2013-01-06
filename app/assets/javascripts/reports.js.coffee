$ ->

  $('.b-reports__nav.admin li').click (e)->
    jClickedItem = $(this)
    jPrevActiveItem = $('li.active')
    jPrevActiveItem.removeClass('active')

    jNewActiveClass = jClickedItem.attr('class')
    jPrevActiveClass = jPrevActiveItem.attr('class')
    $('li.' + jNewActiveClass).addClass('active')

    $('tr.' + jNewActiveClass).removeClass("hidden")
    $('tr.' + jPrevActiveClass).addClass("hidden")
