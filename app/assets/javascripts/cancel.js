$(function() {
  $(document.body).on("click", ".cancel", function(event) {
    event.preventDefault();
	$(this).closest("form").hide().find('.wysihtml5-sandbox').contents().find('body').html('');
  });
});