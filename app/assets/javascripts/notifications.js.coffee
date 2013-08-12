jQuery ->
  arr = []
  $("#notifications").click ->
    arr.push(1)
    if arr.length <= 1
     $.get("/activities/notifications", (data) ->
           $("#notifications-area").html data )
