class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new #not logged in
    can [:new, :create, :read, :vote], :all
    
    #Questions
    can [:highest_votes, :unanswered], Question
    can [:update, :destroy, :edit, :create, :new], Question do |question|
      question.try(:user) == user
    end
  end
end
