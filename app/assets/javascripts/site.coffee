(($) ->

  window.replace = (data) ->
    data = $(data)
    container = $("li##{data.attr('id')}")
    ['class', 'style', 'data'].forEach (attribute) ->
      container.attr(attribute, data.attr(attribute))
    container.html(data.html())

  $(document).on 'click', '#items_list > li', (event) ->
    if $(event.target).is(".clickable:not('a')")
      event.preventDefault()
      a = $(this).find('a[id*=item_details_header_]')
      a.click()

  $(document).on 'hidden.bs.modal', '.modal', (event) ->
    modal = $(event.target)
    modal.remove()

  $(document).on 'ajax:success', '.modal form[data-remote=true]', (event) ->
    modal = $(event.target).closest('.modal')
    modal.modal('hide')

)(jQuery)