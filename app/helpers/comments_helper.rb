module CommentsHelper
  def nested_comments(comments)
    comments.map do |comment, sub_comments|
      content_tag(:div, render(comment), id: comment.id)
    end.join.html_safe
  end
end