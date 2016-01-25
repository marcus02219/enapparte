$ ->

  $('.dashboard .btn-upload input').change (e)->
    $form = $(this).parents("form:first")
    $form.ajaxSubmit
      beforeSubmit: ->
        $form.prev().html('<i class="glyphicon glyphicon-refresh glyphicon-refresh-animate"></i> Uploading...')
      success: (data)->
        $form.prev().html('Change')
        $('.dashboard.profile .photo img').prop('src', data.image)

  # addresses
  $('.dashboard .form_addresses select').append("<option value='0'>#{I18n.dashboard.add_new_address}</option>")
  if $('.dashboard .form_addresses .address.has_errors').size() > 0
    $('.dashboard .form_addresses .address.has_errors').removeClass('hide')
    $('.dashboard .form_addresses select option[value=0]').prop('selected', true)
  else
    $('.dashboard .form_addresses select').change (e)->
      $('.dashboard .form_addresses .address').addClass('hide')
      $('.dashboard .form_addresses .address[data-id=' + this.value + ']').removeClass('hide')
    $('.dashboard .form_addresses select').change()

