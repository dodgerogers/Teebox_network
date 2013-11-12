jQuery(function() {
  $(".new_comment").hide();
  return $(".comment-button").click(function(event) {
    event.preventDefault();
    return $(this).next(".new_comment").toggle();
  });
});
