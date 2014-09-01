this.VideoUpdate = {
	refresh: function(){
		setTimeout(this.request, 15000);
	},
	request: function(){
		$.ajax({
	        url: $("#videos").data("url"),
			dataType: 'script',
	        type: 'GET',
	        data: { after: $("#videos .videos:eq(1)").data("id") }
		});
	}
};
