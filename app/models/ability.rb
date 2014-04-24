class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new #not logged in
    
    if user.role == "admin"
      
      # Admins can do everything
      can :manage, :all
      
    elsif user.role == 'standard'
      
      # Logged in users can read pretty much everything
      
      # Questions
      can [:new, :create, :popular, :unanswered, :read, :vote, :related], Question
      can [:update, :edit, :destroy, :correct], Question do |question|
        question.try(:user) == user
      end
      
      # Answers
      can [:new, :create, :vote, :correct, :read], Answer
      can [:update, :destroy, :edit, :correct], Answer do |answer|
        answer.try(:user) == user
      end
      
      # Comments
      can [:new, :create, :vote, :index], Comment
      can [:destroy], Comment do |comment| 
        comment.try(:user) == user
      end
      
      # So we can view our own comments and comments made from other people on our content
      can [:show], Comment do |comment| 
        comment.commentable.try(:user) == user || comment.try(:user) == user
      end
      
      # Videos
      can [:new, :create], Video
      can [:destroy, :read], Video do |video|
        video.try(:user) == user
      end
      
      # Tags
      can [:read, :question_tags], Tag
      
    else
      can [:popular, :unanswered, :read, :vote, :related], Question
      can [:index], Comment
      can [:show], Answer
    end
  end
end
