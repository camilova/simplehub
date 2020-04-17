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
  
  window.modal = (data) ->
    data = $(data)
    $('body').append(data)
    data.modal('show')

  window.destroy = (data) ->
    if $.isArray(data) is true
      data.forEach (item) ->
        $(document).find("##{item}").addClass('d-none')
    else
      $(document).find("##{data}").addClass('d-none')

  $(document).on 'click', '#items_list > li', (event) ->
    if $(event.target).is(".clickable:not('a')")
      event.preventDefault()
      a = $(this).find('a[id*=item_details_header_]')
      a.click()

  $(document).on 'hidden.bs.modal', '.modal', (event) ->
    modal = $(event.target)
    modal.remove()

  $(document).on 'ajax:success', '.modal form[data-remote=true], .modal a[data-remote=true]', (event) ->
    modal = $(event.target).closest('.modal')
    modal.modal('hide')
  
  getItem = (event) ->
    collapsable_element = $(event.target)
    item = collapsable_element.closest("li[id*='item-']")

  $(document).on 'shown.bs.collapse', '.collapse', (event) ->
    selected_items = $('li.selected').removeClass('selected')
    item = getItem(event)
    item.addClass('selected')
  
  $(document).on 'hidden.bs.collapse', '.collapse', (event) ->
    item = getItem(event)
    item.removeClass('selected')

  $(document).on 'ajax:success', '.modal-response[data-remote=true]', (event) ->
    [data, status, xhr] = event.detail
    try
      data = $(xhr.responseText)
      modal(xhr.responseText)
    catch
      return true

  $(document).on 'ajax:error', '.modal.login form[data-remote=true]', (event) ->
    [data, status, xhr] = event.detail
    form = $(event.target)
    alert_div = form.closest('.modal.login').find('.errors')
    alert_div.text(xhr.responseText).removeClass('d-none')

)(jQuery)