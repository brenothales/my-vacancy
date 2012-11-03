# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('#state_id').change ->
    state_id = $(this).val()
    $.get "/admin/announcements/find_cities_by_state", { state_id:state_id }
