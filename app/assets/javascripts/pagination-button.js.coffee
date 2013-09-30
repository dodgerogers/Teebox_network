jQuery ->
 paths = (window.location.href.indexOf("users") > -1 ||
  window.location.href.indexOf("highest_votes") > -1 ||
  window.location.href.indexOf("unanswered") > -1)
 if $('.pagination').length && !paths
	 $('.load-questions').click (event) ->
		 event.preventDefault()
		 $.getScript($('.pagination .next_page').attr('href'))
		 $('.pagination').hide()
		 $('#loading').show()
