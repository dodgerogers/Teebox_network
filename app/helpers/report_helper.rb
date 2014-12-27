module ReportHelper
  
  ACCEPTABLE_MODELS = [
              { model: 'question', total: :questions_total },
              { model: 'answer', total: :answers_total },
              { model: 'user', total: :users_total }
          ]
          
  def display_percentage_stats(reports)
    capture do
      content_tag(:section) do
        ACCEPTABLE_MODELS.each do |record|
          concat(report_statistic_section(record, reports))
        end
      end
    end  
  end
  
  def percent_of(a, b)
    return 0.0 if a == 0 || b == 0
    ((a.to_f - b.to_f) / b.to_f * 100).round(2)
  end
  
  private
  
  def report_statistic_section(record, reports)
    content_tag(:div, class: 'report-container span3') do
      concat content_tag(:div, class: "report-title r-#{record[:model]}") { record[:model].pluralize.titleize }
      concat 'Total: '
      concat reports.last.send(record[:total])
      concat '&nbsp;'.html_safe
      concat percentage_change_div(reports, record[:total])
      concat "<br>Per day: #{reports.last.questions}&nbsp;".html_safe
      concat percentage_change_div(reports, record[:model].pluralize.to_sym)
    end
  end
  
  def percentage_change_div(reports, method_name)
    content_tag(:div, class: percentage_change_class(reports.last.send(method_name), reports[-2].send(method_name))) do
      percent_of(reports.last.send(method_name), reports[-2].send(method_name)).to_s + '%'
    end
  end
  
  def percentage_change_class(a,b)
    percent_of(a, b) < 0 ? 'decrease' : 'increase'
  end
end