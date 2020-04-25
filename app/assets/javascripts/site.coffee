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

  window.move = (data) ->
    element = $("##{data.id}")
    element.find('.collapse').collapse('hide')
    direction = data.direction
    switch direction
      when 'up'
        prev = element.prev("#{element.prop('tagName')}:not(.new)")
        if prev.length > 0
          element.fadeOut 250, ->
            element.insertBefore(prev)
            element.fadeIn()
      when 'down'
        next = element.next("#{element.prop('tagName')}:not(.new)")
        if next.length > 0
          element.fadeOut 250, ->
            element.insertAfter(next)
            element.fadeIn()

  $(document).on 'click', '#items_list li', (event) ->
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

  $(document).on 'show.bs.collapse', '#collapse_category', (event) ->
    $('#items_container').fadeOut()
    $('.category-toggle').removeClass('fa-chevron-down').addClass('fa-chevron-up')

  $(document).on 'hide.bs.collapse', '#collapse_category', (event) ->
    $('#items_container').fadeIn()
    $('.category-toggle').removeClass('fa-chevron-up').addClass('fa-chevron-down')

)(jQuery)