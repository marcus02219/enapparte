$ ->

  $('.dashboard.profile .btn-upload input').change (e)->
    $form = $(this).parents("form:first")
    $form.ajaxSubmit
      beforeSubmit: ->
        $form.prev().html('<i class="glyphicon glyphicon-refresh glyphicon-refresh-animate"></i> Uploading...')
      success: (data)->
        $form.prev().html('Change')
        $('.dashboard.profile .photo img').prop('src', data.image)

