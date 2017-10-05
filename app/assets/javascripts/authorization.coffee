$ ->
  $(document).ajaxError (event, xhr, ajaxOptions, thrownError) ->
    error = xhr.responseText
    $('.alert').text(error)
