this.VideoUpdate = {
	refresh: function(video_id){
		$.ajax({
	        url: $("#videos").data("url"),
			dataType: 'script',
	        type: 'GET',
	        data: { after: video_id }
		});
	}
};
