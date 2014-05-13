# http://stackoverflow.com/a/1060034
onchange = ->
  $.ajax
    url: gon.lock_path,
    type: 'POST'

fullscreen = ->
  $('#fullscreen').click (e) ->
    e.preventDefault()
    docElement = document.documentElement
    request = docElement.requestFullscreen or docElement.webkitRequestFullscreen or docElement.mozRequestFullscreen or docElement.msRequestFullscreen
    request.call docElement if typeof request isnt "undefined" and request
    $('#quiz').show()
    $('#fullscreen').hide()
    $('li.name').hide()
    fs = 'webkitfullscreenchange mozfullscreenchange fullscreenchange'
    fullScreen = false
    $(document).on fs, (e) ->
      fullScreen = !fullScreen
      if !fullScreen
        $.ajax
          url: gon.lock_path,
          type: 'POST'

ready = ->
  if $('#take_quiz_form').length
    fullscreen()
    $(window).blur -> onchange()
    timer(gon.time_left)
  else
    $(window).off 'blur'



#Countdown timer:

timer = (time) ->
  if time > 0
    [minutes, seconds] = [parseInt(time / 60), time % 60]
    $(".seconds").html("#{seconds} second(s)")
    $(".minutes").html("#{minutes} minute(s)")
    setTimeout (-> timer(time - 1)), 1000
  else
    $(".seconds").html("0 second(s)")
    console.log 'Out of time!'
    $("#submit_quiz").click()

$(document).ready ready
$(document).on 'page:load', ready
