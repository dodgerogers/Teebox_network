module SearchHelper
  def render_search_results(results, opts={})
    total, text = opts.values_at(:total, :text)
    
    capture do
      concat content_tag(:h2, "Search Results for '#{text}'")
      concat '<hr>'.html_safe
      
      if total == 0 
			  concat content_tag(:p, "Nothing found")
		  else
			  results.each do |collection, records|
				  if records.any? 
					  concat(content_tag(:section, id: "#{collection}-index", data: { key: collection }) do 
					    concat(content_tag(:div) do
							  display_results(records, text: text, hide_options: true) 
					    end)
					    
					    concat(content_tag(:table, class: "table table-bordered #{collection}-index") do
								 render records 
							end)
						end)
						
						concat(content_tag(:div, class: 'col-md-12') do
						  concat(content_tag(:div, class: 'text-center', id: 'pagination') do
						    concat will_paginate records, param_name: "#{collection}_page"
						    concat content_tag(:hr, nil)
						  end)
						end)
				  end
				end 
			end 
		end 
  end
end