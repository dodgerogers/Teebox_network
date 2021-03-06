class ApplicationController < ActionController::Base
  protect_from_forgery
  include PublicActivity::StoreController

  after_filter :store_location
  helper_method :resource_name, :resource, :devise_mapping
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end
  
  def store_location
    session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/
  end
  
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  
  #def after_sign_in_path_for(resource)
  #  root_path # || session[:previous_url]
  #end
 
  #def after_sign_out_path_for(resource_or_scope)
  # root_path
  #end
end
