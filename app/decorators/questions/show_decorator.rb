class Questions::ShowDecorator < Draper::Decorator
  delegate_all
  decorates :question
  include Draper::LazyHelpers
  
  def question_tags
    raw model.tags.map(&:attributes).map {|tag| link_to tag["name"], tagged_path(tag["name"]), class: "tag" }.join(" ")
  end
  
  def related_questions
    Question.text_search(model.title).includes(:user).limit(7).reject { |n| n == model }
  end
end