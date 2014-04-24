module CommentHelper
  def display_comments(object)
    # Construct the div to look for and the button text
    klass = demodularize(object).downcase
    div = "#{klass}_#{object.id}_comments"
    count = pluralize(object.comments_count, "comment")
      
    # Build the divs with correct url and div data attrs
    # Need to keep the section div even if there are no comments to avoid ajax errors
    content_tag(:div, id: div) do
		  content_tag(:section, nil) do
	      if object.comments.any?
			    (link_to "View #{count}", '#', class: "toggle-comments", data: { url: polymorphic_url(object), div: div }) +
  			  (render partial: "shared/loading", locals: { message: "comments..." })
  		  end
		  end
	  end
  end
end