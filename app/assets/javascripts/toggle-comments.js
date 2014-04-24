$(function(){
	$(document).on("click", ".toggle-comments", function(event){
		event.preventDefault();
		
		// Set some variables and construct div
		var url = $(this).data("url");
		var div = $("#" + $(this).data("div"));
		var comments = "/comments";
		
		// First we'll hide the .toggle-comments button and then show the loading gif
		$(this).hide();
		div.find(".loading").fadeIn();
		
		// Then fetch the objects comments via the contructed URL
		$.ajax(url + comments, {
			type: "GET",
			timeout: 5000,
			success: function(data) {
				setTimeout(function(){
					// Replace the whole section to avoid duplicate comments when toggling after creation
					div.find("section").html(data);
					div.find(".toggle-comments").hide();
					div.find(".loading").hide();
				}, 1000);	
			},
			error: function(data) {
				setTimeout(function(){
					div.prepend("Could not load comments, please refresh the page and try again");
					div.find(".loading").hide();
				},1000);
			}
		});
	});
});