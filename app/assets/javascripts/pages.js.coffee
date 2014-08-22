DEFAULT =
  bri: 254
  hue: 14922
  sat: 144

intervalID = null


$ ->
  $('#on-button').click ->
    data = on: false
    change(data)
  $('#off-button').click ->
    data = on: true
    change(data)
  $("#party-button").click ->
    data = effect: "colorloop", on: true
    change(data)

  $('#start').click ->
    intervalID = setInterval(->
      hue = Math.floor(Math.random() * 65536)
      change(hue: hue, transitiontime: Number($('#transitiontime').val()))
    , 1000)

  $('#stop').click ->
    clearInterval(intervalID)
    bri = Number($('#bri').val())
    change($.extend({}, DEFAULT, bri: bri))

window.change = (data) ->
  $('input[name="lights"]:checked').each (i, el) ->
    $.ajax("#{gon.endpoint}/lights/#{el.value}/state",
      data: JSON.stringify(data)
      contentType: 'application/json'
      method: 'PUT'
    ).done((data) ->
      console.log(data)
    )

window.restore = ->
  change(DEFAULT)
