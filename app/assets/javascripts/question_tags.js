$(function() {
var question = $('#question_tag_tokens')
  return question.tokenInput('/question_tags.json', {
	propertyToSearch: ["name"],
    resultsFormatter: function(item){ return "<li>" + "<div id='tag-explanation'><div class='tag'>" + item.name + "</div>" + " " + item.explanation + "</div></li>" },
    prePopulate: question.data('preload')
  });
});
