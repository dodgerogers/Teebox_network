jQuery ->
  $('#new_answer').hide()

  $("#answer-button").click (event) ->
    event.preventDefault()
    $("#new_answer").toggle()