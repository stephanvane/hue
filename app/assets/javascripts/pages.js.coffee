# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#on-button').click (e) ->
    data = on: false
    send(data)
  $('#off-button').click (e) ->
    data = on: true
    send(data)
  $("#party-button").click (e) ->
    data = effect: "colorloop", on: true
    send(data)

send = (data) ->
  $.ajax("#{gon.endpoint}/groups/0/action",
    data: JSON.stringify(data)
    contentType: 'application/json'
    method: 'PUT'
  ).done((data) ->
    console.log(data)
  )