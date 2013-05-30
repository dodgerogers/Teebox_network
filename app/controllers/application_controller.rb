class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :resource_name, :resource, :devise_mapping
  
  def resource_name
      :user
    end

    def resource
      @resource ||= User.new
    end

    def devise_mapping
      @devise_mapping ||= Devise.mappings[:user]
    end
    
  def after_sign_in_path_for(resource)
     questions_path
    end
  
  def after_sign_up_path_for(resource)
     questions_path
   end
  
  def after_log_out_path(resource)
    questions_path
  end 
end
