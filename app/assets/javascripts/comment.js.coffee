jQuery ->
  $(".new_comment").hide()
  $(".comment-button").click (event) ->
    event.preventDefault()
    $(this).next(".new_comment").toggle()

