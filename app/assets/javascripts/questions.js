jQuery(function() {
  return $('#question_tag_tokens').tokenInput('/tags.json', {
    prePopulate: $('#question_tag_tokens').data('preload')
  });
});
