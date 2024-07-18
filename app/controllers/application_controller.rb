class ApplicationController < ActionController::Base

    protect_from_forgery with: :exception

    def current_user
      token = cookies.signed[:session_token]
      if token
        session = Session.find_by(token: token)
        @current_user ||= Admin.find(session.user_id) if session
      end

    end
  
    helper_method :current_user
  
    def authenticate_user!
      unless current_user
        redirect_to new_login_path, notice: "Please log in"
      end
    end
end