# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.EPlus = window.EPlus || {};
initGradeWizard = ->
  EPlus.grade_value = parseInt $('#assignment_value').text()
  return unless EPlus.grade_value
  # Add grade? ui
  addGradeUI()
  addGradeEventListeners()
  # Add grade? event listeners

addGradeUI = ->
  $grade_containers = $('.grade_container')
  window.elll = {}
  $grade_containers.each (index, el) ->
    $grade_ui = $('<div />').addClass('grader pull-right').append(
      $('<a />').addClass('grade_request').text('Grade?').attr('href', '#')
    )

addGradeEventListeners = ->
  $('.grade_container').on 'click', '.grade_request', (e) ->
    e.preventDefault()
    console.log("Clicked")
  $('.grade_container').on 'click', '.grade-submit', (e) ->
    $parent = $(this).parents('.grade_container')
    grade = $parent.find('.grade-input').val()
    grade = EPlus.grade_value if grade > EPlus.grade_value
    student_id = $parent.find('.grade-input').data('id')
    $.post("#{window.location.pathname}/grade/#{student_id}", { grade: grade })
      .done (data) ->
        console.log(data)
  $('.grade_container').on 'click', '.grade-min', (e) ->
    e.preventDefault()
    $grade_input = $(this).parents('.grade_container').find('.grade-input')
    $grade_input.val 0
  $('.grade_container').on 'click', '.grade-reduce', (e) ->
    e.preventDefault()
    $grade_input = $(this).parents('.grade_container').find('.grade-input')
    $grade_input.val $grade_input.val() - 1
  $('.grade_container').on 'click', '.grade-raise', (e) ->
    e.preventDefault()
    $grade_input = $(this).parents('.grade_container').find('.grade-input')
    $grade_input.val parseInt($grade_input.val()) + 1
  $('.grade_container').on 'click', '.grade-max', (e) ->
    e.preventDefault()
    $grade_input = $(this).parents('.grade_container').find('.grade-input')
    $grade_input.val EPlus.grade_value


$(document).ready ->
  initGradeWizard()

$(document).on 'page:load', ->
  initGradeWizard()
