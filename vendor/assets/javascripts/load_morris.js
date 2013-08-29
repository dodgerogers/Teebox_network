jQuery(function() {
  return Morris.Line({
    element: 'area',
    data: $('#area').data('totals'),
    xkey: 'created_at',
    ykeys: ['questions_total', 'answers_total','users_total'],
    labels: ['Total Questions', 'Total Answers','Total Users'],
	behaveLikeLine: "true",
	hideHover: "auto"
  });
});