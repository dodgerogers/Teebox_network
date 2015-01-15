$(function() {
	if ($('.pagination a.next_page').length) {
		var button = $('.load-questions');
    	button.show();

		button.find('a').on('click', function(event) {
	    	event.preventDefault();
	    	$.getScript($('.pagination a.next_page').attr('href'));
			$("#questions-index").find(".loading").show();
	    	$('.pagination').hide();
    	});
  	}
});
