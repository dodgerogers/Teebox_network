this.VideoUpdate = {
	refresh: function(){
		var startTime = new Date().getTime();
		var interval = setInterval(function(){
			if(new Date().getTime() - startTime >= 32000) {
				clearInterval(interval);
				return;
			}
			VideoUpdate.request();
		}, 10000);
	},
	request: function(){
		$.ajax({
	        url: $("#videos").data("url"),
			dataType: 'script',
	        type: 'GET'
	        //data: { after: $("#videos .videos:eq(1)").data("id") }
		});
	}
};