class UserDecorator < ApplicationDecorator
  delegate_all
  decorate :user
  include Draper::LazyHelpers
  
  def change_picture
    link_to "Change your profile picture", "http://gravatar.com", target: :blank if current_user == model
  end
   
  def my_videos
    link_to "My Videos", videos_path, class: "default next" if current_user == model
  end
  
  def link_helper(text, path, objects)
    link_to "View all #{text}", path, class: "default next" if objects.any?
  end
  
  def questions
    model.questions
  end
  
  def answers
    model.answers.includes(:question)
  end
  
  def comments
    model.comments.includes(:commentable)
  end
  
  def new_video
    @video = Video.new
  end
end
