DEFAULT =
  bri: 254
  hue: 14922
  sat: 144

class window.Hue.Light
  constructor: (@light_id, @name) ->

  change: (data) ->

    $.ajax("#{gon.endpoint}/lights/#{@light_id}/state",
      data: JSON.stringify(data)
      contentType: 'application/json'
      method: 'PUT'
    )

  restore: ->
    this.change(DEFAULT)
