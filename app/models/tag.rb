class Tag < ActiveRecord::Base
  
  attr_accessible :name, :explanation, :question_id, :updated_by, :user_id
  belongs_to :question
  belongs_to :user
  validates_presence_of :name, :explanation
  
end