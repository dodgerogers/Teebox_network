require 'active_support/concern'

module Teebox::Activity
  extend ActiveSupport::Concern
  included do
    has_many :activities, class_name: "PublicActivity::Activity", as: :trackable, dependent: :destroy
  end
end
    