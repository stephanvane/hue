DEFAULT =
  bri: 254
  hue: 14922
  sat: 144

running = false
currentLight = 0

Light = Hue.Light

$ ->
  # INIT
  # Fetch all lights
  allLights = {}
  $.each gon.lights, (_, light) ->
    allLights[light.id] = new Light(light.id, light.name)

  # BUTTONS
  $('#on-button').click (e) ->
    data = on: false
    change(checkedLights(), data)
  $('#off-button').click (e) ->
    data = on: true
    change(checkedLights(), data)
  $("#party-button").click (e) ->
    data = effect: "colorloop", on: true
    change(checkedLights(), data)

  # SLIDERS
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


  $('#start').click (e) ->
    e.preventDefault()
    running = true
    randomColor()

  $('#stop').click (e) ->
    e.preventDefault()
    running = false
    bri = $('#bri').slider('value')
    # change($('input[name="lights"]:checked'), $.extend({}, DEFAULT, bri: bri))
    checkedLights().each (_, light) ->
      light.restore()

  window.checkedLights = ->
    $('input[name="lights"]:checked').map (_, input) ->
      allLights[input.value]

  window.change = (lights, data) ->
    console.log("running 'change': lights: #{lights}, data: #{data}")
    reqs = $.map lights, (light) ->
      light.change(data)

    return $.when(reqs...)

  window.randomColor = ->
    return if running == false

    console.log('running randomColor')
    bri = $('#bri').slider('value')
    hue = Math.floor(Math.random() * 65536)
    transitiontime = $('#transitiontime').slider('value')

    lights = checkedLights()

    if true
      currentLight = (currentLight + 1) % lights.length
      lights = [lights[currentLight]]

    change(lights, bri: bri, transitiontime: transitiontime, hue: hue, sat: 255).done ->
      setTimeout(randomColor, $('#interval').slider('value'))
