$ ->

  $fileinput = $('#show_image')

  $fileinput.fileinput
    uploadUrl: $fileinput.data('url')
    uploadAsync: true
    maxFileCount: 10
