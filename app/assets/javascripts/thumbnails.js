$(function(){
	$(".thumbnail_select").on("click", function(event) {
		event.preventDefault();
		$("ul.thumbs li").fadeToggle();
		if ($(this).text() == "hide playlist") {
			$(this).text("view playlist");
		} else {
			$(this).text("hide playlist");
		}
	});
});