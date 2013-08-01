jQuery ->
  Morris.Line
    element: 'stats'
    data: $('#stats').data('reports')
    xkey: 'created_at'
    ykeys: ['questions', 'answers', 'users']
    labels: ['New Questions', 'New Answers', 'New Users']