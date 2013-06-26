class UserDecorator < ApplicationDecorator
  delegate_all
  decorate :user
  include Draper::LazyHelpers
  
  def change_picture
    link_to "Change your profile picture", "http://grvatar.com", target: :blank if current_user == model
  end
   
  def my_videos
    link_to "My Videos", videos_path, class: "default next" if current_user == model
  end
  
  def render_partial(partial, user_objects)
    render partial: "users/#{partial}", locals: {objects: user_objects, user: model } if user_objects.any?
  end
  
  def questions
    model.questions.limit(6)
  end
  
  def answers
    model.answers.includes(:question).limit(6)
  end
  
  def comments
    model.comments.includes(:commentable).limit(6)
  end
  
  def new_video
    @video = Video.new
  end
end
