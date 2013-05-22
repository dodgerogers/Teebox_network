$ ->
  $('#new_answer').hide()
		$("#answer_body").val("");

  $("#answer-button").click (event) ->
  	event.preventDefault()
	  $("#new_answer").toggle()