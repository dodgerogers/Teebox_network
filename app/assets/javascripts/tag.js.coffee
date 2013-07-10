jQuery ->
	$('#toggle_tag_form').click (event) ->
		event.preventDefault()
		$('#tag_form').toggle()