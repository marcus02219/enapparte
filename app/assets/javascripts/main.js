$(document).ready( function(){
  'use strict';
  $('nav[role="navigation"]').on('shown.bs.collapse',function(){
    $('#dropdownMenu1').trigger('click');
  });

  $('.modal').on('show.bs.modal', function() {
    $('.flash-messages .alert').alert('close');
  });
  $('#datetimepickersearchhome').datetimepicker({
    format: "DD/MM/YYYY"
  });
});



