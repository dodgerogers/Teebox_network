var loadRecords = function(div, url, message){
	$(div).find(".loading").show();
	$.ajax(url, {
		dataType: "html",
		timeout: 6000,
		success: function(data) {
			setTimeout(function(){
				$(div).html(data);
			}, 300);
		},
		error: function(data) {
			setTimeout(function(){
				$(div).html("Could not load " + message + ", please refresh the page and try again");
			}, 300);
		}
	})
}