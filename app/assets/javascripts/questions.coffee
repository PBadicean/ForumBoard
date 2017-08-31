$ ->
  $(document).on 'click', '.edit-question-link', (e) ->
    e.preventDefault();
    $(this).hide();
    $('form.edit_question').show();

  $(document).on 'click', '.revote', (e) ->
    e.preventDefault()
    id = $(this).data('questionId');
    voteRequest("/questions/#{id}/revote", "", "DELETE")

  $(document).on 'click', '.link-up-vote', (e) ->
    e.preventDefault();
    id = $(this).data('questionId');
    voteRequest("/questions/#{id}/up_vote",
      "Вы успешно проголосовали за вопрос", "POST")

  $(document).on 'click', '.link-down-vote', (e) ->
    e.preventDefault();
    id = $(this).data('questionId');
    voteRequest("/questions/#{id}/down_vote",
      "Вы успешно проголосовали против вопроса", "POST")

  voteRequest = (url, text, type) ->
    $.ajax
      url: url
      type: type
      success: (data) ->
        linksVote = JST['templates/questions/links_to_vote']({ votable: data.votable })
        linkRevote = JST['templates/questions/link_revote']({ votable: data.votable })
        $('.question-rating').text("Рейтинг вопроса " + data.rating)
        $( ".notice" ).html( '<p>'+text+'</p>' )
        if type == "DELETE"
          $('.voting-question').html(linksVote)
        else
          $('.voting-question').html(linkRevote)

  App.cable.subscriptions.create('QuestionsChannel', {
    connected: ->
      @perform 'follow',
    received: (data) ->
      $('.questions-list').append data
  })
