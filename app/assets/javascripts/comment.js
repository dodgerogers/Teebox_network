jQuery(function() {
  $(".new_comment").hide();
  $(document.body).on("click", ".comment-button", function(event) {
    event.preventDefault();
    $(this).next(".new_comment").toggle();
  });
});
