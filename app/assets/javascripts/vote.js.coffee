$("a#vote").click ->
  url = @href
  $.post url


$ ->
  vote = $('#vote-box').text
  if vote < 0
    vote.css('color', 'red')