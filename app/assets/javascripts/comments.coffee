$ ->
  $(document).on 'submit', 'form.new_comment', (e) ->
    e.preventDefault()
    form = $(this)
    $.post(form.attr('action'), form.serialize(), (data) ->
      $('.new_comment #comment_body').val('')
      form.find('input[type="submit"]').removeAttr('disabled')
      comment = JST['templates/comments/comment']({ comment: data })
      $('.comments').append(comment)
    ).fail( (error) ->
      error = $.parseJSON(error.responseText)['body'][0]
      form.find('.comment-errors').html('<p class="alert alert-danger">'+ error + '</p>')
      form.find('input[type="submit"]').removeAttr('disabled')
    )

  if $('.question-wrapper').length == 1
    App.cable.subscriptions.create {
      channel: 'CommentsChannel', question_id: $('.question-wrapper').data('questionId')
    },
    connected: ->
      @perform 'follow'
    received: (data) ->
      if ( gon.current_user == undefined ) or ( gon.current_user.id != data.author.id)
        console.log data
        comment = JST['templates/comments/comment']({ comment: data.comment })
        $(".comments").append(comment)
