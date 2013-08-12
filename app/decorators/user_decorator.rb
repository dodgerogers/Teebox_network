class UserDecorator < ApplicationDecorator
  delegate_all
  decorate :user
  include Draper::LazyHelpers
  
  def change_picture
    link_to raw('<i class="icon-cloud-upload"></i>'), "http://gravatar.com", title: "Change your profile picture", target: :blank if current_user == model
  end
   
  def my_videos
    link_to "My Videos", videos_path, class: "default next" if current_user == model
  end
  
  def link_helper(text, path, objects)
    link_to "View all #{text}", path, class: "default next" if objects.any?
  end
  
  def questions_index
    model.questions.order("created_at desc")
  end
  
  def answers_index
    model.answers.includes(:question).order("created_at desc")
  end
  
  def comments_index
    model.comments.includes(:commentable).order("created_at desc")
  end
  
  def new_video
    @video = Video.new
  end
end
