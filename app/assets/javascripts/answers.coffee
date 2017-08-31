$ ->
  $('body').on 'click', '.edit-answer-link', (e) ->
    answerId =  $(this).parents('.answer-wrapper').data('answerId');
    $('form#edit_answer_'+ answerId).show();
    e.preventDefault();
    $(this).hide();

  $(document).on 'click', '.revote-answer', (e) ->
    e.preventDefault()
    answer_id = $(this).data('answerId');
    question_id = $(this).data('questionId');
    voteRequest("/questions/#{question_id}/answers/#{answer_id}/revote", "", "DELETE")

  $(document).on 'click', '.link-up-vote-answer', (e) ->
    e.preventDefault();
    answer_id = $(this).data('answerId');
    question_id = $(this).data('questionId');
    voteRequest("/questions/#{question_id}/answers/#{answer_id}/up_vote",
      "Вы успешно проголосовали за ответ", "POST")

  $(document).on 'click', '.link-down-vote-answer', (e) ->
    e.preventDefault();
    answer_id = $(this).data('answerId');
    question_id = $(this).data('questionId');
    voteRequest("/questions/#{question_id}/answers/#{answer_id}/down_vote",
      "Вы успешно проголосовали против ответа", "POST")

  voteRequest = (url, text, type) ->
    $.ajax
      url: url
      type: type
      success: (data) ->
        answer = data.votable
        answerWrapper = ".answer-wrapper[data-answer-id=#{answer.id}]"
        linksVote = JST['templates/answers/links_to_vote']({ answer: answer, question_id: answer.question_id })
        linkRevote = JST['templates/answers/link_revote']({ answer: answer, question_id: answer.question_id })
        $(answerWrapper + "> .answer-rating").text("Рейтинг ответа " + data.rating)
        $( ".notice" ).html( '<p>'+text+'</p>' );
        if type == "DELETE"
          $(answerWrapper + "> .voting-answer").html(linksVote)
        else
          $(answerWrapper + " > .voting-answer").html(linkRevote)

  if $('.question-wrapper').length == 1
    App.cable.subscriptions.create { channel: 'AnswersChannel', question_id: $('.question-wrapper').data('questionId')},
      connected: ->
        @perform 'follow'
      received: (data) ->
        if ( gon.current_user == undefined or gon.current_user.id != data.author.id )
          answerBlock = JST['templates/answers/answer']({ answer: data.answer, question: data.question
          rating: data.answer_rating, attachments: data.attachments, user: gon.current_user, author: data.author })
          $('.answers').append(answerBlock)
