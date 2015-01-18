module ArticleHelper  
  PAIR_ARTICLE_SEQUENCE = Proc.new {|n| (-3 - (-1)**n + 4 * n) / 2 }
  COL_SEVEN_WIDTH = 'col-md-7 col-sm-7'
  COL_FIVE_WIDTH = 'col-md-5 col-sm-5'
  NBSP = '&nbsp;'
  
  def valid_transition_links(article, opts={})
    separator = opts[:separator] || NBSP
    capture do
      concat transition_link_formatter(article, article.state_events, opts).join(separator).html_safe
    end
  end
  
  def article_sequence_formatter(count, size)
    sequence = (0..size).map {|n| PAIR_ARTICLE_SEQUENCE.call(n) }
    sequence.include?(count) ? COL_SEVEN_WIDTH : COL_FIVE_WIDTH
  end
  
  def article_status_bar(article)
    capture do
      content_tag(:div, class: "article-status-bar") do
        content_tag(:b) do
          concat content_tag(:i, nil, class: 'icon-file-text')
          concat (NBSP + 'Status' + NBSP).html_safe
          concat article.state.capitalize
          concat (NBSP + '-' + NBSP).html_safe
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
