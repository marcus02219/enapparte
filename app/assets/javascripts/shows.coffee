$ ->

  showId = $('.container.show').data('show-id')

  # new
  $('form.new_show, form.edit_show').ajaxForm
    dataType: 'json'
    success: (data)->
      window.location = '/shows/' + data.id + '/photos'

  # photos
  $fileinput = $('#show_image')
  if $fileinput.length > 0
    $fileinput.fileinput
      uploadUrl: $fileinput.data('url')
      uploadAsync: true
      maxFileCount: 10

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
  $('#cover_picture_form').ajaxForm
    type: 'PUT'
    success: (data)->
      window.location = '/shows/' + showId + '/shedules'

  # shedules
  $('#show_starts_at').change (e)->
    $("#continue").prop('disabled', false)
    $start = $('#show_starts_at')
    $end = $('#show_ends_at')
    if $start.val() > $end.val()
      $end.val($start.val())
  $('#show_ends_at').change (e)->
    $("#continue").prop('disabled', false)
    $start = $('#show_starts_at')
    $end = $('#show_ends_at')
    if $start.val() > $end.val()
      $start.val($end.val())
