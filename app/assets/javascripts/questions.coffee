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
    id = $(this).data('questionId');
    $.post "/questions/#{id}/up_vote", (data) ->
      rating = data.rating;
      $( ".question-wrapper" ).before( "<p>Вы успешно проголосовали за вопрос</p>" );
      $('.question_rating').text("Рейтинг вопроса " + rating);
      $('.voting-question').html('<a class="revote" href="">Переголосовать</a>')


  $('.link-down-vote').click (e) ->
    e.preventDefault();
    questionId = $(this).data('questionId');
    $.post "/questions/#{questionId}/down_vote", (data) ->
      rating = data.rating;
      $( ".question-wrapper" ).before( "<p>Вы успешно проголосовали против вопроса</p>" );
      $('.question_rating').text("Рейтинг вопроса " + rating);
      $('.voting-question').html('<a class="revote" href="">Переголосовать</a>')



$(document).on('turbolinks:load', ready);
