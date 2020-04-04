(($) ->
  $(document).on 'click', '#items_list > li', (event) ->
    if $(event.target).is(".clickable:not('a')")
      event.preventDefault()
      a = $(this).find('a[id*=item_details_header_]')
      a.click()
)(jQuery)