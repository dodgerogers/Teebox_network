jQuery ->
  url = (window.location.href.indexOf("users") > -1 ||
  window.location.href.indexOf("highest_votes") > -1 ||
	 window.location.href.indexOf("unanswered") > -1)
  if $('.pagination').length && !url
    $(window).scroll ->
      url = $('.pagination .next_page').attr('href')
      if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
        $('.pagination').html($("#loading").show())
        $.getScript(url)
    $(window).scroll()