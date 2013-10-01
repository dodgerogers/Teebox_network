jQuery ->
  arr = []
  $("#notifications").click (e) ->
    arr.push(1)
    e.stopPropagation()
    $('#notifications-area').toggle()
    if arr.length <= 1
     $.get("/activities/notifications", (data) ->
          $("#notifications-area").html data )

$('#notifications-area').click (e) ->
	e.stopPropagation()
	
$(document).click ->
	$("#notifications-area").hide()