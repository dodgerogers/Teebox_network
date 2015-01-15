module ArticleHelper  
  def valid_transition_links(article, opts={})
    separator = opts[:separator] || '&nbsp;'
    capture do
      concat transition_link_formatter(article, article.state_events, opts).join(separator).html_safe
    end
  end
  
  def article_status_bar(article)
    capture do
      content_tag(:div, class: "article-status-bar") do
        content_tag(:b) do
          concat content_tag(:i, nil, class: 'icon-file-text')
          concat "&nbsp;Status:&nbsp;".html_safe
          concat article.state.capitalize
          concat '&nbsp;- '.html_safe
			    concat (article.published_at || article.updated_at).strftime('%b %d, %Y')
		    end
	    end
    end
  end
  
  def article_cover_image(image)
   "background: url('#{image}') center center no-repeat;background-size:cover;"
  end
  
  private
  
  def transition_link_formatter(article, transitions, opts={})
    transitions.map do |state|
      if can? state, article
        link_to state, method("#{state}_article_path").call(article), 
          method: :put, class: "#{opts[:css] || nil} has-tooltip", data: { toggle: "tooltip" }, 
          title: Article.state_explanation[state], rel: 'tooltip'
      end
    end
  end
end
