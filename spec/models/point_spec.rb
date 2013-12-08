require "spec_helper"

describe Point do
  before(:each) do
    @user2 = create(:user)
    @user = create(:user)
    @question = create(:question, user: @user2)
    @answer = create(:answer, user: @user, question_id: @question.id)
    @vote = create(:vote, user: @user2, votable_id: @answer.id)
    @point = create(:point, pointable_id: @vote.id)
  end
  
  subject { @point }
  
  it { should respond_to(:value) }
  it { should respond_to(:user_id) }
  it { should respond_to(:pointable_id) }
  it { should respond_to(:pointable_type) }
end

# after_create :user_reputation
# after_destroy :user_reputation
# 
# attr_accessible :value, :pointable_id, :pointable_type
# belongs_to :user
# belongs_to :pointable, polymorphic: true
# 
# def user_reputation
#   self.user.update_attributes(reputation: self.user.points.sum("value"))
# end