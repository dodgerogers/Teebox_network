jQuery(function() {
  var arr = [];
  $("#notifications").click(function(event) {
    arr.push(1);
    event.stopPropagation();
	var activityArea = $('#notifications-area');
    activityArea.toggle();
	activityArea.find(".loading").show();
    if (arr.length <= 1) {
      $.ajax("/activities/notifications", {
        type: "GET",
        dataType: "html",
        timeout: 4000,
        success: function(data) {
			setTimeout(function(){
				activityArea.html(data);
			}, 300);
        },
        error: function() {
			setTimeout(function(){
				activityArea.html("<div id='notification'>Couldn't retrieve notifications, please refresh the page and try again</div>");
			}, 300);
        }
      });
    }
  });
});

$('#notifications-area').click(function(event) {
  event.stopPropagation();
});

$(document).click(function() {
  $("#notifications-area").hide();
});
