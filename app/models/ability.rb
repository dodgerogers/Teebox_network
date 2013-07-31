class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new #not logged in
    
    if user.role == "admin"
      can :manage, :all
    elsif user.role == 'standard'
      can [:read, :vote], :all
      #Questions
      can [:new, :create, :highest_votes, :unanswered], Question
      can [:update, :edit, :destroy], Question do |question|
        question.try(:user) == user
    end
      #Answers
      can [:new, :create], Answer
      can [:update, :destroy, :edit, :correct], Answer do |answer|
        answer.try(:user) == user
    end
      #Comments
      can [:new, :create], Comment
      can [:destroy], Comment do |comment|
        comment.try(:user) == user
    end
      #videos
      can [:new, :create], Video
      can [:destroy], Video do |video|
        video.try(:user) == user
      end
    else
      can [:read, :vote], :all
      can [:highest_votes, :unanswered], Question
    end
  end
end
