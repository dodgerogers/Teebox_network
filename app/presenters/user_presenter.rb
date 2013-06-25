class UserPresenter
  
  def initialize(user)
    @user = user
  end
  
  def questions
    @questions ||= @user.questions
  end
  
  def answers
    @answers ||= @user.answers.includes(:question)
  end
  
  def comments
    @comments ||= @user.comments.includes(:commentable)
  end
  
  def new_video
    @video = Video.new
  end
end