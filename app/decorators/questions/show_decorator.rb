class Questions::ShowDecorator < ApplicationDecorator
  delegate_all
  decorate :question
  include Draper::LazyHelpers
  
  def question_tags
    raw model.tags.map(&:attributes).map {|tag| link_to tag["name"], tagged_path(tag["name"]), class: "tag" }.join(" ")
  end
  
  def sublime_player
    raw sublime_video(model.video.file, model.video.id) if model.video.present?
  end
  
  def youtube_player
    raw youtube_url_html5(model.youtube_url) if model.youtube_url.present? 
  end
  
  def related_posts(question)
    Question.find(:all, conditions: [ 'title LIKE ?', "%#{question.title}%"], limit: 10) - [question]
  end
end