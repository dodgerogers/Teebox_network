this.VideoUpdate = {
	refresh: function(){
		setTimeout(this.request, 15000);
	},
	request: function(){
		$.ajax({
	        url: $("#videos").data("url"),
			dataType: 'script',
	        type: 'GET',
			// We fetch the second video data id attribute, so we can refresh the latest video 
	        data: { after: $("#videos .videos:eq(1)").data("id") }
		});
	}
};
