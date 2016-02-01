$ ->

  $fileinput = $('#show_image')

  $fileinput.fileinput
    uploadUrl: $fileinput.data('url')
    uploadAsync: true
    maxFileCount: 10


  # check photos count
  $fileinput.on 'fileuploaded filedeleted', (e)->
    showId = $fileinput.data('show-id')
    $
      .get '/shows/' + showId + '/pictures_count'
      .success (data)->
        if parseInt(data) > 0
          $("button#continue").prop('disabled', false)
        else
          $("button#continue").prop('disabled', true)


