# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  console.log 3
  $('.edit-question-link').click (e) ->
    e.preventDefault();
    $(this).hide();
    $('form.edit_question').show();

  $(document).on 'click', '.link-up-vote', (e) ->
    e.preventDefault();
    id = $(this).data('questionId');
    $.post "/questions/#{id}/up_vote", (data) ->
      rating = data.rating
      link_revote = JST['templates/questions/link_revote']({ votable: data.votable })
      $( ".notice" ).html( "<p>Вы успешно проголосовали за вопрос</p>" );
      $('.question_rating').text("Рейтинг вопроса " + rating)
      $('.voting-question').html(link_revote)


  $(document).on 'click', '.link-down-vote', (e) ->
    e.preventDefault();
    id = $(this).data('questionId');
    $.post "/questions/#{id}/down_vote", (data) ->
      rating = data.rating
      link_revote = JST['templates/questions/link_revote']({ votable: data.votable })
      $( ".notice" ).html( "<p>Вы успешно проголосовали против вопроса</p>" )
      $('.question_rating').text("Рейтинг вопроса " + rating)
      $('.voting-question').html(link_revote)

  $(document).on 'click', '.revote', (e) ->
    console.log 1
    e.preventDefault()
    id = $(this).data('questionId');
    $.ajax
      url: "/questions/#{id}/revote"
      type: "DELETE"
      success: (data) ->
        rating = data.rating
        html = JST['templates/questions/links_voting']( {votable: {id: data.votable.id }} )
        $('.question_rating').text("Рейтинг вопроса " + rating)
        $('.voting-question').html(html)


$(document).on('turbolinks:load', ready);
