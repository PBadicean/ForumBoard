# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  $('.edit-question-link').click (e) ->
    e.preventDefault();
    $(this).hide();
    $('form.edit_question').show();

  $(document).on 'click', '.link-up-vote', (e) ->
    e.preventDefault();
    id = $(this).data('questionId');
    $.post "/questions/#{id}/up_vote", (data) ->
      rating = data.rating
      linkRevote = JST['templates/questions/link_revote']({ votable: data.votable })
      $( ".notice" ).html( "<p>Вы успешно проголосовали за вопрос</p>" );
      $('.question_rating').text("Рейтинг вопроса " + rating)
      $('.voting-question').html(linkRevote)


  $(document).on 'click', '.link-down-vote', (e) ->
    e.preventDefault();
    id = $(this).data('questionId');
    $.post "/questions/#{id}/down_vote", (data) ->
      rating = data.rating
      linkRevote = JST['templates/questions/link_revote']({ votable: data.votable })
      $( ".notice" ).html( "<p>Вы успешно проголосовали против вопроса</p>" )
      $('.question_rating').text("Рейтинг вопроса " + rating)
      $('.voting-question').html(linkRevote)

  $(document).on 'click', '.revote', (e) ->
    e.preventDefault()
    id = $(this).data('questionId');
    $.ajax
      url: "/questions/#{id}/revote"
      type: "DELETE"
      success: (data) ->
        rating = data.rating
        linksVote = JST['templates/questions/links_to_vote']({ votable: data.votable })
        $('.question_rating').text("Рейтинг вопроса " + rating)
        $('.voting-question').html(linksVote)

$(document).on('turbolinks:load', ready);
