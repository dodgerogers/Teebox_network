class UserPresenter
  extend ActiveSupport::Memoizable
  
  def initialize(user)
    @user = user
  end
  
  def questions
    @user.questions
  end
  
  def answers
    @user.answers.includes(:question)
  end
  
  def comments
    @user.comments.includes(:commentable)
  end
  
  def new_video
    @video = Video.new
  end
  
  memoize :questions, :answers, :comments
end