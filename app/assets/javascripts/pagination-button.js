jQuery(function() {
  	var paths;
	paths = window.location.href.indexOf("users") > -1 || window.location.href.indexOf("highest_votes") > -1 || window.location.href.indexOf("unanswered") > -1;
	if ($('.pagination').length && !paths) {
    	return $('.load-questions').show().click(function(event) {
	      event.preventDefault();
	      $.getScript($('.pagination a.next_page').attr('href'));
	      $('.pagination').hide();
	      $('#loading').show();
    	});
  	}
});
