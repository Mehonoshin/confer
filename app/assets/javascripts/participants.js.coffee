# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('.show-report-link').click (e)->
    e.preventDefault()
    jReportFields = $(".report_fields")
    if jReportFields.hasClass("hidden")
      jReportFields.removeClass("hidden")
      $(this).hide()

  $('.b-participants__nav ul.nav li').click (e)->
    e.preventDefault()
    jClickedItem = $(this)
    if jClickedItem.hasClass("pending")
      activeClass = "pending"
      hiddenClass = "approved"
    else
      activeClass = "approved"
      hiddenClass = "pending"
    $('table.' + hiddenClass).addClass('hidden')
    $('table.' + activeClass).removeClass('hidden')
    $('li.' + activeClass).addClass('active')
    $('li.' + hiddenClass).removeClass('active')

