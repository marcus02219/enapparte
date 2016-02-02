$ ->

  $fileinput = $('#show_image')

  if $fileinput.length > 0
    $fileinput.fileinput
      uploadUrl: $fileinput.data('url')
      uploadAsync: true
      maxFileCount: 10

    showId = $fileinput.data('show-id')

    $("#continue").on 'click', (e)->
      window.location = $(this).data('href')

    # check photos count
    $fileinput.on 'fileuploaded', (e)->
      $
        .get '/shows/' + showId + '/pictures_count'
        .success (data)->
          if parseInt(data) > 0
            $("#continue").prop('disabled', false)

    $fileinput.on 'filedeleted', (e)->
      $
        .get '/shows/' + showId + '/pictures_count'
        .success (data)->
          if parseInt(data) == 0
            $("#continue").prop('disabled', true)

  # cover picture
  $('#cover_picture_form').submit ()->
    $(this).ajaxSubmit
      success: (data)->
        console.log data
    false

