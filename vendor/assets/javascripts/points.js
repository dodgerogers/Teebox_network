// $(function(){
// 	var div = $("#points-breakdown");
// 	var id = div.data("user-id");
// 	div.find(".loading").show();
// 	$.ajax("/users/" + id + "/breakdown", {
// 		dataType: "html",
// 		timeout: 4000,
// 		success: function(data) {
// 			setTimeout(function(){
// 				div.html(data);
// 			}, 300);
// 		},
// 		error: function(data) {
// 			setTimeout(function(){
// 				div.html("Could not load points, please refresh the page and try again");
// 			}, 300);
// 		}
// 	})
// })
loadRecords("#points-breakdown", ("/users/" + $("#points-breakdown").data("user-id") + "/breakdown"), "points");