class ApplicationController < ActionController::Base
  protect_from_forgery

  after_filter :store_location
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
    
    def store_location
      session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/
    end
    
    def after_sign_in_path_for(resource)
      session[:previous_url] || root_path
    end
   
    def after_sign_out_path_for(resource_or_scope)
     request.referrer
   end
   
   def paginate_object(object, pages)
     object.paginate(page: params[:page], per_page: pages)
   end
end
