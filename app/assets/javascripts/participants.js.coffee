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