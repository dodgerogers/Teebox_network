$(function() {
    var form = $('#question_video_list');
	var videos = $('.videos');
	var videosList = [];
	
	var toggleOpacity = function(element, opacity) {
		element.css('opacity', opacity);
	}
	
	var formatVideoListInput = function(){
		if (form.val()) {
			$.each(form.val().split(","), function(index, id){
				videosList.push(parseInt(id));
			});
		}
	}
	
	var persistVideoSelection = function(){
		videos.each(function(){
			if ($(this).find('.selected_video').length > 0){
				toggleOpacity($(this), '1.0');
			}
		});
	}
	
	var videoClickHandler = function(){
		videos.click(function() {
			var clickedVideo = $(this);
			var data = $(this).data("id");
			var selected = $(this).find(".selected");

			if (videosList.indexOf(data) !== -1) {
				var index = videosList.indexOf(data)

				videosList.splice(index, 1);
				toggleOpacity(clickedVideo, '0.8');
				selected.hide();
			} else {
				if (videosList.length >= 3) {
					alert("You can only add 3 videos to a question");
				} else {
					videosList.push(data);
					toggleOpacity(clickedVideo, '1.0');
					selected.show();
				}		
			} 
			form.val(videosList);
		});
	}
	
	formatVideoListInput();
	persistVideoSelection();
	videoClickHandler();
});