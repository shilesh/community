class ApplicationController < ActionController::Base

    protect_from_forgery with: :exception

    def current_user
      if session[:user_id]
        @current_user ||= Admin.find(session[:user_id])
      end
    end
  
    helper_method :current_user
  
    def authenticate_user!
      unless current_user
        redirect_to new_login_path, notice: "Please log in"
      end
    end
end

