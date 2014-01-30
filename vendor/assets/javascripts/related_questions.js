// $(function() {
// 	var id = $("#question-box").data("id");
// 	var loadArea = $("#load-related");
// 	loadArea.find(".loading").show();
//     $.ajax("/questions/" + id + "/related", {
// 		dataType: "html",
// 		timeout: 4000,
// 		success: function(data) {
// 			setTimeout(function(){
// 				loadArea.html(data);
// 			}, 300);
// 		},
// 		error: function() {
// 			setTimeout(function(){
// 				loadArea.html("<h4>Could not load related questions</h4>");
// 			}, 300);	
// 		}
// 	});
// });
loadRecords("#load-related", ("/questions/" + $("#question-box").data("id") + "/related"), "related questions");