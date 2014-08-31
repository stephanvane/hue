DEFAULT =
  bri: 254
  hue: 14922
  sat: 144

running = false


$ ->
  # Sliders
  $('#bri').slider
    max: 255
    slide: (e, ui) ->
      $(this).parents('.form-group').find('.val').html(ui.value)
  $('#transitiontime').slider
    max: 100
    min: 1
    slide: (e, ui) ->
      $(this).parents('.form-group').find('.val').html(ui.value)
  $('#interval').slider
    max: 10000
    step: 100
    min: 100
    slide: (e, ui) ->
      $(this).parents('.form-group').find('.val').html(ui.value)

  $('#on-button').click (e) ->
    data = on: false
    change(data)
  $('#off-button').click (e) ->
    data = on: true
    change(data)
  $("#party-button").click (e) ->
    data = effect: "colorloop", on: true
    change(data)

  $('#start').click (e) ->
    e.preventDefault()
    running = true
    randomColor()

  $('#stop').click (e) ->
    e.preventDefault()
    running = false
    bri = $('#bri').slider('value')
    change($('input[name="lights"]:checked'), $.extend({}, DEFAULT, bri: bri))

window.change = (lights, data) ->
  console.log('running "change"')
  reqs = lights.map (i, el) ->
    $.ajax("#{gon.endpoint}/lights/#{el.value}/state",
      data: JSON.stringify(data)
      contentType: 'application/json'
      method: 'PUT'
    )
  return $.when(reqs...)

window.randomColor = ->
  return if running == false

  console.log('running randomColor')
  bri = $('#bri').slider('value')
  hue = Math.floor(Math.random() * 65536)
  transitiontime = $('#transitiontime').slider('value')

  change($('input[name="lights"]:checked'), bri: bri, transitiontime: transitiontime, hue: hue).done ->
    console.log('done')
    setTimeout(randomColor, $('#interval').slider('value'))