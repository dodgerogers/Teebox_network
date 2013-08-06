class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new #not logged in
    
    if user.role == "admin"
      can :manage, :all
    elsif user.role == 'standard'
      #Questions
      can [:new, :create, :highest_votes, :unanswered, :read, :vote], Question
      can [:update, :edit, :destroy, :correct], Question do |question|
        question.try(:user) == user
    end
      #Answers
      can [:new, :create, :read, :vote, :correct], Answer
      can [:update, :destroy, :edit, :correct], Answer do |answer|
        answer.try(:user) == user
    end
      #Comments
      can [:new, :create, :read, :vote], Comment
      can [:destroy], Comment do |comment|
        comment.try(:user) == user
    end
      #Videos
      can [:new, :create], Video
      can [:destroy], Video do |video|
        video.try(:user) == user
      end
    else
      can [:highest_votes, :unanswered, :read, :vote], Question
    end
  end
end
