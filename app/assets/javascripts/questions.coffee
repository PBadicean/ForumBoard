# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  $('.edit-question-link').click (e) ->
    e.preventDefault();
    $(this).hide();
    $('form.edit_question').show();

  $('.link-up-vote').click (e) ->
    e.preventDefault();
    questionId = $(this).data('questionId');
    $.post "/questions/#{questionId}/up_vote", (data) ->
      $( ".question-wrapper" ).before( "<p>Вы успешно проголосовали за вопрос</p>" );
      $('.question_rating').text("Рейтинг вопроса " + data.rating)
      $('.link-up-vote').hide();
      $('.link-down-vote').hide();

$(document).on('turbolinks:load', ready);
