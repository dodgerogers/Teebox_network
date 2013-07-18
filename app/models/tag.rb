class Tag < ActiveRecord::Base
  
  attr_accessible :name, :explanation, :updated_by, :user_id
  has_many :taggings
  has_many :questions, through: :taggings
  validates_presence_of :name
  
  def self.search(search)
    if search
      find(:all, conditions: [ 'name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end
  
  def self.tokens(query)
    tags = where("name like ?", "%#{query}%")
    if tags.empty?
      [{id: "<<<#{query}>>>", name: "New: \"#{query}\""}]
    else
      tags
    end
  end

  def self.ids_from_tokens(tokens)
    tokens.gsub!(/<<<(.+?)>>>/) { create!(name: $1).id }
    tokens.split(',')
  end
end