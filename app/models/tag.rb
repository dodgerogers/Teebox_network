class Tag < ActiveRecord::Base
  
  attr_accessible :name, :explanation, :updated_by, :user_id
  has_many :taggings
  has_many :questions, through: :taggings
  validates :name, presence: true, uniqueness: true, length: { maximum: 100, minimum: 2}
  
  validates :name, obscenity: true
  validates :explanation, obscenity: true 
  
  include PgSearch
  pg_search_scope :search, against: [:name, :explanation], 
    using: { tsearch: { prefix: true, 
                        dictionary: "english", 
                        any_word: true } }
  
  def self.text_search(query)
    if query.present?
      search(sanitize(query))
    else
      scoped
    end
  end
  
  def self.cloud
    self.joins(:taggings).select('tags.*, count(tag_id) as "tag_count"').group("tags.id").order('tag_count desc')
  end
  
  def self.tokens(query)
    tags = where("name ilike ?", "%#{query}%")
    if tags.empty?
      [{id: "<<<#{query}>>>", name: "New: \"#{query}\""}]
    else
      tags
    end
  end

  def self.ids_from_tokens(tokens) 
    tokens.gsub!(/<<<(.+?)>>>/) { create!(name: $1).id }
    tokens.split(',')
    rescue
  end
end