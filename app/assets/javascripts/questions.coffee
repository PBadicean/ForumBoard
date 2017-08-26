# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  # questionsList = $(".questions_list")
  $('.edit-question-link').click (e) ->
    e.preventDefault();
    $(this).hide();
    $('form.edit_question').show();

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

  $(document).on 'click', '.link-up-vote', (e) ->
    e.preventDefault();
    id = $(this).data('questionId');
    voteRequest("/questions/#{id}/up_vote", "Вы успешно проголосовали за вопрос")

  $(document).on 'click', '.link-down-vote', (e) ->
    e.preventDefault();
    id = $(this).data('questionId');
    voteRequest("/questions/#{id}/down_vote", "Вы успешно проголосовали против вопроса")

  voteRequest = (url, text) ->
    $.post url, (data) ->
      rating = data.rating
      linkRevote = JST['templates/questions/link_revote']({ votable: data.votable })
      $( ".notice" ).html( '<p>'+text+'</p>' )
      $('.question_rating').text("Рейтинг вопроса " + rating)
      $('.voting-question').html(linkRevote)

  # App.cable.subscriptions.create('QuestionsChannel', {
  #   connected: ->
  #     console.log 'connected!!'
  #     @perform 'follow'
  #   ,
  #
  #   received: (data) ->
  #     questionsList.append data
  # })
