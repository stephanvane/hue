# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.find-light-link').click (e) ->
    e.preventDefault();

    id = $(this).data('id')

    alertData =
      bri: 255
      hue: 0
      sat: 255


    req1 = $.get("#{gon.endpoint}/lights/#{id}")
    req2 = $.ajax("#{gon.endpoint}/lights/#{id}/state",
      data: JSON.stringify(alertData)
      contentType: 'application/json'
      method: 'PUT'
    )

    $.when(req1, req2).done (res1, res2) ->
      old_state =
        sat: res1[0].state.sat
        bri: res1[0].state.bri
        hue: res1[0].state.hue
      setTimeout(->
        $.ajax "#{gon.endpoint}/lights/#{id}/state",
          data: JSON.stringify(old_state)
          contentType: 'application/json'
          method: 'PUT'
      , 1000)