$(function() {
	var question = $("#question-box").data("id");
	var loadArea = $("#load-related");
	$("#loading").show();
    $.ajax("/questions/" + question + "/related", {
		dataType: "html",
		timeout: 4000,
		success: function(data) {
			setTimeout(function(){
				loadArea.html(data);
			}, 300);
		},
		error: function() {
			setTimeout(function(){
				loadArea.html("<h4>Could not load related questions</h4>");
			}, 300);	
		}
	});
});