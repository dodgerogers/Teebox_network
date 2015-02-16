class Questions::ShowDecorator < Draper::Decorator
  delegate_all
  decorates :question
  include Draper::LazyHelpers
  
  def question_tags
    raw model.tags.map {|tag| link_to tag.name, tagged_path(tag.name) }.join(", ")
  end
  
  def related_questions
    Question.search(model.title).limit(5).reject { |n| n == model }
  end
end