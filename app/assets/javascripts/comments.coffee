$ ->
  $(document).on 'submit', 'form.new_comment', (e) ->
    e.preventDefault()
    form = $(this)
    $.post(form.attr('action'), form.serialize(), (data) ->
      console.log data
      comment = JST['templates/comments/comment']({ comment: data })
      $('.comments').append(comment)
    )
