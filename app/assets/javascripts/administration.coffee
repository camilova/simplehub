(($) ->
  window.modal = (data) ->
    data = $(data)
    $('body').append(data)
    data.modal('show')
)(jQuery)