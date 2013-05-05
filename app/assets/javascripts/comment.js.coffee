jQuery ->
  $('#new_comment').hide()

  $("#comment-button").click (event) ->
  	event.preventDefault()
	  $("#new_comment").toggle()
		