$ ->
  $('#appointment_doctor_name').autocomplete
    source: $('#appointment_doctor_name').data('autocomplete-source')

    focus: ( event, ui ) ->
      $( "#appointment_doctor_name" ).val( ui.item.label )
      false

    select: ( event, ui ) ->
      $( "#appointment_doctor_name" ).val( ui.item.label )
      $( "#appointment_doctor_id" ).val( ui.item.value )
      false