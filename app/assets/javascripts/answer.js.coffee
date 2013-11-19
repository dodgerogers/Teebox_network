jQuery ->
  $('#new_answer').hide()

  $("#answer-button").click (event) ->
    event.preventDefault()
    $("#new_answer").toggle()
    if $('#answer-button').text() == "Cancel"
      $(this).text("Answer Question") 
    else
      $(this).text("Cancel")