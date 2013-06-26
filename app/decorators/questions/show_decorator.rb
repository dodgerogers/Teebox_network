class Questions::ShowDecorator < ApplicationDecorator
  delegate_all
  decorate :question
  include Draper::LazyHelpers
  
  def question_tags
    raw model.tags.map(&:attributes).map {|tag| link_to tag["name"], tagged_path(tag["name"]), class: "tag" }.join(" ")
  end
end