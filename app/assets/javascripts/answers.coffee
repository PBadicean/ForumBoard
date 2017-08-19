# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  $('body').on 'click', '.edit-answer-link', (e) ->
    answerId =  $(this).parents('.answer-wrapper').data('answerId');
    $('form#edit_answer_'+ answerId).show();
    e.preventDefault();
    $(this).hide();

  $(document).on 'click', '.link-up-vote-answer', (e) ->
    e.preventDefault();
    answer_id = $(this).data('answerId');
    question_id = $(this).data('questionId');

    $.post "/questions/#{question_id}/answers/#{answer_id}/up_vote", (data) ->
      rating = data.rating
      votable = data.votable
      answerWrapper = ".answer-wrapper[data-answer-id=#{votable.id}]"
      linkRevote = JST['templates/answers/link_revote']({ votable: votable })
      $( ".notice" ).html( "<p>Вы успешно проголосовали за ответ</p>" );
      $(answerWrapper + "> .answer_rating").text("Рейтинг ответа " + rating)
      $(answerWrapper + " > .voting-answer").html(linkRevote)

  $(document).on 'click', '.link-down-vote-answer', (e) ->
    e.preventDefault();
    answer_id = $(this).data('answerId');
    question_id = $(this).data('questionId');

    $.post "/questions/#{question_id}/answers/#{answer_id}/down_vote", (data) ->
      rating = data.rating
      votable = data.votable
      answerWrapper = ".answer-wrapper[data-answer-id=#{votable.id}]"
      linkRevote = JST['templates/answers/link_revote']({ votable: votable })
      $( ".notice" ).html( "<p>Вы успешно проголосовали против ответа</p>" );
      $(answerWrapper + "> .answer_rating").text("Рейтинг ответа " + rating)
      $(answerWrapper + " > .voting-answer").html(linkRevote)

  $(document).on 'click', '.revote_answer', (e) ->
    e.preventDefault()
    answer_id = $(this).data('answerId');
    question_id = $(this).data('questionId');
    $.ajax
      url: "/questions/#{question_id}/answers/#{answer_id}/revote"
      type: "DELETE"
      success: (data) ->
        rating = data.rating
        votable = data.votable
        answerWrapper = ".answer-wrapper[data-answer-id=#{votable.id}]"
        linksVote = JST['templates/answers/links_to_vote']({ votable: votable })
        $(answerWrapper + "> .answer_rating").text("Рейтинг ответа " + rating)
        $(answerWrapper + " > .voting-answer").html(linksVote)

$(document).on('turbolinks:load', ready);
