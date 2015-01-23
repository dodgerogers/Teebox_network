module ArticleHelper  
  COLUMN_WIDTHS = [8, 4]
  MAX = 12
  NBSP = '&nbsp;'
  
  def valid_transition_links(article, opts={})
    separator = opts[:separator] || NBSP
    capture do
      concat transition_link_formatter(article, article.state_events, opts).join(separator).html_safe
    end
  end
  
  def column_sequencer(size)
    result = {}
    count = 0
    
    (0..size-1).map.each do |int|
      current_width = COLUMN_WIDTHS.sample
      if (int == size-1)
        result[int] = (count == MAX || count == 0) ? MAX : (MAX - count)
      elsif (current_width + count) < MAX
        result[int] = current_width
        count += current_width
      elsif (current_width + count) == MAX
        result[int] = current_width
        count = 0  
      elsif (current_width + count > MAX) || (current_width == MAX)
        result[int] = (MAX - count)
        count = 0
      end
    end
    return result
  end
  
  def sequencer_class(count)
    return "col-md-#{count} col-sm-#{count}"
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
      if can? state.to_sym, article
        link_to state, method("#{state}_article_path").call(article), 
          method: :put, class: "#{opts[:css] || nil} has-tooltip", data: { toggle: "tooltip" }, 
          title: Article.state_explanation[state], rel: 'tooltip'
      end
    end
  end
end
