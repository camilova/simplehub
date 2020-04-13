(($) ->

  window.replace = (data) ->
    data = $(data)
    container = $("li##{data.attr('id')}")
    ['class', 'style', 'data'].forEach (attribute) ->
      container.attr(attribute, data.attr(attribute))
    container.html(data.html())

  window.prepend = (data, list) ->
    data = $(data)
    list.first().prepend(data)

  window.prependSource = (data) ->
    data = $(data)
    parent = $("##{data.data('parent')}")
    list = parent.find('.sources-list')
    prepend(data, list)
  
  window.prependSubitem = (data) ->
    data = $(data)
    parent = $("##{data.data('parent')}")
    list = parent.find('.subitems-list')
    prepend(data, list)
  
  window.prependItem = (data) ->
    data = $(data)
    list = $('#items_list')
    prepend(data, list)

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
  
  getItem = (event) ->
    collapsable_element = $(event.target)
    item = collapsable_element.closest("li[id*='item-']")

  $(document).on 'shown.bs.collapse', '.collapse', (event) ->
    item = getItem(event)
    item.addClass('selected')
  
  $(document).on 'hidden.bs.collapse', '.collapse', (event) ->
    item = getItem(event)
    item.removeClass('selected')

)(jQuery)