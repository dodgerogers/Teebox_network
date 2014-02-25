jQuery(function() {
  $('#new_answer').hide();
  return $("#answer-button").click(function(event) {
    event.preventDefault();
    $("#new_answer").toggle();
    if ($('#answer-button').text() === "Cancel") {
      return $(this).text("Answer Question");
    } else {
      return $(this).text("Cancel");
    }
  });
});
