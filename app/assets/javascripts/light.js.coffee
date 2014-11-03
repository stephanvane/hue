DEFAULT =
  bri: 254
  hue: 14922
  sat: 144

class window.Hue.Light
  constructor: (@light_id, @name) ->

  change: (data) ->

    $.ajax("http://192.168.192.12/api/stephanvane/lights/#{@light_id}/state",
      data: JSON.stringify(data)
      contentType: 'application/json'
      method: 'PUT'
    )

  restore: ->
    this.change(DEFAULT)
