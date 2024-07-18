class LoginController < ApplicationController
    def new 
    end 

    def create
        user =  Admin.find_by(name: login_params[:name])

        if user && user.authenticate(login_params[:password])
            
            token = SecureRandom.hex()
            session = Session.create(user_id: user.id, token:token)
            cookies.signed[:session_token] = { value: token, httponly: true, secure: Rails.env.production? }
            redirect_to pages_path, notice: "Login Successfully"
            # render json: {token:token, user_id: session[:user_id]}
        else 
            render :new, notice: "login failed"
        end 
    end 

    def destroy 
        session = Session.find_by(token: cookies.signed[:session_token])

        if session
          session.destroy
          cookies.delete(:session_token)
          redirect_to root_path, notice: "Logged out successfully"
        else
          redirect_to root_path, notice: "Invalid session token"
        end
    end 

    private

    def login_params
        params.permit(:name, :password)
    end

end