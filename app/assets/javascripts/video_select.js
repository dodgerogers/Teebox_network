jQuery(function() {
    var form = $('#question_video_id');
	var video = $('.videos');
	var icon = $('.selected');
	video.click(function() {
		icon.hide();
  		form.val(form.val() == $(this).data("id") ? 0 : ($(this).data("id"))); 
		form.val() == $(this).data("id") ? $(this).find('.selected').fadeIn(100) : $(this).find('.selected').fadeOut(100);
	});
});