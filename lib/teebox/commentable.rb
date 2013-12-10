require 'active_support/concern'

module Teebox::Commentable
  extend ActiveSupport::Concern
  included do
    before_filter :comments
  end

  def comments
    @comment = Comment.new
  end
end