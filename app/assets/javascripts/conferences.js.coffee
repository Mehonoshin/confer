# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('.datepicker').datepicker({
    'dateFormat': 'dd-mm-yy'
  })

  $(".b-conferences__nav a").click (e)->
    e.preventDefault()
    jPrevVisible = $('.b-conferences__nav .active')
    jNewVisible = $(this)
    jPrevVisible.removeClass("active")
    $('.b-conferences__list table.' + jNewVisible.attr("class")).removeClass("hidden")
    $('.b-conferences__list table.' + jPrevVisible.attr("class")).addClass("hidden")
    jNewVisible.parent().addClass("active")

