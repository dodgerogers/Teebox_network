$(function() {
	if ($('.pagination a.next_page').length) {
    	$('.load-questions').show().click(function(event) {
	    	event.preventDefault();
	    	$.getScript($('.pagination a.next_page').attr('href'));
			$("#questions-index").find(".loading").show();
	    	$('.pagination').hide();
    	});
  	}
});
