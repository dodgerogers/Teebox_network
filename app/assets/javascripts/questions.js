jQuery(function() {
var question = $('#question_tag_tokens')
  return question.tokenInput('/tags.json', {
		propertyToSearch: ["name"],
    resultsFormatter: function(item){ return "<li>" + "<div class='tag' style='display:inline;color:#fff;'>" + item.name + "</div>" + " " + item.explanation + "</li>" },
    prePopulate: question.data('preload')
  });
});
