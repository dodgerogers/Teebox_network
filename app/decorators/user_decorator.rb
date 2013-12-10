class UserDecorator < ApplicationDecorator
  delegate_all
  decorates :user
  include Draper::LazyHelpers
  
  def points_activity
    @points ||= model.points.where("value != 0").order("updated_at desc").includes(:pointable).paginate(page: params[:page], per_page: 6)
  end
  
  def change_picture
    link_to raw('<i class="icon-cloud-upload"></i>'), "http://gravatar.com", title: "Change your profile picture", target: :blank if current_user == model
  end
  
  def link_helper(text, path, objects)
    link_to "View all #{text}", path, class: "default next" if objects.any?
  end
  
  def questions_index
    model.questions.includes(:answers).order("created_at desc")
  end
  
  def answers_index
    model.answers.includes(:question).order("created_at desc")
  end
  
  def comments_index
    model.comments.includes(:commentable).order("created_at desc")
  end
end
