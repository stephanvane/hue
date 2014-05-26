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

      $.each($('#timer_light_ids').val(), (_, id) ->
        console.log("GET #{gon.endpoint}/lights/#{id}")
        req1 = $.get("#{gon.endpoint}/lights/#{id}")
        console.log("PUT #{gon.endpoint}/lights/#{id}/state")
        console.log(tmpData)
        req2 = $.ajax("#{gon.endpoint}/lights/#{id}/state",
          data: JSON.stringify(tmpData)
          contentType: 'application/json'
          method: 'PUT'
        )

        $.when(req1, req2).done (res1, res2) ->
          old_state =
            hue: res1[0].state.hue
            sat: res1[0].state.sat
            bri: res1[0].state.bri
          setTimeout(->
            console.log("PUT #{gon.endpoint}/lights/#{id}/state")
            $.ajax "#{gon.endpoint}/lights/#{id}/state",
              data: JSON.stringify(old_state)
              contentType: 'application/json'
              method: 'PUT'
          , 1000)
      )
  )
