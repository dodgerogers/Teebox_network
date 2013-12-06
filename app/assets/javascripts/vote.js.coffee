$("a#vote").click ->
  url = @href
  $.post url