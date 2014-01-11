class UserDecorator < ApplicationDecorator
  delegate_all
  decorates :user
  include Draper::LazyHelpers
  
  def change_picture
    link_to raw('<i class="icon-cloud-upload"></i>'), "http://gravatar.com", title: "Change your profile picture", target: :blank if current_user == model
  end
  
  def link_helper(text, path, objects)
    link_to "View all #{text}", path, class: "default next" if objects.any?
  end
end
