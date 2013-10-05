# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$.fn.datetimepicker.dates["lt-LT"] =
  days: ['sekmadienis','pirmadienis','antradienis','trečiadienis','ketvirtadienis','penktadienis','šeštadienis']
  daysShort: ['sek','pir','ant','tre','ket','pen','šeš']
  daysMin: ['Se','Pr','An','Tr','Ke','Pe','Še']
  months: ['Sausis','Vasaris','Kovas','Balandis','Gegužė','Birželis', 'Liepa','Rugpjūtis','Rugsėjis','Spalis','Lapkritis','Gruodis']
  monthsShort: ['Sau','Vas','Kov','Bal','Geg','Bir', 'Lie','Rugp','Rugs','Spa','Lap','Gru']
  today: "Šiandien"

initDateTimePicker = ->
  $('#due_date').datetimepicker
    language: 'lt-LT'

$(document).ready ->
  initDateTimePicker()

$(document).on 'page:load', ->
  initDateTimePicker()
