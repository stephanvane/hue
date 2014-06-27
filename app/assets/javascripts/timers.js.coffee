# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.picker').ColorPicker(
    flat: true
    onSubmit: (hsb) ->
      h = Math.round(hsb.h / 360 * 65535)
      s = Math.round(hsb.s / 100 * 255)
      b = Math.round(hsb.b / 100 * 255)
      $('#timer_hue').val(h)
      $('#timer_sat').val(s)
      $('#timer_bri').val(b)

      tmpData =
        hue: h
        sat: s
        bri: b

      # loop trough all lights
      $.each($('#timer_light_ids').val(), (_, id) ->
        # get state
        $.get("#{gon.endpoint}/lights/#{id}").done((data) ->
          old_state =
            hue: data.state.hue
            sat: data.state.sat
            bri: data.state.bri

          # set new state
          $.ajax("#{gon.endpoint}/lights/#{id}/state",
            data: JSON.stringify(tmpData)
            contentType: 'application/json'
            method: 'PUT'
          ).done((data) ->
            setTimeout(->
              # set old state
              $.ajax("#{gon.endpoint}/lights/#{id}/state",
                data: JSON.stringify(old_state)
                contentType: 'application/json'
                method: 'PUT'
              )
            , 1000)
          )
        )
      )
  )
