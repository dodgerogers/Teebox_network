$(function() {
    var form = $('#question_video_list');
	var video = $('.videos');
	var videosList = [];
	// Only add the elements from the form to the array if present
	if (form.val()) {
		$.each(form.val().split(","), function(index, id){
			videosList.push(parseInt(id));
		});
	}
	// Click handler, add id of video to array, toggle selected div, then add the array to the forms value
	video.click(function() {
		var data = $(this).data("id");
		var selected = $(this).find(".selected");
		if (videosList.indexOf(data) !== -1) {
			var index = videosList.indexOf(data)
			videosList.splice(index, 1);
			selected.fadeOut(100);
		} else {		
			videosList.push(data);
			selected.fadeIn(100);
		} 
		form.val(videosList);
		console.log(form.val());
	});
});