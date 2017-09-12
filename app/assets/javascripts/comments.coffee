$ ->
  $(document).on 'click', '.comments-link', (e) ->
    e.preventDefault()

    if $(this).hasClass('cancel')
      $(this).html('Комментарии')
    else
      $(this).html('Закрыть')

    $(this).toggleClass('cancel')
    $(this).next().toggle()
    $(this).nextAll('form#new_comment').toggle()

  $(document).on 'submit', 'form.new_comment', (e) ->
    e.preventDefault()
    form = $(this)

    $.post(form.attr('action'), form.serialize(), (data) ->
      form.find('.comment-errors').html('')
      form.prev().append( JST['templates/comments/comment']({ comment: data }))
      form.find('input[type="submit"]').removeAttr('disabled')
      $('.new_comment #comment_body').val('')
    'json').fail( (error) ->
      $.each $.parseJSON(error.responseText)['errors'], (index, value) ->
        error = (index + " " + value)
        form.find('.comment-errors').html('<p class="alert alert-danger">'+ error + '</p>')
      form.find('input[type="submit"]').removeAttr('disabled')
    'json')


  if $('.question-wrapper').length == 1
    App.cable.subscriptions.create {
      channel: 'CommentsChannel', question_id: $('.question-wrapper').data('questionId')
    },
    connected: ->
      @perform 'follow'
    received: (data) ->
      if ( gon.current_user == undefined ) or ( gon.current_user.id != data.author.id)
        comment = JST['templates/comments/comment']({ comment: data.comment })
        type = data.comment.commentable_type.toLowerCase()
        id = data.comment.commentable_id
        $(".#{type}-comments[data-id='#{id}']").append(comment)
