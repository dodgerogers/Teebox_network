jQuery(function() {
  var arr = [];
  $("#notifications").click(function(event) {
    arr.push(1);
    event.stopPropagation();
    $('#notifications-area').toggle();
	$("#load-notifications").show();
    if (arr.length <= 1) {
      $.ajax("/activities/notifications", {
        type: "GET",
        dataType: "html",
        timeout: 4000,
        success: function(data) {
		// Not sure if this is a good idea yet...
			setTimeout(function(){
				$("#notifications-area").html(data);
			}, 300);
        },
        error: function() {
          $("#notifications-area").html("<div id='notification'>Couldn't retrieve notifications, please refresh the page and try again</div>");
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
