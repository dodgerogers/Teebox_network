class Tag < ActiveRecord::Base
  
  attr_accessible :name, :explanation, :updated_by, :user_id
  has_many :taggings
  has_many :questions, through: :taggings
  validates_presence_of :name
  
  include PgSearch
  pg_search_scope :search, against: [:title, :body], 
    using: { tsearch: { dictionary: "english" } }
  
  def self.search(query)
    if query.present?
      rank = <<-RANK
        ts_rank(to_tsvector(name), plainto_tsquery(#{sanitize(query)}))
        RANK
      where('name @@ :q or explanation @@ :q', q: query).order("#{rank} desc")
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