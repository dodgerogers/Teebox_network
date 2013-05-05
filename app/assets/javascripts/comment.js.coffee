jQuery ->
  $('#new_comment').hide()

jQuery ->
  $("#comment-button").click (event) ->
  	event.preventDefault
	  $("#new_comment").toggle(500)