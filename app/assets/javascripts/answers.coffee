# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  $('body').on 'click', '.edit-answer-link', (e) ->
    answerId =  $(this).parents('.answer-wrapper').data('answerId');
    $('form#edit_answer_'+ answerId).show();
    e.preventDefault();
    $(this).hide();

$(document).on('turbolinks:load', ready);
